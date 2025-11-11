package com.admin;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/EditTrainerServlet")
public class EditTrainerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String experience = request.getParameter("experience");
        String specialization = request.getParameter("specialization");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE trainer SET name=?, age=?, gender=?, experience=?, specialization=? WHERE id=?");
            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setString(3, gender);
            ps.setString(4, experience);
            ps.setString(5, specialization);
            ps.setInt(6, id);

            int updated = ps.executeUpdate();
            con.close();

            if (updated > 0) {
                response.sendRedirect("trainer.jsp");
            } else {
                response.getWriter().println("<h3 style='color:red;'>Failed to update trainer!</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
