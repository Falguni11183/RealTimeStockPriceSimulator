package com.stocksimulator.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.stocksimulator.dao.UserDAO;
import com.stocksimulator.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        UserDAO dao = new UserDAO();

        User user = dao.loginUser(username, password);

        if(user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());

            response.sendRedirect("dashboard");

        } else {

            response.getWriter()
            .println("Invalid Username or Password");

        }
    }
}