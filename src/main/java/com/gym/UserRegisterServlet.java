package com.gym;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");

        if (!password.equals(confirmPassword)) {
            out.println("<h3 style='color:red;'>❌ Passwords do not match!</h3>");
            out.println("<a href='userRegister.jsp'>Try Again</a>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            PreparedStatement checkEmail = con.prepareStatement(
                    "SELECT * FROM user_register WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet rs = checkEmail.executeQuery();

            if (rs.next()) {
                out.println("<h3 style='color:red;'>❌ Email already registered!</h3>");
                out.println("<a href='userRegister.jsp'>Try Again</a>");
            } else {
                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO user_register(username, email, password, phone) VALUES (?, ?, ?, ?)");

                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, phone);

                int row = ps.executeUpdate();

                if (row > 0) {
                    response.sendRedirect("index.jsp?registered=true");
                } else {
                    out.println("<h2 style='color:red;'>❌ Registration Failed!</h2>");
                }
            }

            con.close();
        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }
}
