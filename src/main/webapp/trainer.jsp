<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Trainer | The Royal Gym</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://kit.fontawesome.com/a2d9d5a64f.js" crossorigin="anonymous"></script>

  <style>
    body {
      overflow-x: hidden;
      background-color: #F0F9FF; /* Light sky-blue background */
      color: #333333;
    }
    .main-content {
      margin-left: 250px;
      width: calc(100% - 250px);
    }
    .form-card {
      max-width: 650px;
      margin: 0 auto;
    }
    .table-wrapper {
      overflow-x: auto;
    }
  </style>
</head>

<body class="min-h-screen flex">

  <!-- Sidebar -->
  <jsp:include page="sidebar.jsp"></jsp:include>

  <!-- Main Content -->
  <div class="main-content flex flex-col min-h-screen">

    <!-- Header -->
    <header class="bg-sky-600 shadow-md sticky top-0 z-50 flex items-center justify-between px-10 py-4 ml-1 border-b border-sky-700">
      <h2 class="text-2xl font-bold text-white flex items-center gap-2">
        <i class="fa-solid fa-dumbbell"></i> Manage Trainers
      </h2>

      <% String adminEmail = (String) session.getAttribute("adminEmail"); %>

      <div class="flex items-center space-x-4">
        <span class="text-white">
          Welcome, <b><%= (adminEmail != null) ? adminEmail : "Admin" %></b>
        </span>
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" 
             alt="Admin" class="w-11 h-11 rounded-full border-2 border-white shadow-lg">
      </div>
    </header>

    <!-- Main Section -->
    <main class="flex-1 overflow-y-auto p-6 space-y-8">

      <!-- Add Trainer Form -->
      <section class="bg-white mt-5 p-8 rounded-2xl shadow-lg border border-sky-200 form-card">
        <h1 class="text-3xl font-bold text-center mb-8 text-sky-600 tracking-wide uppercase">
          Add New Trainer
        </h1>

        <form action="AddTrainerServlet" method="post" enctype="multipart/form-data"
              class="flex flex-wrap gap-4 justify-center">

          <input type="text" name="name" placeholder="Full Name" required
                 class="flex-1 min-w-[200px] px-4 py-2 rounded-lg border border-sky-200 
                        focus:ring-2 focus:ring-sky-300 outline-none placeholder-gray-400">

          <input type="number" name="age" placeholder="Age" required
                 class="w-32 px-4 py-2 rounded-lg border border-sky-200 focus:ring-2 focus:ring-sky-300 outline-none placeholder-gray-400">

          <select name="gender" required
                  class="w-40 px-4 py-2 rounded-lg border border-sky-200 focus:ring-2 focus:ring-sky-300 outline-none">
            <option value="">Gender</option>
            <option>Male</option>
            <option>Female</option>
          </select>

          <input type="text" name="experience" placeholder="Experience (yrs)" required
                 class="w-48 px-4 py-2 rounded-lg border border-sky-200 focus:ring-2 focus:ring-sky-300 outline-none placeholder-gray-400">

          <input type="text" name="specialization" placeholder="Specialization" required
                 class="flex-1 min-w-[200px] px-4 py-2 rounded-lg border border-sky-200 focus:ring-2 focus:ring-sky-300 outline-none placeholder-gray-400">

          <input type="file" name="photo" accept="image/*" required
                 class="w-64 px-4 py-2 rounded-lg border border-sky-200 focus:ring-2 focus:ring-sky-300 outline-none
                        file:mr-3 file:py-2 file:px-3 file:rounded-lg file:border-0 
                        file:text-sm file:font-semibold file:bg-sky-500 file:text-white hover:file:bg-sky-600">

          <div class="w-full text-center mt-6">
            <button type="submit"
                    class="bg-sky-600 hover:bg-sky-700 text-white font-semibold px-8 py-2 rounded-lg shadow-md 
                           transition transform hover:-translate-y-1 hover:shadow-sky-400/40">
              <i class="fa-solid fa-plus mr-2"></i> Add Trainer
            </button>
          </div>
        </form>
      </section>

      <!-- Trainer List Table -->
      <section class="bg-white border border-sky-200 rounded-2xl shadow-lg p-6 table-wrapper">
        <h2 class="text-xl font-semibold text-sky-600 mb-6 flex items-center gap-2">
          <i class="fa-solid fa-list"></i> List of Trainers
        </h2>

        <table class="w-full text-left border-collapse">
          <thead>
            <tr class="bg-sky-100 text-sky-600">
              <th class="p-3">#</th>
              <th class="p-3">Name</th>
              <th class="p-3">Age</th>
              <th class="p-3">Gender</th>
              <th class="p-3">Experience</th>
              <th class="p-3">Specialization</th>
              <th class="p-3 text-center">Actions</th>
            </tr>
          </thead>
          <tbody>
            <%
              try {
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  Connection con = DriverManager.getConnection(
                      "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

                  Statement st = con.createStatement();
                  ResultSet rs = st.executeQuery("SELECT * FROM trainer");
                  int i = 1;
                  while (rs.next()) {
            %>
            <tr class="border-b border-sky-200 hover:bg-sky-50 transition">
              <td class="p-3"><%= i++ %></td>
              <td class="p-3"><%= rs.getString("name") %></td>
              <td class="p-3"><%= rs.getInt("age") %></td>
              <td class="p-3"><%= rs.getString("gender") %></td>
              <td class="p-3"><%= rs.getString("experience") %></td>
              <td class="p-3"><%= rs.getString("specialization") %></td>
              <td class="p-3 text-center space-x-2">
                <button 
                  onclick="openEditModal('<%= rs.getInt("id") %>', '<%= rs.getString("name") %>', '<%= rs.getInt("age") %>', 
                  '<%= rs.getString("gender") %>', '<%= rs.getString("experience") %>', 
                  '<%= rs.getString("specialization") %>')"
                  class="text-sky-500 hover:text-sky-600">
                  <i class="fa-solid fa-pen-to-square"></i> Edit
                </button>
                <a href="DeleteTrainerServlet?id=<%= rs.getInt("id") %>" 
                   class="text-sky-500 hover:text-sky-600 ml-3">
                  <i class="fa-solid fa-trash"></i> Delete
                </a>
              </td>
            </tr>
            <%
                  }
                  con.close();
              } catch (Exception e) {
                  out.println("<tr><td colspan='7' class='text-center text-sky-500'>Error: " + e.getMessage() + "</td></tr>");
              }
            %>
          </tbody>
        </table>
      </section>

    </main>
  </div>

  <!-- Edit Modal -->
  <div id="editModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50">
    <div class="bg-white p-6 rounded-2xl shadow-lg w-full max-w-md">
      <h2 class="text-xl text-sky-600 font-semibold mb-4">
        <i class="fa-solid fa-pen-to-square"></i> Edit Trainer
      </h2>
      <form action="EditTrainerServlet" method="post" class="space-y-4">
        <input type="hidden" id="editId" name="id">
        <input type="text" id="editName" name="name" placeholder="Full Name" required class="w-full px-4 py-2 rounded-lg border border-sky-200">
        <input type="number" id="editAge" name="age" placeholder="Age" required class="w-full px-4 py-2 rounded-lg border border-sky-200">
        <select id="editGender" name="gender" required class="w-full px-4 py-2 rounded-lg border border-sky-200">
          <option>Male</option>
          <option>Female</option>
        </select>
        <input type="text" id="editExperience" name="experience" placeholder="Experience" required class="w-full px-4 py-2 rounded-lg border border-sky-200">
        <input type="text" id="editSpecialization" name="specialization" placeholder="Specialization" required class="w-full px-4 py-2 rounded-lg border border-sky-200">

        <div class="flex justify-end gap-4 mt-6">
          <button type="button" onclick="closeEditModal()" class="px-5 py-2 bg-sky-300 hover:bg-sky-400 rounded-lg text-white">Cancel</button>
          <button type="submit" class="px-5 py-2 bg-sky-600 hover:bg-sky-700 rounded-lg text-white">Update</button>
        </div>
      </form>
    </div>
  </div>

  <script>
    function openEditModal(id, name, age, gender, experience, specialization) {
      document.getElementById('editModal').classList.remove('hidden');
      document.getElementById('editId').value = id;
      document.getElementById('editName').value = name;
      document.getElementById('editAge').value = age;
      document.getElementById('editGender').value = gender;
      document.getElementById('editExperience').value = experience;
      document.getElementById('editSpecialization').value = specialization;
    }
    function closeEditModal() {
      document.getElementById('editModal').classList.add('hidden');
    }
  </script>

</body>
</html>
