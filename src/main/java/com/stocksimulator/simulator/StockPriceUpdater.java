package com.stocksimulator.simulator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.stocksimulator.util.DBConnection;

public class StockPriceUpdater {

    private static ScheduledExecutorService scheduler =
            Executors.newScheduledThreadPool(1);

    public static void startSimulation() {

        scheduler.scheduleAtFixedRate(() -> {

            try {

                Connection con =
                        DBConnection.getConnection();

                String selectSql =
                        "SELECT id,current_price FROM stocks";

                PreparedStatement ps =
                        con.prepareStatement(selectSql);

                ResultSet rs =
                        ps.executeQuery();

                Random random = new Random();

                while(rs.next()) {

                    int id = rs.getInt("id");

                    double currentPrice =
                            rs.getDouble("current_price");

                    double change =
                            (random.nextDouble()*10)-5;

                    double newPrice =
                            currentPrice + change;

                    if(newPrice < 1) {
                        newPrice = 1;
                    }

                    double percent =
                            (change/currentPrice)*100;

                    String updateSql =
                            "UPDATE stocks SET current_price=?, change_percent=? WHERE id=?";

                    PreparedStatement updatePs =
                            con.prepareStatement(updateSql);

                    updatePs.setDouble(1, newPrice);
                    updatePs.setDouble(2, percent);
                    updatePs.setInt(3, id);

                    updatePs.executeUpdate();
                }

                System.out.println("Prices Updated");

            } catch(Exception e) {
                e.printStackTrace();
            }

        },0,3,TimeUnit.SECONDS);
    }
}