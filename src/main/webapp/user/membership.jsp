<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Membership Plan - The Royal Gym</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    video.bg-video {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      object-fit: cover;
      z-index: -1;
      opacity: 0.3;
    }

    .loader {
      width: 80px;
      height: 80px;
      border: 6px solid rgba(255, 255, 255, 0.2);
      border-top: 6px solid #facc15;
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin: 0 auto;
    }
    @keyframes spin { to { transform: rotate(360deg); } }
    .loader-text {
      color: #facc15;
      font-weight: bold;
      font-size: 1.2rem;
      margin-top: 1rem;
      letter-spacing: 1px;
    }

    .input-label {
      font-weight: 500;
      color: #e5e7eb;
      margin-bottom: 4px;
      display: block;
    }

    .input-field {
      width: 100%;
      padding: 10px;
      border-radius: 10px;
      background-color: #1f2937;
      border: 1px solid #374151;
      color: white;
      transition: 0.2s;
    }

    .input-field:focus {
      outline: none;
      border-color: #facc15;
      box-shadow: 0 0 5px #facc15;
    }

    /* Glow effect for send button */
    .glow-btn {
      animation: glow 1.5s infinite alternate;
    }
    @keyframes glow {
      0% { box-shadow: 0 0 10px #facc15; }
      100% { box-shadow: 0 0 25px #facc15; }
    }

    .hidden { display: none; }
  </style>
</head>

<body class="bg-gray-900 text-white min-h-screen">

<!-- ✅ Background Video -->
<video autoplay muted loop class="bg-video">
  <source src="../videos/gymbg.mp4" type="video/mp4">
</video>

<div class="max-w-6xl mx-auto py-10 px-6">

  <!-- ✅ Step 1 -->
  <div id="planStep">
    <h2 class="text-gray-200 text-sm font-semibold mb-4 uppercase tracking-widest">
      Step 1: Choose Your Plan
    </h2>

    <div class="flex flex-col md:flex-row gap-8">
      <div class="bg-white/10 w-full md:w-2/3 p-6 rounded-2xl shadow-lg border border-gray-600">
        <h3 id="selectedPlanTitle" class="text-2xl font-extrabold text-yellow-400 mb-4">
          No Plan Selected
        </h3>
        <ul class="space-y-2 text-gray-200 text-sm">
          <li>💪 Access to premium gym facilities</li>
          <li>🥗 Personalized diet plans</li>
          <li>🎥 Online workout sessions</li>
          <li>🩺 Free health check-up</li>
        </ul>
        <div class="mt-6 bg-blue-800 p-3 rounded-lg text-center text-sm font-medium">
          Select a plan to continue
        </div>
      </div>

      <!-- Plans -->
      <div class="w-full md:w-1/3 space-y-4">
        <div onclick="selectPlan('ANNUAL', 19999)" class="flex justify-between items-center border-2 border-red-400 bg-red-50/20 p-4 rounded-xl cursor-pointer hover:scale-105 transition">
          <div>
            <p class="text-yellow-400 font-bold text-lg">ANNUAL</p>
            <p class="text-xl font-extrabold text-white">₹19,999 <span class="line-through text-gray-400 text-sm ml-2">₹67,270</span></p>
            <p class="text-gray-300 text-sm">₹1,667/month</p>
          </div>
          <div class="text-green-300 text-sm font-bold bg-blue-900 px-2 py-1 rounded">SAVE 70.03%</div>
        </div>

        <div onclick="selectPlan('HALF YEARLY', 11999)" class="flex justify-between items-center border p-4 rounded-xl hover:border-blue-400 cursor-pointer hover:scale-105 transition">
          <div>
            <p class="text-yellow-400 font-bold text-lg">HALF YEARLY</p>
            <p class="text-xl font-extrabold text-white">₹11,999 <span class="line-through text-gray-400 text-sm ml-2">₹33,360</span></p>
            <p class="text-gray-300 text-sm">₹2,000/month</p>
          </div>
          <div class="text-blue-300 text-sm font-bold bg-blue-900 px-2 py-1 rounded">SAVE 64.03%</div>
        </div>

        <div onclick="selectPlan('QUARTERLY', 7499)" class="flex justify-between items-center border p-4 rounded-xl hover:border-blue-400 cursor-pointer hover:scale-105 transition">
          <div>
            <p class="text-yellow-400 font-bold text-lg">QUARTERLY</p>
            <p class="text-xl font-extrabold text-white">₹7,499 <span class="line-through text-gray-400 text-sm ml-2">₹16,390</span></p>
            <p class="text-gray-300 text-sm">₹2,500/month</p>
          </div>
          <div class="text-blue-300 text-sm font-bold bg-blue-900 px-2 py-1 rounded">SAVE 54.25%</div>
        </div>

        <div onclick="selectPlan('MONTHLY', 2999)" class="flex justify-between items-center border p-4 rounded-xl hover:border-blue-400 cursor-pointer hover:scale-105 transition">
          <div>
            <p class="text-yellow-400 font-bold text-lg">MONTHLY</p>
            <p class="text-xl font-extrabold text-white">₹2,999 <span class="line-through text-gray-400 text-sm ml-2">₹5,320</span></p>
            <p class="text-gray-300 text-sm">₹2,999/month</p>
          </div>
          <div class="text-blue-300 text-sm font-bold bg-blue-900 px-2 py-1 rounded">SAVE 43.73%</div>
        </div>
      </div>
    </div>

    <div class="mt-10 text-center space-x-4">
      <a href="<%=request.getContextPath()%>/index.jsp" class="bg-gray-600 text-white font-bold px-10 py-3 rounded-full text-lg shadow-lg transition hover:bg-gray-700">Back</a>
      <button onclick="showForm()" id="continueBtn" disabled class="bg-gray-600 text-white font-bold px-10 py-3 rounded-full text-lg shadow-lg transition disabled:opacity-50">Continue</button>
    </div>
  </div>

  <!-- ✅ Step 2 -->
  <div id="formStep" class="hidden mt-10 bg-white/10 p-8 rounded-2xl shadow-lg backdrop-blur-md">
    <h2 class="text-2xl font-bold text-yellow-400 mb-6 text-center">Step 2: Personal Details</h2>

    <form id="memberForm" action="<%= request.getContextPath() %>/MemberRegisterServlet" method="post" class="grid md:grid-cols-2 gap-6">
      <input type="hidden" id="planInput" name="plan_name">
      <input type="hidden" id="planPriceInput" name="plan_price">

      <div><label class="input-label">Full Name</label><input type="text" name="name" required class="input-field"></div>
      <div><label class="input-label">Email</label><input type="email" name="email" required class="input-field"></div>
      <div><label class="input-label">Phone Number</label><input type="text" name="mobile" required class="input-field"></div>
      <div><label class="input-label">City</label><input type="text" name="city" required class="input-field"></div>
      <div><label class="input-label">Join Date</label><input type="date" id="join_date" name="join_date" required readonly class="input-field"></div>

      <div class="md:col-span-2 text-center space-x-4">
        <button type="button" onclick="goBackToStep1()" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-10 rounded-full text-lg shadow-lg">Back</button>
        <button type="button" onclick="showPayment()" class="bg-red-500 hover:bg-red-600 text-white font-bold py-2 px-10 rounded-full text-lg shadow-lg">Proceed to Payment</button>
      </div>
    </form>
  </div>

  <!-- ✅ Step 3 -->
  <div id="paymentStep" class="hidden mt-10 bg-white/10 p-8 rounded-2xl shadow-lg text-center backdrop-blur-md">
    <h2 class="text-2xl font-bold text-yellow-400 mb-4">Step 3: Payment</h2>
    <p class="text-gray-300 mb-6">Scan the QR code below to simulate your payment.</p>

    <div id="paymentContent">
      <img id="paymentQR" src="../img/QR_code.jpg" alt="Payment QR Code" class="w-48 h-48 rounded-xl border-4 border-yellow-400 shadow-lg hover:scale-105 transition mx-auto">
      <div class="bg-gray-800 text-yellow-300 px-6 py-2 rounded-full text-lg font-bold mt-4 inline-block">
        Pay Amount: ₹<span id="payAmount"></span>
      </div>

      <div class="mt-6 space-x-4">
        <button onclick="goBackToStep2()" class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-8 py-3 rounded-full shadow-md">Back</button>
        <button onclick="simulatePayment()" class="bg-green-500 hover:bg-green-600 text-white px-10 py-3 rounded-full font-bold shadow-md">Confirm Payment</button>
      </div>
    </div>

    <!-- Loader -->
    <div id="loaderSection" class="hidden text-center mt-10">
      <div class="loader"></div>
      <div class="loader-text">Processing Payment...</div>
    </div>

    <!-- ✅ After Payment Completed -->
    <div id="receiptSection" class="hidden text-center mt-10">
      <p class="text-lg text-yellow-300 mb-4">✅ Payment successful!<br><span class="text-gray-300">Send your receipt to:</span></p>
      <input type="email" id="receiptEmail" readonly class="input-field text-center w-72 mx-auto mb-5" value="">
      <button type="button" onclick="sendReceiptNow()" class="bg-yellow-500 hover:bg-yellow-600 text-gray-900 font-bold px-8 py-3 rounded-full shadow-lg glow-btn">✉️ Send Receipt</button>
    </div>
  </div>
</div>

<script>
  let selectedPlan = null;
  let selectedPrice = 0;

  function selectPlan(plan, price) {
    selectedPlan = plan;
    selectedPrice = price;
    document.getElementById("selectedPlanTitle").innerText = `${plan} Plan Selected - ₹${price}`;
    document.getElementById("planInput").value = plan;
    document.getElementById("planPriceInput").value = price;

    const btn = document.getElementById("continueBtn");
    btn.disabled = false;
    btn.classList.remove("bg-gray-600");
    btn.classList.add("bg-red-500");
  }

  function showForm() {
    document.getElementById("planStep").classList.add("hidden");
    document.getElementById("formStep").classList.remove("hidden");
  }

  function showPayment() {
    document.getElementById("formStep").classList.add("hidden");
    document.getElementById("paymentStep").classList.remove("hidden");
    document.getElementById("payAmount").innerText = selectedPrice;
  }

  function goBackToStep1() {
    document.getElementById("formStep").classList.add("hidden");
    document.getElementById("planStep").classList.remove("hidden");
  }

  function goBackToStep2() {
    document.getElementById("paymentStep").classList.add("hidden");
    document.getElementById("formStep").classList.remove("hidden");
  }

  function simulatePayment() {
    document.getElementById("paymentContent").classList.add("hidden");
    document.getElementById("loaderSection").classList.remove("hidden");

    setTimeout(() => {
      document.getElementById("loaderSection").classList.add("hidden");
      document.getElementById("receiptSection").classList.remove("hidden");

      const emailVal = document.querySelector("input[name='email']").value;
      document.getElementById("receiptEmail").value = emailVal;
    }, 3000);
  }

  function sendReceiptNow() {
    document.getElementById("memberForm").submit();
  }

  document.getElementById("join_date").value = new Date().toISOString().split('T')[0];
</script>

</body>
</html>
