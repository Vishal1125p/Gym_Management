<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Us | The Royal Gym</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    body {
      font-family: "Poppins", sans-serif;
      background: linear-gradient(135deg, #0f172a, #111827);
      color: #f8fafc;
    }

    /* 🔰 Card Styling */
    .card {
      background: rgba(17, 24, 39, 0.9);
      backdrop-filter: blur(8px);
      border: 1px solid rgba(255, 255, 255, 0.08);
      border-radius: 18px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 40px rgba(16, 185, 129, 0.25);
    }

    /* 🔰 Input Fields */
    .input-field {
      background: rgba(31, 41, 55, 0.9);
      border: 1px solid #374151;
      border-radius: 8px;
      color: #e2e8f0;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }
    .input-field:focus {
      border-color: #facc15;
      box-shadow: 0 0 10px rgba(250, 204, 21, 0.3);
      outline: none;
    }

    /* 🔰 Toast Notification */
    #toast {
      position: fixed;
      top: 20px;
      right: 20px;
      background: linear-gradient(90deg, #22c55e, #facc15);
      color: #111827;
      padding: 12px 20px;
      border-radius: 8px;
      font-weight: 600;
      box-shadow: 0 4px 20px rgba(0,0,0,0.4);
      opacity: 0;
      display: none;
      z-index: 100;
      transition: opacity 0.5s ease;
    }

    /* 🔰 Button Glow Effect */
    .btn-glow {
      background: linear-gradient(90deg, #10b981, #facc15);
      color: #111827;
      font-weight: bold;
      transition: all 0.3s ease;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(250, 204, 21, 0.4);
    }
    .btn-glow:hover {
      transform: scale(1.05);
      box-shadow: 0 0 25px rgba(250, 204, 21, 0.6);
    }

    /* 🔰 Header */
    header {
      background: rgba(31, 41, 55, 0.85);
      box-shadow: 0 6px 20px rgba(0,0,0,0.5);
    }
  </style>
</head>

<body>

<!-- ✅ Toast Message -->
<div id="toast">✅ Message sent successfully!</div>

<!-- ✅ Header -->
<header class="w-full py-4 sticky top-0 z-50">
  <div class="max-w-7xl mx-auto flex justify-between items-center px-6">
    <h2 class="text-xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-green-400 to-yellow-400">
      The Royal Gym
    </h2>
    <a href="<%= request.getContextPath() %>/index.jsp"
       class="px-4 py-2 bg-gradient-to-r from-yellow-400 to-green-400 text-gray-900 font-bold rounded-lg shadow-lg hover:scale-105 transition">
      <i class="fa-solid fa-house mr-2"></i> Home
    </a>
  </div>
</header>

<!-- ✅ Main Section -->
<section class="max-w-7xl mx-auto px-6 py-20 grid lg:grid-cols-2 gap-12">

  <!-- ✅ Contact Form -->
  <div class="card p-10">
    <h2 class="text-3xl font-bold text-yellow-400 mb-6 flex items-center gap-3">
      <i class="fa-solid fa-paper-plane text-green-400"></i> Send Us a Message
    </h2>

    <form action="<%= request.getContextPath() %>/contactForm" method="post" class="space-y-6" id="contactForm">
      <div>
        <label class="block mb-1 font-semibold text-gray-300">Full Name</label>
        <input type="text" name="name" class="input-field w-full px-4 py-2"  required>
      </div>

      <div>
        <label class="block mb-1 font-semibold text-gray-300">Email Address</label>
        <input type="email" name="email" class="input-field w-full px-4 py-2" placeholder="yourname@gmail.com" required>
      </div>

      <div>
        <label class="block mb-1 font-semibold text-gray-300">Subject</label>
        <input type="text" name="subject" class="input-field w-full px-4 py-2" placeholder="Inquiry about membership" required>
      </div>

      <div>
        <label class="block mb-1 font-semibold text-gray-300">Message</label>
        <textarea name="message" class="input-field w-full px-4 py-2" rows="5" placeholder="Write your message..." required></textarea>
      </div>

      <button type="submit" class="w-full py-3 btn-glow shadow-lg">
        Send Message <i class="fa-solid fa-arrow-right ml-2"></i>
      </button>
    </form>
  </div>

  <!-- ✅ Map & Info -->
  <div class="space-y-8">

    <!-- Map -->
    <div class="card overflow-hidden shadow-lg">
      <iframe class="w-full h-64 md:h-72"
        src="https://www.google.com/maps/place/Bodyline+Gym/@17.685045,73.9893224,14z/data=!4m10!1m2!2m1!1ssatara+gyms!3m6!1s0x3bc239104683409b:0xb550144868ade1b8!8m2!3d17.6893646!4d74.0093289!15sCgtzYXRhcmEgZ3ltc1oNIgtzYXRhcmEgZ3ltc5IBA2d5beABAA!16s%2Fg%2F11qg_y25k3?entry=ttu&g_ep=EgoyMDI1MTEwNC4xIKXMDSoASAFQAw%3D%3D"
        style="border:0;" allowfullscreen="" loading="lazy">
      </iframe>
    </div>

    <!-- Info -->
    <div class="card p-8 space-y-5">
      <h3 class="text-2xl font-bold text-yellow-400"><i class="fa-solid fa-location-dot text-green-400 mr-2"></i> Visit Us</h3>
      <ul class="space-y-3 text-lg text-gray-300">
        <li><i class="fa-solid fa-map-pin text-green-400 mr-2"></i>21 Royal Fitness Road,Satra </li>
        <li><i class="fa-solid fa-phone text-green-400 mr-2"></i> +91 98765 12345</li>
        <li><i class="fa-solid fa-envelope text-green-400 mr-2"></i> support@theroyalgym.com</li>
        <li><i class="fa-solid fa-clock text-green-400 mr-2"></i> Mon - Sun: 5:30 AM - 11:00 PM</li>
      </ul>
    </div>

    

  </div>
</section>

<!-- ✅ Footer -->
<footer class="bg-gray-900 py-6 text-center text-gray-400 border-t border-gray-700">
  © 2025 <span class="text-yellow-400 font-semibold">The Royal Gym</span>. All rights reserved.
</footer>

<!-- ✅ Toast Trigger After Success -->
<script>
  <% if ("1".equals(request.getParameter("success"))) { %>
  const toast = document.getElementById("toast");
  toast.style.display = "block";
  toast.style.opacity = "1";
  setTimeout(() => {
    toast.style.opacity = "0";
    setTimeout(() => { toast.style.display = "none"; }, 500);
  }, 3000);
  <% } %>
</script>

</body>
</html>
