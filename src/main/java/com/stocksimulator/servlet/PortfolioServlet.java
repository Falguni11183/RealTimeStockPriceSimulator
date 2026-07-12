package com.stocksimulator.servlet;
import com.stocksimulator.dao.TransactionDAO;
import com.stocksimulator.model.Transaction;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.stocksimulator.dao.PortfolioDAO;
import com.stocksimulator.model.Portfolio;

@WebServlet("/portfolio")
public class PortfolioServlet extends HttpServlet {

    private PortfolioDAO dao = new PortfolioDAO();
    TransactionDAO transactionDAO = new TransactionDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("portfolio.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if(action == null) {
            resp.sendRedirect("dashboard.jsp");
            return;
        }

        switch(action) {

            case "buy":
                buyStock(req, resp);
                break;

            case "sell":
                sellStock(req, resp);
                break;

            default:
                resp.sendRedirect("dashboard.jsp");
        }
    }

    // ================= BUY STOCK =================
    private void buyStock(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
    	System.out.println("========== BUY CALLED ==========");
        try {
        	System.out.println("BUY METHOD CALLED");

        	System.out.println("userId = " + req.getParameter("userId"));
        	System.out.println("stockId = " + req.getParameter("stockId"));
        	System.out.println("quantity = " + req.getParameter("quantity"));
        	System.out.println("buyPrice = " + req.getParameter("buyPrice"));
        	
            int userId = Integer.parseInt(req.getParameter("userId"));
            int stockId = Integer.parseInt(req.getParameter("stockId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            double buyPrice = Double.parseDouble(req.getParameter("buyPrice"));

            Portfolio p = new Portfolio();
            p.setUserId(userId);
            p.setStockId(stockId);
            p.setQuantity(quantity);
            p.setBuyPrice(buyPrice);

            dao.addPortfolio(p);
            
            Transaction t = new Transaction();

            t.setUserId(userId);
            t.setStockId(stockId);
            t.setType("BUY");
            t.setQuantity(quantity);
            t.setPrice(buyPrice);
            t.setTotal(quantity * buyPrice);

            transactionDAO.addTransaction(t);
            
            resp.getWriter().println("BUY METHOD CALLED");
            resp.sendRedirect("portfolio.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    // ================= SELL STOCK =================
    private void sellStock(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            int portfolioId = Integer.parseInt(req.getParameter("portfolioId"));
            int quantityToSell = Integer.parseInt(req.getParameter("quantity"));

            // simple logic (you can improve later)
            // for now: we just reduce or delete

            Portfolio existing = dao.getPortfolioById(portfolioId);

            if(existing == null) {
                resp.sendRedirect("portfolio.jsp");
                return;
            }

            int remainingQty = existing.getQuantity() - quantityToSell;
            Transaction t = new Transaction();

            t.setUserId(existing.getUserId());
            t.setStockId(existing.getStockId());
            t.setType("SELL");
            t.setQuantity(quantityToSell);
            t.setPrice(existing.getBuyPrice());
            t.setTotal(quantityToSell * existing.getBuyPrice());

            transactionDAO.addTransaction(t);

            if(remainingQty <= 0) {
                dao.deletePortfolio(portfolioId);
            } else {
                dao.updateQuantity(portfolioId, remainingQty);
            }

            resp.sendRedirect("portfolio.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
