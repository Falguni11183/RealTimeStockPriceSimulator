package com.stocksimulator.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.StockDAO;
import com.stocksimulator.model.Stock;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        StockDAO dao = new StockDAO();

        List<Stock> stockList =
                dao.getAllStocks();

        request.setAttribute("stocks", stockList);

        request.getRequestDispatcher("dashboard.jsp")
               .forward(request, response);
    }
}