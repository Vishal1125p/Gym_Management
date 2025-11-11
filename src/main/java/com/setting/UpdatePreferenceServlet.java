package com.setting;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdatePreferenceServlet")
public class UpdatePreferenceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        boolean notifications = request.getParameter("notifications") != null;
        boolean darkmode = request.getParameter("darkmode") != null;
        boolean backup = request.getParameter("backup") != null;

        try (Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125")) {

            PreparedStatement ps = con.prepareStatement(
                "UPDATE admin_settings SET notifications=?, dark_mode=?, backup=? WHERE id=1");
            ps.setBoolean(1, notifications);
            ps.setBoolean(2, darkmode);
            ps.setBoolean(3, backup);
            ps.executeUpdate();

            response.sendRedirect("settings.jsp?pref=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("settings.jsp?pref=error");
        }
    }
}
