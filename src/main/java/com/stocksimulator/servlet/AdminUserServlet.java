package com.stocksimulator.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.AdminDAO;

@WebServlet("/adminUsers")
public class AdminUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        AdminDAO dao = new AdminDAO();
        request.setAttribute("users", dao.getAllUsers());
        request.getRequestDispatcher("admin-users.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        AdminDAO dao  = new AdminDAO();

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteUser(id);

        } else if ("updateBalance".equals(action)) {
            int    id         = Integer.parseInt(request.getParameter("id"));
            double newBalance = Double.parseDouble(request.getParameter("balance"));
            dao.updateUserBalance(id, newBalance);
        }

        response.sendRedirect("adminUsers");
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