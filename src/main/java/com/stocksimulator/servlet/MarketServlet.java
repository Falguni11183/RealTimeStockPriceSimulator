package com.stocksimulator.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.StockDAO;
import com.stocksimulator.model.Stock;

@WebServlet("/market")
public class MarketServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        StockDAO dao = new StockDAO();

        // Get search query (empty string if not provided)
        String query = request.getParameter("query");
        if (query == null) query = "";
        query = query.trim();

        List<Stock> searchResults;
        if (query.isEmpty()) {
            searchResults = dao.getAllStocks();
        } else {
            searchResults = dao.searchStocks(query);
        }

        List<Stock> topGainers = dao.getTopGainers(5);
        List<Stock> topLosers  = dao.getTopLosers(5);

        request.setAttribute("searchResults", searchResults);
        request.setAttribute("topGainers",    topGainers);
        request.setAttribute("topLosers",     topLosers);
        request.setAttribute("query",         query);

        request.getRequestDispatcher("market.jsp")
               .forward(request, response);
    }
}