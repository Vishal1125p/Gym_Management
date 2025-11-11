<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym - Navbar</title>

  <!-- ✅ Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

  <!-- Font Awesome -->
  <script src="https://kit.fontawesome.com/a2d9d6a04b.js" crossorigin="anonymous"></script>

  <style>
    body { font-family: 'Poppins', sans-serif; background-color: #111; color: white; }

    /* --- Navbar --- */
    .navbar { z-index: 2000; }
    .dropdown-menu {
      background-color: #222;
      border-radius: 10px;
      border: none;
      box-shadow: 0 0 10px rgba(255, 0, 0, 0.5);
      z-index: 3000 !important;
    }
    .dropdown-item { color: #fff; }
    .dropdown-item:hover { background-color: #ff3b3b; color: #fff; }

    /* --- Modals --- */
    .modal-content {
      background: rgba(255, 255, 255, 0.1);
      border-radius: 20px;
      border: none;
      backdrop-filter: blur(8px);
      color: white;
      box-shadow: 0 0 20px rgba(255, 0, 0, 0.3);
    }
    .modal-header { border-bottom: none; text-align: center; color: #ff3b3b; text-shadow: 0 0 10px #ff3b3b; position: relative; }
    .btn-close { position: absolute; right: 15px; top: 15px; background-color: #fff; border-radius: 50%; opacity: 0.8; }
    .btn-close:hover { opacity: 1; box-shadow: 0 0 10px #ff3b3b; }

    .form-control { background: rgba(255,255,255,0.1); border: none; color: #fff; border-radius: 10px; }
    .form-control:focus { box-shadow: 0 0 10px #ff3b3b; outline: none; }

    .btn-danger {
      background: linear-gradient(90deg, #ff1744, #ff5252);
      border: none; border-radius: 30px;
      font-weight: 600; letter-spacing: 1px;
      padding: 12px 0; box-shadow: 0 0 15px #ff3b3b;
      transition: all 0.4s ease;
    }
    .btn-danger:hover {
      background: linear-gradient(90deg, #ff5252, #ff1744);
      transform: translateY(-2px) scale(1.05);
      box-shadow: 0 0 25px #ff3b3b;
    }
    label { font-weight: 500; color: #f1f1f1; }
    .login-link { color: #ff3b3b; text-decoration: none; font-weight: 500; }
    .login-link:hover { color: #fff; text-shadow: 0 0 10px #ff3b3b; }
  </style>
</head>

<body>

<%
  String userName = (String) session.getAttribute("userName");
  String userEmail = (String) session.getAttribute("userEmail");
%>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3 shadow-sm fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold text-warning" href="index.jsp">🏋️‍♂️ The Royal Gym</a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link text-warning" href="index.jsp">Home</a>
        </li>
        

        <% if (userEmail != null) { %>
          <!-- ✅ Logged-In User Dropdown -->
          
          <li class="nav-item">
          <a class="nav-link text-white" href="user/membership.jsp">Membership</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-white" href="contact.jsp">Contact</a>
        </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle text-white" href="#" id="userDropdown"
               role="button" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="fas fa-user"></i> <%= userName %>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
              <li><a class="dropdown-item" href="userProfile.jsp"><i class="fas fa-id-card"></i> Profile</a></li>
              <li><hr class="dropdown-divider"></li>
              <li>
                <form action="LogoutServlet" method="post" style="margin:0;">
                  <button type="submit" class="dropdown-item">
                    <i class="fas fa-sign-out-alt"></i> Logout
                  </button>
                </form>
              </li>
            </ul>
          </li>
        <% } else { %>
          <!-- ✅ Not Logged In -->
          <li class="nav-item">
            <a class="nav-link text-white" href="#" data-bs-toggle="modal" data-bs-target="#adminLoginModal">Admin Login</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="#" data-bs-toggle="modal" data-bs-target="#userLoginModal">User Login</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="#" data-bs-toggle="modal" data-bs-target="#userRegisterModal">Sign Up</a>
          </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>


<!-- Add top padding since navbar is fixed -->
<div style="padding-top:90px;"></div>

<!-- ✅ Admin Login Modal -->
<div class="modal fade" id="adminLoginModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header justify-content-center">
        <h4 class="modal-title"><i class="fas fa-user-shield"></i> Admin Login</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form action="AdminLoginServlet" method="post">
          <div class="mb-3">
            <label>Email Address</label>
            <input type="email" class="form-control" name="email" placeholder="Enter Email" required>
          </div>
          <div class="mb-3">
            <label>Password</label>
            <input type="password" class="form-control" name="password" placeholder="Enter Password" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-danger">Login</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- ✅ User Login Modal -->
<div class="modal fade" id="userLoginModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header justify-content-center">
        <h4 class="modal-title"><i class="fas fa-dumbbell"></i> User Login</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form action="UserLoginServlet" method="post">
          <div class="mb-3">
            <label>Email Address</label>
            <input type="email" class="form-control" name="email" required>
          </div>
          <div class="mb-3">
            <label>Password</label>
            <input type="password" class="form-control" name="password" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-danger">Login</button>
          </div>
          <div class="text-center mt-3">
            <a href="#" class="login-link" data-bs-toggle="modal" data-bs-target="#userRegisterModal" data-bs-dismiss="modal">
              Don't have an account? Register
            </a>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- ✅ User Register Modal -->
<div class="modal fade" id="userRegisterModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header justify-content-center">
        <h4 class="modal-title"><i class="fas fa-user-plus"></i> User Registration</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form action="UserRegisterServlet" method="post">
          <div class="mb-3">
            <label>Full Name</label>
            <input type="text" class="form-control" name="username" required>
          </div>
          <div class="mb-3">
            <label>Email</label>
            <input type="email" class="form-control" name="email" required>
          </div>
          <div class="mb-3">
            <label>Password</label>
            <input type="password" class="form-control" name="password" required>
          </div>
          <div class="mb-3">
            <label>Confirm Password</label>
            <input type="password" class="form-control" name="confirmPassword" required>
          </div>
          <div class="mb-3">
            <label>Phone</label>
            <input type="text" class="form-control" name="phone" required>
          </div>
          <div class="d-grid">
            <button type="submit" class="btn btn-danger">Register</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- ✅ Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const dropdownElements = document.querySelectorAll('[data-bs-toggle="dropdown"]');
    dropdownElements.forEach(el => new bootstrap.Dropdown(el));

    const params = new URLSearchParams(window.location.search);
    if (params.get('registered') === 'true') {
      const loginModal = new bootstrap.Modal(document.getElementById('userLoginModal'));
      loginModal.show();
    }
  });
</script>

<!-- ✅ Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    // Reinitialize dropdowns for safety
    const dropdownElements = document.querySelectorAll('[data-bs-toggle="dropdown"]');
    dropdownElements.forEach(el => new bootstrap.Dropdown(el));

    // Handle registered query
    const params = new URLSearchParams(window.location.search);
    if (params.get('registered') === 'true') {
      const loginModal = new bootstrap.Modal(document.getElementById('userLoginModal'));
      loginModal.show();
    }
  });
</script>


</body>
</html>
