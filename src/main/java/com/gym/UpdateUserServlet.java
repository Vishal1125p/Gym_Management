package com.gym;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE user_register SET username = ?, email = ?, phone = ? WHERE id = ?"
            );
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setInt(4, id);
            int updated = ps.executeUpdate();
            con.close();

            if(updated > 0){
                response.getWriter().write("success");
            } else {
                response.getWriter().write("fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}
