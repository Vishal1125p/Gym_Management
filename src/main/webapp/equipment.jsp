<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Equipment Management | The Royal Gym</title>
  
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  
  <style>
    table th, table td { padding: 1rem; font-size: 1rem; }
    .table-wrapper { overflow-x: auto; }
  </style>
</head>

<body class="bg-sky-50 text-sky-900">

  <!-- Sidebar -->
  <div class="fixed top-0 left-0 h-full w-64 bg-white shadow-lg border-r border-sky-200 z-50">
    <jsp:include page="sidebar.jsp"></jsp:include>
  </div>

  <!-- Main Content -->
  <div class="ml-64 flex flex-col min-h-screen">

    <!-- Header -->
    <header class="bg-sky-600 shadow-md sticky top-0 z-40 flex items-center justify-between px-6 py-4 border-b border-sky-700">
      <h2 class="text-2xl font-bold text-white flex items-center gap-2">
        <i class="fa-solid fa-dumbbell"></i> Equipment Management
      </h2>

      <% String adminEmail = (String) session.getAttribute("adminEmail"); %>

      <div class="flex items-center space-x-4">
        <span class="text-white">
          Welcome, <b><%= (adminEmail != null) ? adminEmail : "Admin" %></b>
        </span>
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" 
             alt="Admin" class="w-12 h-12 rounded-full border-2 border-white shadow-lg">
      </div>
    </header>

    <!-- Main Content Wrapper with padding -->
    <div class="flex flex-col p-6 space-y-8 mt-0">

      <!-- Success Message -->
      <%
        String success = request.getParameter("success");
        if ("1".equals(success)) {
      %>
      <div class="max-w-3xl mx-auto bg-sky-100 text-center py-3 rounded-lg shadow-lg animate-bounce text-sky-700 font-semibold text-lg">
        ✅ Equipment added successfully!
      </div>
      <script>
        setTimeout(() => {
          window.location.href = "equipment.jsp";
        }, 1500);
      </script>
      <% } %>

      <!-- Add Equipment Form -->
      <div class="bg-white p-6 rounded-2xl shadow-lg border border-sky-200 max-w-4xl mx-auto">
        <h2 class="text-2xl font-bold mb-6 text-sky-700">Add New Equipment</h2>
        <form action="AddEquipmentServlet" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <input type="text" name="name" placeholder="Equipment Name" required class="p-3 rounded border border-sky-300 focus:border-sky-500 focus:ring focus:ring-sky-200">
          <input type="text" name="category" placeholder="Category" required class="p-3 rounded border border-sky-300 focus:border-sky-500 focus:ring focus:ring-sky-200">
          <input type="date" name="purchase_date" required class="p-3 rounded border border-sky-300 focus:border-sky-500 focus:ring focus:ring-sky-200">
          <input type="number" name="quantity" placeholder="Quantity" min="1" required class="p-3 rounded border border-sky-300 focus:border-sky-500 focus:ring focus:ring-sky-200">
          <input type="text" name="condition_status" placeholder="Condition (New/Good/Repair)" required class="p-3 rounded border border-sky-300 focus:border-sky-500 focus:ring focus:ring-sky-200">
          <input type="number" step="0.01" name="price" placeholder="Price" required class="p-3 rounded border border-sky-300 focus:border-sky-500 focus:ring focus:ring-sky-200">

          <div class="md:col-span-3 text-center mt-3">
            <button type="submit" class="bg-sky-600 text-white px-8 py-3 rounded hover:bg-sky-700 transition font-semibold text-lg">Add Equipment</button>
          </div>
        </form>
      </div>

      <!-- Equipment List Table -->
      <div class="table-wrapper bg-white p-6 rounded-2xl shadow-lg border border-sky-200 max-w-6xl mx-auto">
        <h2 class="text-2xl font-bold mb-6 text-sky-700">Equipment List</h2>
        <table class="w-full border-collapse bg-white rounded-lg overflow-hidden border border-sky-200 text-lg">
          <thead class="bg-sky-100 text-sky-700 text-lg">
            <tr>
              <th class="p-4 text-left">ID</th>
              <th class="p-4 text-left">Name</th>
              <th class="p-4 text-left">Category</th>
              <th class="p-4 text-left">Purchase Date</th>
              <th class="p-4 text-left">Condition</th>
              <th class="p-4 text-left">Qty</th>
              <th class="p-4 text-left">Price (₹)</th>
              <th class="p-4 text-center">Action</th>
            </tr>
          </thead>
          <tbody>
            <%
              try {
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  Connection con = DriverManager.getConnection(
                          "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");
                  PreparedStatement ps = con.prepareStatement("SELECT * FROM equipment ORDER BY id ASC");
                  ResultSet rs = ps.executeQuery();
                  while (rs.next()) {
            %>
            <tr class="hover:bg-sky-50">
              <td class="p-4"><%= rs.getInt("id") %></td>
              <td class="p-4"><%= rs.getString("name") %></td>
              <td class="p-4"><%= rs.getString("category") %></td>
              <td class="p-4"><%= rs.getDate("purchase_date") %></td>
              <td class="p-4"><%= rs.getString("condition_status") %></td>
              <td class="p-4"><%= rs.getInt("quantity") %></td>
              <td class="p-4"><%= rs.getDouble("price") %></td>
              <td class="p-4 text-center">
                <a href="DeleteEquipmentServlet?id=<%=rs.getInt("id")%>" class="text-sky-600 hover:text-sky-700 ml-4">
                  <i class="fa-solid fa-trash"></i>
                </a>
              </td>
            </tr>
            <%
                  }
                  con.close();
              } catch(Exception e) {
                  out.println("<tr><td colspan='8' class='text-center text-sky-400 p-4'>Error: "+ e.getMessage() +"</td></tr>");
              }
            %>
          </tbody>
        </table>
      </div>

    </div>
  </div>

</body>
</html>
