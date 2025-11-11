package com.admin;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");

            
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            
            String query = "SELECT * FROM Admin WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                
                HttpSession session = request.getSession();
                session.setAttribute("adminEmail", email);
                response.sendRedirect("adminDashboard.jsp");
            } else {
                // ❌ Invalid credentials
                out.println("<h3 style='color:red; text-align:center;'>Invalid Email or Password!</h3>");
                out.println("<div style='text-align:center;'><a href='adminLogin.jsp'>Try Again</a></div>");
            }

            con.close();

        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }
}
