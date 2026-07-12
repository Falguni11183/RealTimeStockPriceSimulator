package com.stocksimulator.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.stocksimulator.model.Portfolio;
import com.stocksimulator.util.DBConnection;

public class PortfolioDAO {

    // BUY / ADD STOCK
    public void addPortfolio(Portfolio p) {
    	System.out.println("ADD PORTFOLIO METHOD CALLED");
        try {
            Connection con = DBConnection.getConnection();

            String sql =
            "INSERT INTO portfolio(user_id, stock_id, quantity, buy_price) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, p.getUserId());
            ps.setInt(2, p.getStockId());
            ps.setInt(3, p.getQuantity());
            ps.setDouble(4, p.getBuyPrice());
            
            int rows = ps.executeUpdate();

            System.out.println("Rows Inserted = " + rows);
            

            
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    // GET USER PORTFOLIO (WITH STOCK DETAILS)
    public List<Portfolio> getUserPortfolio(int userId) {

        List<Portfolio> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT p.*, s.symbol, s.company_name " +
            "FROM portfolio p " +
            "JOIN stocks s ON p.stock_id = s.id " +
            "WHERE p.user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Portfolio p = new Portfolio();

                p.setId(rs.getInt("id"));
                p.setUserId(rs.getInt("user_id"));
                p.setStockId(rs.getInt("stock_id"));
                p.setQuantity(rs.getInt("quantity"));
                p.setBuyPrice(rs.getDouble("buy_price"));

                // extra UI fields
                p.setStockSymbol(rs.getString("symbol"));
                p.setCompanyName(rs.getString("company_name"));

                list.add(p);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public Portfolio getPortfolioById(int id) {

        Portfolio p = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM portfolio WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                p = new Portfolio();
                p.setId(rs.getInt("id"));
                p.setUserId(rs.getInt("user_id"));
                p.setStockId(rs.getInt("stock_id"));
                p.setQuantity(rs.getInt("quantity"));
                p.setBuyPrice(rs.getDouble("buy_price"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return p;
    }
    public void updateQuantity(int id, int qty) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE portfolio SET quantity=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, qty);
            ps.setInt(2, id);

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    public void deletePortfolio(int id) {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM portfolio WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    public double getPortfolioValue(int userId) {

        double total = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT quantity,buy_price FROM portfolio WHERE user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                total += rs.getInt("quantity")
                        * rs.getDouble("buy_price");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return total;
    }
    public double getProfitLoss(int userId) {

        double profitLoss = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT p.quantity, p.buy_price, s.current_price " +
            "FROM portfolio p " +
            "JOIN stocks s ON p.stock_id = s.id " +
            "WHERE p.user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                int qty = rs.getInt("quantity");

                double buyPrice =
                rs.getDouble("buy_price");

                double currentPrice =
                rs.getDouble("current_price");

                profitLoss +=
                (currentPrice - buyPrice) * qty;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return profitLoss;
    }
}