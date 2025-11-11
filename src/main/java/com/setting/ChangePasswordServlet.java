package com.setting;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try (Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125")) {

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT password FROM admin_settings WHERE id=1");

            if (rs.next()) {
                String storedPass = rs.getString("password");
                if (!storedPass.equals(currentPassword)) {
                    response.sendRedirect("settings.jsp?msg=wrongCurrent");
                    return;
                }
                if (!newPassword.equals(confirmPassword)) {
                    response.sendRedirect("settings.jsp?msg=mismatch");
                    return;
                }

                PreparedStatement ps = con.prepareStatement(
                    "UPDATE admin_settings SET password=? WHERE id=1");
                ps.setString(1, newPassword);
                ps.executeUpdate();
                response.sendRedirect("settings.jsp?msg=success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("settings.jsp?msg=error");
        }
    }
}
