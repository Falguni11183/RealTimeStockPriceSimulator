package com.stocksimulator.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.AdminDAO;
import com.stocksimulator.model.Stock;

@WebServlet("/adminStocks")
public class AdminStockServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        AdminDAO dao = new AdminDAO();
        request.setAttribute("stocks", dao.getAllStocks());
        request.getRequestDispatcher("admin-stocks.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        String action = request.getParameter("action");
        AdminDAO dao  = new AdminDAO();

        if ("add".equals(action)) {
            Stock s = new Stock();
            s.setSymbol(request.getParameter("symbol"));
            s.setCompanyName(request.getParameter("companyName"));
            s.setCurrentPrice(Double.parseDouble(request.getParameter("price")));
            dao.addStock(s);

        } else if ("edit".equals(action)) {
            Stock s = new Stock();
            s.setId(Integer.parseInt(request.getParameter("id")));
            s.setSymbol(request.getParameter("symbol"));
            s.setCompanyName(request.getParameter("companyName"));
            s.setCurrentPrice(Double.parseDouble(request.getParameter("price")));
            dao.updateStock(s);

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteStock(id);
        }

        response.sendRedirect("adminStocks");
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