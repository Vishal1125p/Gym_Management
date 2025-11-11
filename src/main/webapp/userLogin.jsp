<%-- 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym | User Login</title>

  <!-- ✅ Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- ✅ Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

  <!-- ✅ Font Awesome -->
  <script src="https://kit.fontawesome.com/a2d9d6a04b.js" crossorigin="anonymous"></script>

  <style>
    body {
      background: linear-gradient(135deg, #111, #222, #111);
      background-image: url('images/gym-bg.jpg');
      background-size: cover;
      background-position: center;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Poppins', sans-serif;
      overflow: hidden;
    }

    /* ✨ Animated dark overlay */
    body::before {
      content: "";
      position: absolute;
      inset: 0;
      background: rgba(0, 0, 0, 0.7);
      backdrop-filter: blur(5px);
      z-index: -1;
    }

    /* ✨ Container with glassmorphism */
    .login-container {
      background: rgba(255, 255, 255, 0.12);
      border-radius: 20px;
      box-shadow: 0 0 25px rgba(255, 0, 0, 0.3);
      padding: 45px 40px;
      width: 400px;
      text-align: center;
      color: #fff;
      backdrop-filter: blur(10px);
      animation: fadeIn 1.2s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.9); }
      to { opacity: 1; transform: scale(1); }
    }

    .login-container h2 {
      font-weight: 700;
      color: #ff3b3b;
      margin-bottom: 30px;
      text-shadow: 0 0 10px #ff3b3b;
    }

    .form-control {
      background: rgba(255, 255, 255, 0.1);
      border: none;
      border-radius: 10px;
      color: #fff;
      padding: 12px;
    }

    .form-control::placeholder {
      color: #ccc;
    }

    .form-control:focus {
      box-shadow: 0 0 10px #ff3b3b;
      outline: none;
    }

    /* ✨ Neon glowing login button */
    .btn-danger {
      background: linear-gradient(90deg, #ff1744, #ff5252);
      border: none;
      border-radius: 30px;
      font-weight: 600;
      letter-spacing: 1px;
      padding: 12px 0;
      transition: all 0.4s ease;
      box-shadow: 0 0 15px #ff3b3b;
    }

    .btn-danger:hover {
      background: linear-gradient(90deg, #ff5252, #ff1744);
      transform: translateY(-2px) scale(1.05);
      box-shadow: 0 0 25px #ff3b3b;
    }

    .home-btn {
      color: #ff3b3b;
      font-weight: 500;
      text-decoration: none;
      margin: 0 10px;
      transition: all 0.3s ease;
    }

    .home-btn:hover {
      color: #fff;
      text-shadow: 0 0 10px #ff3b3b;
    }

    label {
      font-weight: 500;
      color: #f1f1f1;
    }
  </style>
</head>
<body>

  <div class="login-container">
    <h2><i class="fas fa-dumbbell"></i> User Login</h2>

    <form action="UserLoginServlet" method="post" class="login-form">
      <div class="mb-3">
        <label for="email" class="form-label">Email Address</label>
        <input type="text" class="form-control" id="email" name="email" placeholder="Enter your email" required>
      </div>

      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
      </div>

      <div class="d-grid gap-2 mt-4">
        <button type="submit" class="btn btn-danger">Login</button>
      </div>

      <div class="text-center mt-4">
        <a href="index.jsp" class="home-btn">Home</a> |
        <a href="userRegister.jsp" class="home-btn">Register</a>
      </div>
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

 --%>