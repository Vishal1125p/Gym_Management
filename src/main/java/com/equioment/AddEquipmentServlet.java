package com.equioment;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddEquipmentServlet")
public class AddEquipmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String purchaseDate = request.getParameter("purchase_date");
        String condition = request.getParameter("condition_status");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO equipment(name, category, purchase_date, condition_status, quantity, price) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, category);
            ps.setString(3, purchaseDate);
            ps.setString(4, condition);
            ps.setInt(5, quantity);
            ps.setDouble(6, price);
            ps.executeUpdate();

            con.close();

            response.sendRedirect("equipment.jsp?success=1");
        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
