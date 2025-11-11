<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Membership Plan - The Royal Gym</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
  body { background: #111; color: white; font-family: sans-serif; }
  .membership-section { padding: 60px 20px; text-align: center; }
  .background-overlay { position: absolute; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.5); z-index:-1; }
  .membership-cards { display: flex; flex-wrap: wrap; justify-content: center; gap: 20px; margin-top: 40px; }
  .card { background: rgba(255,255,255,0.05); border-radius: 20px; padding: 20px; width: 250px; text-align: left; cursor: pointer; transition: transform 0.3s; border: 1px solid #FFD700; }
  .card:hover { transform: scale(1.05); box-shadow: 0 0 20px #FFD700; }
  .highlight { border-color: #ff9900; background: rgba(255, 153, 0, 0.1); }
  .price { font-size: 1.5rem; font-weight: bold; color: #FFD700; margin: 10px 0; }
  .desc { font-size: 0.9rem; margin-bottom: 10px; }
  .btn { display: inline-block; margin-top: 15px; background: #FFD700; color: black; padding: 8px 16px; border-radius: 999px; text-decoration: none; font-weight: bold; }
  .btn:hover { background: #e0c200; }
  .hidden { display: none; }
</style>
</head>
<body>

<!-- Step 1: Membership Cards -->
<section id="step1" class="membership-section">
  <h2 class="text-3xl font-bold text-yellow-400">🔥 Become a Royal Member 🔥</h2>
  <p>Unlock access to world-class gym facilities, personalized training, and exclusive member benefits.</p>

  <div class="membership-cards">
    <div class="card" onclick="selectPlan('MONTHLY',2999)">
      <h3>MONTHLY</h3>
      <p class="price">₹2,999</p>
      <p class="desc">Perfect for newcomers looking to try out our premium facilities.</p>
      <ul class="text-gray-300 text-sm list-disc pl-5">
        <li>💪 Access to all gym equipment</li>
        <li>👟 Free personal training (1 session)</li>
        <li>☕ Lounge & steam access</li>
      </ul>
    </div>

    <div class="card highlight" onclick="selectPlan('QUARTERLY',7499)">
      <h3>QUARTERLY</h3>
      <p class="price">₹7,499</p>
      <p class="desc">Best for consistent fitness lovers aiming to transform their body.</p>
      <ul class="text-gray-300 text-sm list-disc pl-5">
        <li>🔥 3 months access to all facilities</li>
        <li>🥗 Personalized diet plan</li>
        <li>🎥 Online workout sessions</li>
      </ul>
    </div>

    <div class="card" onclick="selectPlan('ANNUAL',19999)">
      <h3>ANNUAL</h3>
      <p class="price">₹19,999</p>
      <p class="desc">For dedicated members who are serious about long-term transformation.</p>
      <ul class="text-gray-300 text-sm list-disc pl-5">
        <li>🏋️‍♂️ Unlimited access & priority booking</li>
        <li>💬 Monthly fitness consultation</li>
        <li>🎁 Royal Member T-shirt & benefits</li>
      </ul>
    </div>
  </div>
</section>

<!-- Step 2: Personal Details Form -->
<section id="step2" class="hidden max-w-3xl mx-auto mt-10 p-8 bg-white/10 rounded-2xl">
  <h2 class="text-2xl font-bold text-yellow-400 mb-6">Step 2: Personal Details</h2>
  <form id="memberForm" action="<%= request.getContextPath() %>/MemberRegisterServlet" method="post" class="space-y-4">
    <input type="hidden" id="planInput" name="plan_name">
    <input type="hidden" id="planPriceInput" name="plan_price">

    <div>
      <label class="block text-gray-300 text-sm">Full Name</label>
      <input type="text" name="name" required class="w-full p-2 rounded bg-gray-800 border border-gray-600 text-white">
    </div>
    <div>
      <label class="block text-gray-300 text-sm">Email</label>
      <input type="email" name="email" required class="w-full p-2 rounded bg-gray-800 border border-gray-600 text-white">
    </div>
    <div>
      <label class="block text-gray-300 text-sm">Phone Number</label>
      <input type="text" name="mobile" required class="w-full p-2 rounded bg-gray-800 border border-gray-600 text-white">
    </div>
    <div>
      <label class="block text-gray-300 text-sm">City</label>
      <input type="text" name="city" required class="w-full p-2 rounded bg-gray-800 border border-gray-600 text-white">
    </div>
    <div>
      <label class="block text-gray-300 text-sm">Join Date</label>
      <input type="date" id="join_date" name="join_date" required readonly class="w-full p-2 rounded bg-gray-800 border border-gray-600 text-white">
    </div>

    <button type="button" onclick="showPayment()" class="w-full bg-red-500 hover:bg-red-600 text-white font-bold py-2 rounded-lg text-lg">
      Proceed to Payment
    </button>
  </form>
</section>

<!-- Step 3: Payment -->
<section id="step3" class="hidden max-w-3xl mx-auto mt-10 p-8 bg-white/10 rounded-2xl text-center">
  <h2 class="text-2xl font-bold text-yellow-400 mb-4">Step 3: Payment</h2>
  <p class="text-gray-300 mb-6">Scan the QR code below to simulate your payment and complete registration.</p>
  <div class="flex flex-col items-center space-y-4">
    <img id="paymentQR" src="../img/QR_code.jpg" alt="Payment QR Code" class="w-48 h-48 rounded-xl border-4 border-yellow-400 shadow-lg hover:scale-105 transition">
    <div class="bg-gray-800 text-yellow-300 px-6 py-2 rounded-full text-lg font-bold">
      Pay Amount: ₹<span id="payAmount"></span>
    </div>
    <button onclick="completeRegistration()" class="bg-green-500 hover:bg-green-600 text-white px-10 py-3 rounded-full font-bold shadow-md mt-4">
      Confirm Payment
    </button>
  </div>
</section>

<script>
// Auto-fill today's date
document.getElementById("join_date").value = new Date().toISOString().split('T')[0];

let selectedPlan = null;
let selectedPrice = 0;

function selectPlan(plan, price) {
  selectedPlan = plan;
  selectedPrice = price;
  document.getElementById("planInput").value = plan;
  document.getElementById("planPriceInput").value = price;

  // Hide Step 1 and show Step 2
  document.getElementById("step1").classList.add("hidden");
  document.getElementById("step2").classList.remove("hidden");
}

function showPayment() {
  document.getElementById("step2").classList.add("hidden");
  document.getElementById("step3").classList.remove("hidden");
  document.getElementById("payAmount").innerText = selectedPrice;
}

function completeRegistration() {
  document.getElementById("memberForm").submit();
}
</script>

</body>
</html>
