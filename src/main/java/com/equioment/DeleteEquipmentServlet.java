package com.equioment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteEquipmentServlet")
public class DeleteEquipmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

                PreparedStatement ps = con.prepareStatement("DELETE FROM equipment WHERE id=?");
                ps.setInt(1, id);
                int deleted = ps.executeUpdate();

                con.close();

                if (deleted > 0) {
                    response.sendRedirect("equipment.jsp");
                } else {
                    response.getWriter().println("<h3 style='color:red;'>Equipment not found!</h3>");
                }

            } catch (Exception e) {
                response.getWriter().println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            }
        } else {
            response.getWriter().println("<h3 style='color:red;'>Invalid Equipment ID!</h3>");
        }
    }
}
