package com.stocksimulator.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.stocksimulator.model.Stock;
import com.stocksimulator.util.DBConnection;

public class StockDAO {

    public List<Stock> getAllStocks() {

        List<Stock> stocks = new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql = "SELECT * FROM stocks";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Stock stock = new Stock();

                stock.setId(rs.getInt("id"));
                stock.setSymbol(rs.getString("symbol"));
                stock.setCompanyName(rs.getString("company_name"));
                stock.setCurrentPrice(rs.getDouble("current_price"));
                stock.setChangePercent(rs.getDouble("change_percent"));

                stocks.add(stock);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return stocks;
    }
    public List<Stock> searchStocks(String keyword) {
    	 
        List<Stock> stocks = new ArrayList<>();
 
        try {
            Connection con = DBConnection.getConnection();
 
            // LIKE search on both symbol and company_name (case-insensitive)
            String sql = "SELECT * FROM stocks " +
                         "WHERE symbol LIKE ? OR company_name LIKE ? " +
                         "ORDER BY symbol";
 
            PreparedStatement ps = con.prepareStatement(sql);
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
 
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stocks.add(mapRow(rs));
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return stocks;
    }
 
    // ── NEW: Top Gainers (highest change_percent) ────────────────────────────
    public List<Stock> getTopGainers(int limit) {
 
        List<Stock> stocks = new ArrayList<>();
 
        try {
            Connection con = DBConnection.getConnection();
 
            String sql = "SELECT * FROM stocks " +
                         "WHERE change_percent > 0 " +
                         "ORDER BY change_percent DESC " +
                         "LIMIT ?";
 
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, limit);
 
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stocks.add(mapRow(rs));
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return stocks;
    }
 
    // ── NEW: Top Losers (lowest / most-negative change_percent) ─────────────
    public List<Stock> getTopLosers(int limit) {
 
        List<Stock> stocks = new ArrayList<>();
 
        try {
            Connection con = DBConnection.getConnection();
 
            String sql = "SELECT * FROM stocks " +
                         "WHERE change_percent < 0 " +
                         "ORDER BY change_percent ASC " +
                         "LIMIT ?";
 
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, limit);
 
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stocks.add(mapRow(rs));
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
 
        return stocks;
    }
 
    // ── Helper: map a ResultSet row to a Stock object ─────────────────────────
    private Stock mapRow(ResultSet rs) throws SQLException {
        Stock stock = new Stock();
        stock.setId(rs.getInt("id"));
        stock.setSymbol(rs.getString("symbol"));
        stock.setCompanyName(rs.getString("company_name"));
        stock.setCurrentPrice(rs.getDouble("current_price"));
        stock.setChangePercent(rs.getDouble("change_percent"));
        return stock;
    }
}