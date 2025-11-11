<%@ page session="true" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>The Royal Gym | Membership</title>
<link rel="stylesheet" href="css/homemembership.css">
</head>
<body>

<jsp:include page="navbar.jsp" />

<section class="membership-section">
  <div class="background-overlay"></div>

  <div class="header-text">
    <h2>🔥 Become a Royal Member 🔥</h2>
    <p>Unlock access to world-class gym facilities, personalized training, and exclusive member benefits.</p>
  </div>

  <div class="membership-cards">

    <!-- ✅ MONTHLY PLAN -->
    <div class="card">
      <h3>MONTHLY</h3>
      <p class="price">₹2,999</p>
      <p class="desc">Perfect for newcomers looking to try out our premium facilities.</p>
      <ul>
        <li>💪 Access to all gym equipment</li>
        <li>👟 Free personal training (1 session)</li>
        <li>☕ Lounge & steam access</li>
      </ul>

      <% if (userEmail != null) { %>
        <!-- ✅ If Logged In -->
        <a href="user/membership.jsp" class="btn">Join Now</a>
      <% } else { %>
        <!-- ❌ If Not Logged In -->
        <a href="#" class="btn" data-bs-toggle="modal" data-bs-target="#userLoginModal">Join Now</a>
      <% } %>
    </div>

    <!-- ✅ QUARTERLY PLAN -->
    <div class="card highlight">
      <h3>QUARTERLY</h3>
      <p class="price">₹7,499</p>
      <p class="desc">Best for consistent fitness lovers aiming to transform their body.</p>
      <ul>
        <li>🔥 3 months access to all facilities</li>
        <li>🥗 Personalized diet plan</li>
        <li>🎥 Online workout sessions</li>
      </ul>

      <% if (userEmail != null) { %>
        <a href="user/membership.jsp" class="btn">Join Now</a>
      <% } else { %>
        <a href="#" class="btn" data-bs-toggle="modal" data-bs-target="#userLoginModal">Join Now</a>
      <% } %>
    </div>

    <!-- ✅ ANNUAL PLAN -->
    <div class="card">
      <h3>ANNUAL</h3>
      <p class="price">₹19,999</p>
      <p class="desc">For dedicated members who are serious about long-term transformation.</p>
      <ul>
        <li>🏋️‍♂️ Unlimited access & priority booking</li>
        <li>💬 Monthly fitness consultation</li>
        <li>🎁 Royal Member T-shirt & benefits</li>
      </ul>

      <% if (userEmail != null) { %>
        <a href="user/membership.jsp" class="btn">Join Now</a>
      <% } else { %>
        <a href="#" class="btn" data-bs-toggle="modal" data-bs-target="#userLoginModal">Join Now</a>
      <% } %>
    </div>
  </div>

  <div class="floating-icon">
    <svg width="150" height="150" fill="none" viewBox="0 0 24 24" stroke="yellow" stroke-width="1.2">
      <path stroke-linecap="round" stroke-linejoin="round" d="M3 12h3m12 0h3M8 8v8m8-8v8M6 8h2m8 0h2M6 16h2m8 0h2" />
    </svg>
  </div>

</section>

</body>
</html>
