package com.stocksimulator.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    // Hard-coded admin credentials (change as needed)
    private static final String ADMIN_USER = "admin";
    private static final String ADMIN_PASS = "admin123";

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (ADMIN_USER.equals(username) && ADMIN_PASS.equals(password)) {

            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);
            response.sendRedirect("adminDashboard");

        } else {

            request.setAttribute("error", "Invalid admin credentials!");
            request.getRequestDispatcher("admin-login.html")
                   .forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("admin-login.html");
    }
}