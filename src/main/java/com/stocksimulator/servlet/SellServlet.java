package com.stocksimulator.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/sell")
public class SellServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int stockId =
            Integer.parseInt(request.getParameter("stockId"));

        int quantity =
            Integer.parseInt(request.getParameter("quantity"));

        // TODO:
        // Portfolio मधून quantity reduce कर
        // Balance update कर
        // Transaction save कर

        System.out.println(
            "Sold Stock ID: " + stockId +
            " Quantity: " + quantity
        );

        response.sendRedirect("dashboard");
    }
}