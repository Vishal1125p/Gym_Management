<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Admin Login</title>
  <link rel="stylesheet" href="css/admin_login.css">
</head>
<body>
  <div class="login-container">
    <h2>Admin Login</h2>
    <form action="AdminLoginServlet" method="post">
      <input type="text" name="email" placeholder="Enter Email" required>
      <input type="password" name="password" placeholder="Enter Password" required>
      <input type="submit" value="Login">
    </form>
    <a href="index.jsp" class="home-link"> Home</a>
  </div>
</body>
</html>
