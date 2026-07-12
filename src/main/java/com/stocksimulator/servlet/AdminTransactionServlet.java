package com.stocksimulator.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.AdminDAO;

@WebServlet("/adminTransactions")
public class AdminTransactionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        AdminDAO dao = new AdminDAO();
        request.setAttribute("transactions", dao.getAllTransactions());
        request.getRequestDispatcher("admin-transactions.jsp")
               .forward(request, response);
    }

    private boolean isAdmin(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("adminUser") == null) {
            res.sendRedirect("admin-login.html");
            return false;
        }
        return true;
    }
}