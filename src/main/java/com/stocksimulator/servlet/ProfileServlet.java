package com.stocksimulator.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stocksimulator.dao.UserDAO;
import com.stocksimulator.dao.PortfolioDAO;
import com.stocksimulator.dao.TransactionDAO;

import com.stocksimulator.model.User;
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer userId =
        (Integer) req.getSession().getAttribute("userId");

        if(userId == null){
            resp.sendRedirect("login.html");
            return;
        }

        UserDAO userDAO = new UserDAO();
        PortfolioDAO portfolioDAO = new PortfolioDAO();
        TransactionDAO transactionDAO = new TransactionDAO();

        User user = userDAO.getUserById(userId);

        double portfolioValue =
        portfolioDAO.getPortfolioValue(userId);

        int totalTransactions =
        transactionDAO.getUserTransactions(userId).size();
        
        double netValue =
        		portfolioDAO.getProfitLoss(userId);

        		double profit = 0;
        		double loss = 0;

        		if(netValue >= 0){
        		    profit = netValue;
        		}else{
        		    loss = Math.abs(netValue);
        		}

        		req.setAttribute("profit", profit);
        		req.setAttribute("loss", loss);

        req.setAttribute("user", user);
        req.setAttribute("portfolioValue", portfolioValue);
        req.setAttribute("totalTransactions", totalTransactions);

        req.getRequestDispatcher("profile.jsp")
           .forward(req, resp);
    }
}
