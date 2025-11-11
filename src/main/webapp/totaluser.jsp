<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registered Users | The Royal Gym</title>

<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
  body {
    background-color: #e0f7ff; /* Light sky blue background */
    font-family: 'Poppins', sans-serif;
  }

  /* Sidebar */
  .sidebar {
    width: 250px;
    position: fixed;
    top: 0; left: 0;
    height: 100%;
    background-color: #ffffff;
    border-right: 2px solid #38bdf8;
    box-shadow: 2px 0 10px rgba(0,0,0,0.1);
  }

  /* Header */
  .header {
    position: fixed;
    top: 0;
    left: 250px;
    right: 0;
    background: linear-gradient(90deg, #0ea5e9, #0284c7);
    color: #ffffff;
    padding: 1.25rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 600;
    font-size: 1.25rem;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    border-bottom: 3px solid #0369a1;
    z-index: 40;
  }

  .header img {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    border: 2px solid #fff;
  }

  .main-container {
    margin-left: 270px;
    padding-top: 100px;
    padding-bottom: 50px;
  }

  /* Table Section */
  .table-wrapper {
    max-width: 1000px;
    margin: 2rem auto;
    background-color: #ffffff;
    border: 1px solid #38bdf8;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    overflow-x: auto;
  }

  table th, table td {
    padding: 0.75rem 1rem;
    text-align: center;
    border: 1px solid #bae6fd;
  }

  table th {
    background-color: #e0f2fe;
    color: #0369a1;
    font-weight: 600;
  }

  tr:hover {
    background-color: #f0f9ff;
  }

  /* Buttons */
  .btn-icon {
    width: 38px;
    height: 38px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: 0.5rem;
    color: #fff;
    transition: all 0.2s ease;
  }

  .btn-edit {
    background-color: #0284c7;
  }
  .btn-edit:hover {
    background-color: #0369a1;
  }

  .btn-delete {
    background-color: #0ea5e9;
  }
  .btn-delete:hover {
    background-color: #0369a1;
  }

  /* Modal */
  .modal {
    background-color: rgba(0, 0, 0, 0.5);
  }

  .modal-content {
    background-color: #ffffff;
    border: 2px solid #38bdf8;
    border-radius: 1rem;
  }
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <jsp:include page="sidebar.jsp"></jsp:include>
</div>

<!-- Header -->
<div class="header">
  <div class="flex items-center gap-2">
    <i class="fa-solid fa-users"></i>
    <span>Registered Users</span>
  </div>

  <% String adminEmail = (String) session.getAttribute("adminEmail"); %>
  <div class="flex items-center gap-3">
    <span>Welcome, <b><%= (adminEmail != null) ? adminEmail : "Admin" %></b></span>
    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Admin">
  </div>
</div>

<!-- Main Content -->
<div class="main-container">

  <div class="table-wrapper">
    <h2 class="text-2xl font-bold mb-6 text-sky-700 text-center">Registered Users</h2>
    <table class="min-w-full text-center" id="usersTable">
      <thead>
        <tr>
          <th>ID</th>
          <th>Full Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <%
          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/Gym_management","root","Vishu@1125"
            );
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM user_register");

            while(rs.next()) {
              int id = rs.getInt("id");
              String username = rs.getString("username");
              String email = rs.getString("email");
              String phone = rs.getString("phone");
        %>
        <tr>
          <td><%= id %></td>
          <td><%= username %></td>
          <td><%= email %></td>
          <td><%= phone %></td>
          <td class="flex justify-center gap-2 py-2">
            <button class="btn-icon btn-edit editBtn"
                    data-id="<%= id %>" data-username="<%= username %>"
                    data-email="<%= email %>" data-phone="<%= phone %>">
              <i class="fa-solid fa-pen-to-square"></i>
            </button>
            <a href="<%=request.getContextPath()%>/DeleteUserServlet?id=<%= id %>"
               class="btn-icon btn-delete">
              <i class="fa-solid fa-trash"></i>
            </a>
          </td>
        </tr>
        <%
            }
            con.close();
          } catch(Exception e) {
        %>
        <tr><td colspan="5" class="text-sky-700 py-4"><%= e.getMessage() %></td></tr>
        <%
          }
        %>
      </tbody>
    </table>
  </div>

  <!-- Edit User Modal -->
  <div id="editUserModal" class="fixed inset-0 modal hidden items-center justify-center z-50">
    <div class="modal-content shadow-2xl w-96 max-w-full p-6 relative">
      <button class="absolute top-4 right-4 text-gray-500 hover:text-gray-700" id="closeModal">
        <i class="fa-solid fa-xmark text-xl"></i>
      </button>
      <h2 class="text-xl font-bold text-sky-700 mb-4 text-center">Edit User</h2>
      <form id="editUserForm" class="space-y-4">
        <input type="hidden" name="id" id="editUserId">

        <div>
          <label class="block text-gray-700 font-medium mb-1">Full Name</label>
          <input type="text" name="username" id="editUsername" required
                 class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-sky-500">
        </div>

        <div>
          <label class="block text-gray-700 font-medium mb-1">Email</label>
          <input type="email" name="email" id="editEmail" required
                 class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-sky-500">
        </div>

        <div>
          <label class="block text-gray-700 font-medium mb-1">Phone</label>
          <input type="text" name="phone" id="editPhone" required
                 class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-sky-500">
        </div>

        <div class="flex justify-end gap-2 mt-4">
          <button type="button" id="cancelModal"
                  class="px-4 py-2 rounded-lg bg-gray-300 hover:bg-gray-400">Cancel</button>
          <button type="submit"
                  class="px-4 py-2 rounded-lg bg-sky-600 text-white hover:bg-sky-700">Update</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- JS for Modal -->
<script>
  const modal = document.getElementById('editUserModal');
  const closeModal = document.getElementById('closeModal');
  const cancelModal = document.getElementById('cancelModal');
  const editButtons = document.querySelectorAll('.editBtn');

  editButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      document.getElementById('editUserId').value = btn.dataset.id;
      document.getElementById('editUsername').value = btn.dataset.username;
      document.getElementById('editEmail').value = btn.dataset.email;
      document.getElementById('editPhone').value = btn.dataset.phone;
      modal.classList.remove('hidden');
      modal.classList.add('flex');
    });
  });

  [closeModal, cancelModal].forEach(el => {
    el.addEventListener('click', () => {
      modal.classList.add('hidden');
      modal.classList.remove('flex');
    });
  });
</script>

</body>
</html>
