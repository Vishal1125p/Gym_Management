package com.admin;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddTrainerServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  
                 maxFileSize = 1024 * 1024 * 10,       
                 maxRequestSize = 1024 * 1024 * 50)    
public class AddTrainerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String experience = request.getParameter("experience");
        String specialization = request.getParameter("specialization");

        Part filePart = request.getPart("photo");
        String fileName = filePart.getSubmittedFileName();

        // Define upload path
        String uploadPath = getServletContext().getRealPath("") + "trainer_images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // Save the uploaded file
        filePart.write(uploadPath + File.separator + fileName);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO trainer (name, age, gender, experience, specialization, photo) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setString(3, gender);
            ps.setString(4, experience);
            ps.setString(5, specialization);
            ps.setString(6, "trainer_images/" + fileName);

            ps.executeUpdate();
            con.close();

            response.sendRedirect("trainer.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
}
