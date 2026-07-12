package com.stocksimulator.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.stocksimulator.simulator.StockPriceUpdater;

@WebListener
public class AppListener implements ServletContextListener {

    @Override
    public void contextInitialized(
            ServletContextEvent sce) {

        StockPriceUpdater.startSimulation();

        System.out.println("Stock Simulator Started");
    }

    @Override
    public void contextDestroyed(
            ServletContextEvent sce) {

    }
}
