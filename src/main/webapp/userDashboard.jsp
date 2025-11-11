<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | Gym Management</title>
    <link rel="stylesheet" type="text/css" href="css/userDashboard.css">
</head>
<body>
	<form action="userDashboard"></form>
    <div class="navbar">
        <h1>The Royal Gym</h1>
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">Workout</a>
            <a href="#">Diet</a>
            <a href="#">Payments</a>
            <a href="#">Profile</a>
            <a href="userLogin.jsp" class="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-box">
            <h2>Welcome, <%= request.getParameter("username") != null ? request.getParameter("username") : "User" %> 👋</h2>
            <p>Glad to see you back! Let’s crush your fitness goals today.</p>
        </div>

        <div class="dashboard-grid">

            <div class="card">
                <h3> Workout Plan</h3>
                <ul>
                    <li>Chest & Triceps - Monday</li>
                    <li>Back & Biceps - Tuesday</li>
                    <li>Legs - Wednesday</li>
                    <li>Shoulders - Thursday</li>
                </ul>
            </div>

            <div class="card">
                <h3>Diet Plan</h3>
                <ul>
                    <li>Breakfast: Oats + Eggs</li>
                    <li>Lunch: Brown Rice + Chicken</li>
                    <li>Dinner: Salad + Soup</li>
                </ul>
            </div>

            <div class="card">
                <h3>Membership Details</h3>
                <p>Plan: <strong>Monthly</strong></p>
                <p>Start Date: 01-Nov-2025</p>
                <p>Expiry Date: 30-Nov-2025</p>
                <button class="btn">Renew Membership</button>
            </div>

            <div class="card">
                <h3>Payment History</h3>
                <p>Last Payment: ₹1000 (01-Oct-2025)</p>
                <p>Next Due: 01-Dec-2025</p>
                <button class="btn">Pay Now</button>
            </div>

        </div>
    </div>

    <footer>
        <p>© 2025 The Royal Gym | Designed by Vishal  Patil</p>
    </footer>
</form>
</body>
</html>
