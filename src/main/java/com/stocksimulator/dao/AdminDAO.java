package com.stocksimulator.dao;

import java.sql.*;
import java.util.*;

import com.stocksimulator.model.Stock;
import com.stocksimulator.model.Transaction;
import com.stocksimulator.model.User;
import com.stocksimulator.util.DBConnection;

public class AdminDAO {

    // ── STATS for Dashboard ──────────────────────────────────────────────────

    public int getTotalUsers() {
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement(
                "SELECT COUNT(*) FROM users").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalStocks() {
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement(
                "SELECT COUNT(*) FROM stocks").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalTransactions() {
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement(
                "SELECT COUNT(*) FROM transactions").executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public double getTotalTradingVolume() {
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement(
                "SELECT SUM(total) FROM transactions").executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── USER MANAGEMENT ──────────────────────────────────────────────────────

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement(
                "SELECT * FROM users ORDER BY id DESC").executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setBalance(rs.getDouble("balance"));
                list.add(u);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean deleteUser(int userId) {
        try {
            Connection con = DBConnection.getConnection();
            // Delete related records first
            PreparedStatement ps1 = con.prepareStatement(
                "DELETE FROM transactions WHERE user_id=?");
            ps1.setInt(1, userId); ps1.executeUpdate();

            PreparedStatement ps2 = con.prepareStatement(
                "DELETE FROM portfolio WHERE user_id=?");
            ps2.setInt(1, userId); ps2.executeUpdate();

            PreparedStatement ps3 = con.prepareStatement(
                "DELETE FROM users WHERE id=?");
            ps3.setInt(1, userId);
            return ps3.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateUserBalance(int userId, double newBalance) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET balance=? WHERE id=?");
            ps.setDouble(1, newBalance);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ── STOCK MANAGEMENT ─────────────────────────────────────────────────────

    public List<Stock> getAllStocks() {
        List<Stock> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            ResultSet rs = con.prepareStatement(
                "SELECT * FROM stocks ORDER BY symbol").executeQuery();
            while (rs.next()) {
                Stock s = new Stock();
                s.setId(rs.getInt("id"));
                s.setSymbol(rs.getString("symbol"));
                s.setCompanyName(rs.getString("company_name"));
                s.setCurrentPrice(rs.getDouble("current_price"));
                s.setChangePercent(rs.getDouble("change_percent"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean addStock(Stock s) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO stocks(symbol,company_name,current_price,change_percent) VALUES(?,?,?,?)");
            ps.setString(1, s.getSymbol().toUpperCase());
            ps.setString(2, s.getCompanyName());
            ps.setDouble(3, s.getCurrentPrice());
            ps.setDouble(4, 0.0);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateStock(Stock s) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE stocks SET symbol=?,company_name=?,current_price=? WHERE id=?");
            ps.setString(1, s.getSymbol().toUpperCase());
            ps.setString(2, s.getCompanyName());
            ps.setDouble(3, s.getCurrentPrice());
            ps.setInt(4, s.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean deleteStock(int stockId) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM stocks WHERE id=?");
            ps.setInt(1, stockId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ── ALL TRANSACTIONS ─────────────────────────────────────────────────────

    public List<Transaction> getAllTransactions() {
        List<Transaction> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql =
                "SELECT t.*, s.symbol, u.username " +
                "FROM transactions t " +
                "JOIN stocks s ON t.stock_id = s.id " +
                "JOIN users  u ON t.user_id  = u.id " +
                "ORDER BY t.transaction_date DESC";
            ResultSet rs = con.prepareStatement(sql).executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction();
                t.setId(rs.getInt("id"));
                t.setUserId(rs.getInt("user_id"));
                t.setStockId(rs.getInt("stock_id"));
                t.setType(rs.getString("type"));
                t.setQuantity(rs.getInt("quantity"));
                t.setPrice(rs.getDouble("price"));
                t.setTotal(rs.getDouble("total"));
                t.setSymbol(rs.getString("symbol"));
                // store username in symbol field temporarily via subclass is OK
                // instead add a transient field OR use request attr map
                // We'll piggy-back username as a note below in JSP via separate query
                // Better: we add username to Transaction temporarily
                t.setUsername(rs.getString("username")); // see note below
                list.add(t);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}