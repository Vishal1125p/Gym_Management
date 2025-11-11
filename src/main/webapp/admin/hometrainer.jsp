<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym | Trainers</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@500;600;700&display=swap" rel="stylesheet">

  <style>
    body {
      background: radial-gradient(circle at top left, #000, #111);
      font-family: 'Rajdhani', sans-serif;
      color: white;
      overflow-x: hidden;
    }

    .trainer-section {
      padding: 90px 0;
      text-align: center;
    }

    .section-title {
      font-size: 3rem;
      font-weight: 700;
      color: #FFD700;
      text-transform: uppercase;
      margin-bottom: 3rem;
      letter-spacing: 1px;
      text-shadow: 0 0 25px rgba(255, 215, 0, 0.5);
    }

    .trainer-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(270px, 1fr));
      gap: 40px;
      justify-items: center;
      padding: 0 25px;
    }

    .trainer-card {
      background: rgba(255, 255, 255, 0.07);
      border-radius: 20px;
      overflow: hidden;
      width: 100%;
      max-width: 320px;
      backdrop-filter: blur(15px);
      transition: all 0.4s ease;
      border: 1px solid rgba(255, 215, 0, 0.25);
      position: relative;
      box-shadow: 0 0 15px rgba(255, 215, 0, 0.05);
    }

    .trainer-card:hover {
      transform: translateY(-10px) scale(1.03);
      border-color: rgba(255, 215, 0, 0.6);
      box-shadow: 0 0 35px rgba(255, 215, 0, 0.3);
    }

    .trainer-img {
      width: 100%;
      height: 260px;
      object-fit: cover;
      transition: transform 0.5s ease;
    }

    .trainer-card:hover .trainer-img {
      transform: scale(1.1);
    }

    .trainer-info {
      padding: 20px 18px;
      text-align: left;
    }

    .trainer-info h3 {
      color: #FFD700;
      font-size: 1.6rem;
      font-weight: 700;
      margin-bottom: 12px;
      text-transform: capitalize;
    }

    .trainer-details {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .trainer-details p {
      margin: 0;
      font-size: 1rem;
      font-weight: 600;
      color: #e0e0e0;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .trainer-details i {
      color: #FFD700;
      font-size: 1.1rem;
    }

    .specialization {
      font-size: 1rem;
      font-weight: 600;
      color: white;
      background: linear-gradient(90deg, #FFD700, #ffec8b);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-top: 10px;
      text-transform: lowercase;
      letter-spacing: 1px;
    }

    .glow {
      position: absolute;
      bottom: 0;
      left: 0;
      height: 5px;
      width: 100%;
      background: linear-gradient(90deg, #FFD700, #fff, #FFD700);
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .trainer-card:hover .glow {
      opacity: 1;
    }

    /* Button */
    .view-btn {
      background-color: #FFD700;
      color: black;
      font-weight: 700;
      border: none;
      border-radius: 25px;
      padding: 10px 20px;
      margin-top: 15px;
      width: 100%;
      transition: all 0.3s ease;
      font-size: 1rem;
      letter-spacing: 0.5px;
    }

    .view-btn:hover {
      background-color: #e0c200;
      transform: scale(1.05);
      box-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
    }
  </style>
</head>
<body>

<section class="trainer-section">
  <div class="container">
    <h2 class="section-title">💪 Meet Our Trainers</h2>

    <div class="trainer-grid">
      <%
        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          Connection con = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125"
          );
          Statement st = con.createStatement();
          ResultSet rs = st.executeQuery("SELECT * FROM trainer");

          while (rs.next()) {
      %>
      <div class="trainer-card">
        <img src="<%= rs.getString("photo") %>" alt="Trainer Photo" class="trainer-img">
        <div class="trainer-info">
          <h3><i class="fa-solid fa-user"></i> <%= rs.getString("name") %></h3>
          
          <div class="trainer-details">
            <p><i class="fa-solid fa-venus-mars"></i> <%= rs.getString("gender") %></p>
            <p><i class="fa-solid fa-briefcase"></i> <%= rs.getString("experience") %> yrs</p>
          </div>
          
          <p class="specialization"><i class="fa-solid fa-dumbbell text-white"></i> <%= rs.getString("specialization") %></p>

        </div>
        <div class="glow"></div>
      </div>
      <%
          }
          con.close();
        } catch (Exception e) {
          out.println("<p style='color:red; font-weight:bold;'>Error: " + e.getMessage() + "</p>");
        }
      %>
    </div>
  </div>
</section>

</body>
</html>
