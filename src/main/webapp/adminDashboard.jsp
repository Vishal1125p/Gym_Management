<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym | Admin Dashboard</title>

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    ::-webkit-scrollbar { width: 6px; }
    ::-webkit-scrollbar-thumb { background: #0284c7; border-radius: 10px; } /* Sky Blue Scrollbar */
  </style>
</head>
<body class="bg-white text-gray-900 font-[Poppins]">

  <!-- Sidebar Include -->
  <jsp:include page="sidebar.jsp"></jsp:include>

  <div class="ml-64 flex flex-col min-h-screen">

    <!-- Header -->
    <header class="bg-sky-600 shadow-md sticky top-0 z-50 flex items-center justify-between px-10 py-4 border-b border-sky-700">
      <h2 class="text-2xl font-bold text-white flex items-center gap-2">
        <i class="fa-solid fa-gauge-high"></i> Admin Dashboard
      </h2>

      <%
        String adminEmail = (String) session.getAttribute("adminEmail");
      %>

      <div class="flex items-center space-x-4">
        <span class="text-white">
          Welcome, <b><%= (adminEmail != null) ? adminEmail : "Admin" %></b>
        </span>
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
             alt="Admin"
             class="w-11 h-11 rounded-full border-2 border-white shadow-lg">
      </div>
    </header>

    <!-- Dashboard Content -->
    <main class="flex-1 p-10 bg-white">

      <%
        int trainerCount = 0, memberCount = 0, equipmentCount = 0;
        double totalRevenue = 0.0;
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");
            st = con.createStatement();

            rs = st.executeQuery("SELECT COUNT(*) FROM trainer");
            if(rs.next()) trainerCount = rs.getInt(1);
            rs.close();

            rs = st.executeQuery("SELECT COUNT(*) FROM members");
            if(rs.next()) memberCount = rs.getInt(1);
            rs.close();

            rs = st.executeQuery("SELECT COUNT(*) FROM equipment");
            if(rs.next()) equipmentCount = rs.getInt(1);
            rs.close();

            rs = st.executeQuery("SELECT SUM(plan_price) FROM members");
            if(rs.next()) totalRevenue = rs.getDouble(1);

        } catch(Exception e) {
            out.println("<!-- Error fetching counts: " + e.getMessage() + " -->");
        } finally {
            try { if(rs != null) rs.close(); if(st != null) st.close(); if(con != null) con.close(); } catch(Exception ex) {}
        }
      %>

      <!-- Stats Section -->
      <section class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 mt-6">

        <!-- Total Members -->
        <a href="user/members.jsp"
           class="bg-sky-600 p-6 rounded-2xl shadow-lg hover:shadow-sky-500/20 transition transform hover:-translate-y-1 block">
          <div class="flex justify-between items-center">
            <div>
              <h3 class="text-white text-sm uppercase tracking-wide">Total Members</h3>
              <p class="text-3xl font-bold text-white mt-2"><%= memberCount %></p>
            </div>
            <i class="fa-solid fa-users text-4xl text-white"></i>
          </div>
        </a>

        <!-- Trainers -->
        <a href="trainer.jsp"
           class="bg-sky-600 p-6 rounded-2xl shadow-lg hover:shadow-sky-500/20 transition transform hover:-translate-y-1 block">
          <div class="flex justify-between items-center">
            <div>
              <h3 class="text-white text-sm uppercase tracking-wide">Trainers</h3>
              <p class="text-3xl font-bold text-white mt-2"><%= trainerCount %></p>
            </div>
            <i class="fa-solid fa-dumbbell text-4xl text-white"></i>
          </div>
        </a>

        <!-- Total Revenue -->
        <div class="bg-sky-600 p-6 rounded-2xl shadow-lg hover:shadow-sky-500/20 transition transform hover:-translate-y-1">
          <div class="flex justify-between items-center">
            <div>
              <h3 class="text-white text-sm uppercase tracking-wide">Total Revenue</h3>
              <p class="text-3xl font-bold text-white mt-2">₹<%= String.format("%.2f", totalRevenue) %></p>
            </div>
            <i class="fa-solid fa-wallet text-4xl text-white"></i>
          </div>
        </div>

        <!-- Equipment -->
        <a href="equipment.jsp"
           class="bg-sky-600 p-6 rounded-2xl shadow-lg hover:shadow-sky-500/20 transition transform hover:-translate-y-1 block">
          <div class="flex justify-between items-center">
            <div>
              <h3 class="text-white text-sm uppercase tracking-wide">Equipment</h3>
              <p class="text-3xl font-bold text-white mt-2"><%= equipmentCount %></p>
            </div>
            <i class="fa-solid fa-weight-hanging text-4xl text-white"></i>
          </div>
        </a>

      </section>

      <!-- Recent Members Table -->
      <section class="mt-14">
        <h2 class="text-2xl font-semibold text-sky-600 mb-6 flex items-center gap-2">
          <i class="fa-solid fa-user-clock"></i> Recent Members
        </h2>

        <div class="overflow-hidden rounded-xl shadow-lg border border-sky-600">
          <table class="w-full text-left border-collapse">
            <thead class="bg-sky-600 text-white uppercase text-sm">
              <tr>
                <th class="py-4 px-6">Name</th>
                <th class="py-4 px-6">Membership</th>
                <th class="py-4 px-6">Join Date</th>
                <th class="py-4 px-6">Status</th>
              </tr>
            </thead>
            <tbody>
              <%
                Connection con2 = null;
                PreparedStatement pst2 = null;
                ResultSet rs2 = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/Gym_management","root","Vishu@1125");

                    String query = "SELECT name, plan_name, join_date FROM members ORDER BY join_date DESC LIMIT 3";
                    pst2 = con2.prepareStatement(query);
                    rs2 = pst2.executeQuery();

                    java.time.LocalDate today = java.time.LocalDate.now();

                    while(rs2.next()) {
                        String name = rs2.getString("name");
                        String plan = rs2.getString("plan_name");
                        java.sql.Date joinDateSQL = rs2.getDate("join_date");
                        java.time.LocalDate joinDate = joinDateSQL.toLocalDate();

                        java.time.Period diff = java.time.Period.between(joinDate, today);
                        boolean isActive = diff.getDays() < 30 && diff.getMonths() == 0;

                        String status = isActive ? "Active" : "Expired";
                        String statusColor = isActive ? "text-green-600" : "text-red-600";
              %>
                      <tr class="bg-white hover:bg-sky-50 transition">
                        <td class="py-4 px-6"><%= name %></td>
                        <td class="py-4 px-6"><%= plan %></td>
                        <td class="py-4 px-6"><%= joinDate %></td>
                        <td class="py-4 px-6 font-semibold <%= statusColor %>"><%= status %></td>
                      </tr>
              <%
                    }
                } catch (Exception e) {
              %>
                  <tr>
                    <td colspan="4" class="text-center text-sky-600 py-4">Error: <%= e.getMessage() %></td>
                  </tr>
              <%
                } finally {
                    try { if(rs2 != null) rs2.close(); if(pst2 != null) pst2.close(); if(con2 != null) con2.close(); } catch(Exception ex) {}
                }
              %>
            </tbody>
          </table>
        </div>
      </section>

    </main>
  </div>
</body>
</html>
