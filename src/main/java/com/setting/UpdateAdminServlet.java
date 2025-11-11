package com.setting;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateAdminServlet")
public class UpdateAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String profile = request.getParameter("profile");

        try (Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125")) {

            PreparedStatement ps = con.prepareStatement(
                "UPDATE admin_settings SET name=?, email=?, phone=?, profile_url=? WHERE id=1");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, profile);

            int rows = ps.executeUpdate();
            response.sendRedirect("settings.jsp?success=" + (rows > 0));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("settings.jsp?error=1");
        }
    }
}
