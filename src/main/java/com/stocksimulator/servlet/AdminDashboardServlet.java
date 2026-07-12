package com.stocksimulator.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.AdminDAO;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Guard: only admins
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("admin-login.html");
            return;
        }

        AdminDAO dao = new AdminDAO();
        request.setAttribute("totalUsers",       dao.getTotalUsers());
        request.setAttribute("totalStocks",      dao.getTotalStocks());
        request.setAttribute("totalTx",          dao.getTotalTransactions());
        request.setAttribute("tradingVolume",    dao.getTotalTradingVolume());

        request.getRequestDispatcher("admin-dashboard.jsp")
               .forward(request, response);
    }
}