package com.stocksimulator.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/adminLogout")
public class AdminLogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        
    HttpSession session = request.getSession(false);

    if (session != null) {
        session.invalidate();
    }

    response.sendRedirect(request.getContextPath() + "/index.jsp");
}
}