package com.stocksimulator.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/buy")
public class BuyServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int stockId =
                Integer.parseInt(request.getParameter("stockId"));

        response.getWriter()
                .println("Selected Stock ID : " + stockId);
    }
}
