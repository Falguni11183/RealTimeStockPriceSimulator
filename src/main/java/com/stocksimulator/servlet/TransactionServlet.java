package com.stocksimulator.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.TransactionDAO;
import com.stocksimulator.model.Transaction;

@WebServlet("/transactions")
public class TransactionServlet extends HttpServlet {

    private TransactionDAO dao = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    	HttpSession session = req.getSession();
    	Integer userId = (Integer) session.getAttribute("userId");
        if(userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<Transaction> list = dao.getUserTransactions(userId);
        System.out.println("Records = " + list.size());

        req.setAttribute("transactions", list);

        req.getRequestDispatcher("transactions.jsp")
           .forward(req, resp);
    }
}