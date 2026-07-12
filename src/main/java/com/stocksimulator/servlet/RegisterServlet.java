package com.stocksimulator.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.stocksimulator.dao.UserDAO;
import com.stocksimulator.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        User user = new User();

        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);

        UserDAO dao = new UserDAO();

        if(dao.registerUser(user)) {

            response.sendRedirect("login.html");

        } else {

            response.getWriter()
            .println("Registration Failed");
        }
    }
}
