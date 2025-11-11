<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Contact Messages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- ✅ Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        header {
            position: fixed;
            top: 0;
            left: 250px;
            right: 0;
            height: 70px;
            background-color: #0284c7;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            z-index: 1000;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .content-wrapper {
            margin-top: 90px;
            width: 70%;
            margin-right: 2%;
        }

        .table-container {
            max-height: 500px;
            overflow-y: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        table {
            margin-bottom: 0;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <jsp:include page="sidebar.jsp"></jsp:include>

    <!-- Header -->
    <header >
        <h2 class="m-0 d-flex align-items-center gap-2">
            <!-- 🔄 Changed Icon -->
            <i class="fa-solid fa-envelope"></i> Contact Messages
        </h2>

        <% String adminEmail = (String) session.getAttribute("adminEmail"); %>
        <div class="d-flex align-items-center gap-3">
            <span>
                Welcome, <b><%= (adminEmail != null) ? adminEmail : "Admin" %></b>
            </span>
            <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
                 alt="Admin" class="rounded-circle border border-white"
                 style="width:45px;height:45px;">
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <div class="content-wrapper">
            <div class="table-container mt-3">
                <table class="table table-bordered table-striped align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Message</th>
                        <th>Sent At</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        String dbURL = "jdbc:mysql://localhost:3306/gym_management";
                        String dbUser = "root";
                        String dbPassword = "Vishu@1125";

                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                            String sql = "SELECT * FROM contact_messages ORDER BY id DESC";
                            ps = con.prepareStatement(sql);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String name = rs.getString("name");
                                String email = rs.getString("email");
                                String subject = rs.getString("subject");
                                String message = rs.getString("message");
                                Timestamp sentAt = rs.getTimestamp("date_sent");
                    %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= name %></td>
                        <td><%= email %></td>
                        <td><%= subject %></td>
                        <td><%= message %></td>
                        <td><%= sentAt %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <tr>
                        <td colspan="6" class="text-center text-danger">Error fetching data!</td>
                    </tr>
                    <%
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (ps != null) ps.close(); } catch (Exception e) {}
                            try { if (con != null) con.close(); } catch (Exception e) {}
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
