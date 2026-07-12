package com.stocksimulator.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.stocksimulator.model.User;
import com.stocksimulator.util.DBConnection;

public class UserDAO {

    public boolean registerUser(User user) {

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "INSERT INTO users(username,email,password,balance) VALUES(?,?,?,?)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setDouble(4, 100000);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public User loginUser(String username, String password) {

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT * FROM users WHERE username=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setBalance(rs.getDouble("balance"));

                return user;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public User getUserById(int id) {

        User user = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setBalance(rs.getDouble("balance"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}