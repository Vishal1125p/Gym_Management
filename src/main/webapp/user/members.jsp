<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Members - The Royal Gym</title>

<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
  body {
    font-family: 'Poppins', sans-serif;
    background-color: #F0F9FF; /* light skyblue background */
  }

  /* Sidebar */
  .sidebar {
    width: 250px;
    position: fixed;
    top: 0; left: 0;
    height: 100%;
    background: linear-gradient(to bottom, #0284C7, #38BDF8); /* skyblue gradient */
    color: #fff;
    flex-direction: column;
    justify-content: space-between;
    padding: 1.5rem;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    z-index: 50;
  }
  .sidebar h2 {
    text-align: center;
    font-size: 1.8rem;
    font-weight: bold;
    margin-bottom: 2rem;
    background-color: rgba(255,255,255,0.1);
    padding: 10px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    letter-spacing: 1px;
  }
  .sidebar a {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 0.75rem 1rem;
    color: #fff;
    font-weight: 500;
    border-radius: 0.75rem;
    margin-bottom: 0.5rem;
    transition: all 0.3s ease;
  }
  .sidebar a:hover {
    background-color: rgba(255,255,255,0.2);
    transform: translateX(5px);
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
  }
  .sidebar .logout-btn {
    display: block;
    text-align: center;
    background-color: #fff;
    color: #0284C7;
    font-weight: 600;
    padding: 0.75rem;
    border-radius: 0.75rem;
    margin-top: 2rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
  }
  .sidebar .logout-btn:hover {
    background-color: #0284C7;
    color: #fff;
    transform: translateY(-2px);
  }

  /* Header */
  .header {
    position: fixed;
    top: 0;
    left: 250px; /* sidebar width */
    right: 0;
    color: white;
    padding: 1rem 2rem;
    font-size: 1.5rem;
    font-weight: bold;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 40;
    border-bottom: 3px solid #0369A1;
    background-color: #0284C7; /* skyblue */
  }
  .header img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    border: 2px solid #fff;
  }

  /* Main container */
  .main-container {
    margin-left: 250px;
    padding-top: 80px;
    padding-right: 2rem;
    padding-left: 2rem;
  }

  table th, table td {
    padding: 0.75rem 1rem;
    border: 1px solid #7DD3FC; /* soft sky border */
    text-align: center;
  }

  table th {
    background-color: #0EA5E9;
    color: #fff;
  }

  table tr:hover {
    background-color: #E0F2FE; /* hover light skyblue */
  }

  .status-active { color: #10B981; font-weight: bold; }
  .status-expired { color: #EF4444; font-weight: bold; }
</style>
</head>
<body>

<!-- Sidebar -->
<aside class="sidebar flex flex-col justify-between h-screen">
  <div>
    <h2>The Royal Gym</h2>
    <ul class="space-y-2">
      <li><a href="<%=request.getContextPath()%>/adminDashboard.jsp"><i class="fa-solid fa-gauge-high"></i> Dashboard</a></li>
      <li><a href="<%=request.getContextPath()%>/trainer.jsp"><i class="fa-solid fa-dumbbell"></i> Trainers</a></li>
      <li><a href="<%=request.getContextPath()%>/totaluser.jsp"><i class="fa-solid fa-users"></i> Total User</a></li>
      <li><a href="<%=request.getContextPath()%>/user/members.jsp"><i class="fa-solid fa-users"></i> Members</a></li>
      <li><a href="<%=request.getContextPath()%>/equipment.jsp"><i class="fa-solid fa-weight-hanging"></i> Equipment</a></li>
      <li><a href="<%=request.getContextPath()%>/setting.jsp"><i class="fa-solid fa-gear"></i> Settings</a></li>
    </ul>
  </div>

  <a href="<%=request.getContextPath()%>/index.jsp" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</aside>

<!-- Header -->
<header class="header">
  <h1>Registered Members</h1>
  <%
    String adminEmail = (String) session.getAttribute("adminEmail");
  %>
  <div class="flex items-center gap-4">
    <span>Welcome, <b><%= (adminEmail != null) ? adminEmail : "Admin" %></b></span>
    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Admin">
  </div>
</header>

<!-- Main content -->
<div class="main-container">
  <div class="max-w-6xl mx-auto mt-10 bg-white shadow-xl rounded-2xl p-6">
    <h2 class="text-3xl font-bold text-center text-sky-600 mb-6">Registered Members</h2>

    <table class="w-full border-collapse">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Mobile</th>
          <th>Email</th>
          <th>City</th>
          <th>Plan</th>
          <th>Price</th>
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
              ResultSet rs = st.executeQuery("SELECT * FROM members");

              java.time.LocalDate today = java.time.LocalDate.now();

              while (rs.next()) {
                  int id = rs.getInt("id");
                  String name = rs.getString("name");
                  String mobile = rs.getString("mobile");
                  String email = rs.getString("email");
                  String city = rs.getString("city");
                  String plan = rs.getString("plan_name");
                  String price = rs.getString("plan_price");
                  java.sql.Date joinDateSQL = rs.getDate("join_date");
                  java.time.LocalDate joinDate = (joinDateSQL != null) ? joinDateSQL.toLocalDate() : today;
                  boolean isActive = java.time.Period.between(joinDate, today).getDays() < 30;
        %>
        <tr>
          <td><%= id %></td>
          <td class="font-semibold"><%= name %></td>
          <td><%= mobile %></td>
          <td><%= email %></td>
          <td><%= city %></td>
          <td class="text-sky-600 font-bold"><%= plan %></td>
          <td class="text-green-600 font-semibold"><%= price %></td>
          <td class="<%= isActive ? "status-active" : "status-expired" %>">
            <%= isActive ? "Active" : "Expired" %>
          </td>
        </tr>
        <%
              }
              con.close();
          } catch (Exception e) {
              out.println("<tr><td colspan='8' class='text-center text-red-600'>Error loading data!</td></tr>");
          }
        %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
