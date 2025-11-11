package com.membership;

import java.io.*;
import java.sql.*;
import java.time.*;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/MemberRegisterServlet")
public class MemberRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String city = request.getParameter("city");
        String planName = request.getParameter("plan_name");
        String planPrice = request.getParameter("plan_price");
        String joinDateStr = request.getParameter("join_date");

        LocalDate joinDate = LocalDate.parse(joinDateStr);
        LocalDate expiryDate = joinDate;

        switch (planName.toUpperCase()) {
            case "ANNUAL":
                expiryDate = joinDate.plusYears(1);
                break;
            case "HALF YEARLY":
                expiryDate = joinDate.plusMonths(6);
                break;
            case "QUARTERLY":
                expiryDate = joinDate.plusMonths(3);
                break;
            case "MONTHLY":
                expiryDate = joinDate.plusMonths(1);
                break;
        }

        String status = LocalDate.now().isBefore(expiryDate) ? "ACTIVE" : "EXPIRED";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            String sql = "INSERT INTO members(name, email, mobile, city, plan_name, plan_price, join_date, expiry_date, status) VALUES (?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, city);
            ps.setString(5, planName);
            ps.setString(6, planPrice);
            ps.setDate(7, Date.valueOf(joinDate));
            ps.setDate(8, Date.valueOf(expiryDate));
            ps.setString(9, status);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // ✅ Send Email Receipt
                sendEmailReceipt(email, name, planName, planPrice, joinDate, expiryDate);

                out.println("<html><head>");
                out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                out.println("</head><body>");
                out.println("<script>");
                out.println("Swal.fire({");
                out.println("  title: 'Payment Successful 💳',");
                out.println("  html: 'Your <b>" + planName + "</b> plan has been activated!<br>Receipt sent to <b>" + email + "</b><br>Valid till <b>" + expiryDate + "</b>',");
                out.println("  icon: 'success',");
                out.println("  showConfirmButton: false,");
                out.println("  timer: 4000,");
                out.println("  background: '#0f172a',");
                out.println("  color: '#facc15'");
                out.println("});");
                out.println("setTimeout(() => { window.location='" + request.getContextPath() + "/index.jsp'; }, 4000);");
                out.println("</script>");
                out.println("</body></html>");
            } else {
                out.println("<html><head><script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
                out.println("<script>");
                out.println("Swal.fire({ title: 'Registration Failed ❌', text: 'Please try again later.', icon: 'error', background: '#1e293b', color: '#fff' });");
                out.println("setTimeout(() => { history.back(); }, 3000);");
                out.println("</script></body></html>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<html><head><script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
            out.println("<script>");
            out.println("Swal.fire({ title: '⚠️ Error Occurred', text: '" + e.getMessage().replace("'", "\\'") + "', icon: 'error', background: '#1e293b', color: '#fff' });");
            out.println("</script></body></html>");
        }
    }

   
    private void sendEmailReceipt(String toEmail, String name, String plan, String price, LocalDate joinDate, LocalDate expiryDate) {
        final String fromEmail = "vishalpatil40802@gmail.com";
        final String appPassword = "mxex rgmi fwga nhwl"; 

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "The Royal Gym"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("💪 The Royal Gym - Membership Receipt");

           
            String htmlContent =
                    "<div style='font-family:Arial, sans-serif; background-color:#f5f5f5; padding:20px;'>"
                            + "<div style='max-width:600px; margin:auto; background-color:white; border-radius:10px; overflow:hidden; box-shadow:0 4px 10px rgba(0,0,0,0.1);'>"
                            + "<div style='background-color:#d97706; color:white; text-align:center; padding:15px;'>"
                            + "<h2 style='margin:0;'>The Royal Gym</h2>"
                            + "<p style='margin:5px 0 0 0;'>Membership Receipt</p>"
                            + "</div>"

                            + "<div style='padding:20px;'>"
                            + "<p>Hi <b>" + name + "</b>,</p>"
                            + "<p>Thank you for joining <b>The Royal Gym</b>! Here are your membership details:</p>"

                            + "<table style='width:100%; border-collapse:collapse; margin-top:15px;'>"
                            + "<tr style='background-color:#f3f4f6;'>"
                            + "<th style='border:1px solid #ddd; padding:10px; text-align:left;'>Field</th>"
                            + "<th style='border:1px solid #ddd; padding:10px; text-align:left;'>Details</th>"
                            + "</tr>"

                            + "<tr><td style='border:1px solid #ddd; padding:10px;'>Member Name</td>"
                            + "<td style='border:1px solid #ddd; padding:10px;'>" + name + "</td></tr>"

                            + "<tr><td style='border:1px solid #ddd; padding:10px;'>Plan</td>"
                            + "<td style='border:1px solid #ddd; padding:10px;'>" + plan + "</td></tr>"

                            + "<tr><td style='border:1px solid #ddd; padding:10px;'>Price</td>"
                            + "<td style='border:1px solid #ddd; padding:10px;'>₹" + price + "</td></tr>"

                            + "<tr><td style='border:1px solid #ddd; padding:10px;'>Join Date</td>"
                            + "<td style='border:1px solid #ddd; padding:10px;'>" + joinDate + "</td></tr>"

                            + "<tr><td style='border:1px solid #ddd; padding:10px;'>Expiry Date</td>"
                            + "<td style='border:1px solid #ddd; padding:10px; color:green; font-weight:bold;'>" + expiryDate + "</td></tr>"
                            + "</table>"

                            + "<p style='margin-top:20px; color:green; font-weight:bold;'>Your plan is now ACTIVE! 💪</p>"
                            + "<p>We’re excited to have you onboard. Keep training hard and stay strong!</p>"
                            + "<p style='margin-top:25px;'>— The Royal Gym Team</p>"
                            + "</div>"

                            + "<div style='background-color:#1e293b; color:white; text-align:center; padding:10px; font-size:13px;'>"
                            + "© 2025 The Royal Gym | Stay Fit. Stay Strong."
                            + "</div>"
                            + "</div>"
                            + "</div>";

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
            System.out.println("✅ Email sent successfully to " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
