<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Attendance - The Royal Gym</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
  body { font-family: 'Poppins', sans-serif; background-color: #f7f7f7; }
  .header { position: fixed; left: 250px; right: 0; top:0; z-index: 40; 
            background-color: #DC2626; color: white; padding: 1rem 2rem; font-weight: bold; 
            display: flex; justify-content: space-between; align-items: center; border-bottom: 3px solid #B91C1C; }
  .main-container { margin-left: 250px; padding-top: 80px; padding: 2rem; }
  table th, table td { padding: 0.75rem; border: 1px solid #B91C1C; text-align: center; }
  table th { background-color: #B91C1C; color: white; }
  .status-present { color: #10B981; font-weight: bold; }
  .status-absent { color: #EF4444; font-weight: bold; }
</style>
</head>
<body>

<jsp:include page="sidebar.jsp"></jsp:include>

<header class="header">
  <h1>Attendance Management</h1>
  <%
      String adminEmail = (String) session.getAttribute("adminEmail");
  %>
  <div class="flex items-center gap-4">
    <span>Welcome, <b><%= (adminEmail != null) ? adminEmail : "Admin" %></b></span>
    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Admin" class="w-10 h-10 rounded-full border-2 border-white">
  </div>
</header>

<div class="main-container">
  <div class="max-w-6xl mx-auto bg-white shadow-xl rounded-2xl p-6">
    <h2 class="text-3xl font-bold text-center text-red-600 mb-6">Today's Attendance</h2>

    <table class="w-full border-collapse">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Role</th>
          <th>Date</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <%
          try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection con = DriverManager.getConnection(
                  "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");
              Statement st = con.createStatement();
              ResultSet rs = st.executeQuery("SELECT * FROM attendance ORDER BY date ASC");

              while (rs.next()) {
                  int id = rs.getInt("id");
                  String name = rs.getString("name");
                  String role = rs.getString("role"); // Member / Trainer
                  java.sql.Date date = rs.getDate("date");
                  String status = rs.getString("status"); // Present / Absent
        %>
        <tr class="hover:bg-red-50">
          <td><%= id %></td>
          <td><%= name %></td>
          <td><%= role %></td>
          <td><%= date %></td>
          <td class="<%= "Present".equals(status) ? "status-present" : "status-absent" %>"><%= status %></td>
        </tr>
        <%
              }
              con.close();
          } catch (Exception e) {
              out.println("<tr><td colspan='5' class='text-center text-red-600'>Error loading data!</td></tr>");
          }
        %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
