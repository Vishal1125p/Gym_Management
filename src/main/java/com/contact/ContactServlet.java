package com.contact;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/contactForm")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/gym_management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Vishu@1125";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

                String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, subject);
                ps.setString(4, message);

                int result = ps.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("contact.jsp?success=1");
                } else {
                    response.sendRedirect("contact.jsp?error=1");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("contact.jsp?error=1");
        }
    }
}