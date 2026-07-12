package com.stocksimulator.dao;
import java.util.List;
import java.util.ArrayList;
import com.stocksimulator.model.Transaction;
import com.stocksimulator.util.DBConnection;
import java.sql.*;

public class TransactionDAO {

    public void addTransaction(Transaction t) {

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "INSERT INTO transactions(user_id,stock_id,type,quantity,price,total) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, t.getUserId());
            ps.setInt(2, t.getStockId());
            ps.setString(3, t.getType());
            ps.setInt(4, t.getQuantity());
            ps.setDouble(5, t.getPrice());
            ps.setDouble(6, t.getTotal());

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    public List<Transaction> getUserTransactions(int userId){

        List<Transaction> list = new ArrayList<>();

        try{

            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT t.*, s.symbol " +
            "FROM transactions t " +
            "JOIN stocks s ON t.stock_id=s.id " +
            "WHERE t.user_id=? " +
            "ORDER BY t.transaction_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Transaction t = new Transaction();

                t.setId(rs.getInt("id"));
                t.setUserId(rs.getInt("user_id"));
                t.setStockId(rs.getInt("stock_id"));
                t.setType(rs.getString("type"));
                t.setQuantity(rs.getInt("quantity"));
                t.setPrice(rs.getDouble("price"));
                t.setTotal(rs.getDouble("total"));

                t.setSymbol(rs.getString("symbol"));

                list.add(t);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}