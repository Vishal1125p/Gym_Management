package com.admin;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteTrainerServlet")
public class DeleteTrainerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            PreparedStatement ps = con.prepareStatement("DELETE FROM trainer WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();
            response.sendRedirect("trainer.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
