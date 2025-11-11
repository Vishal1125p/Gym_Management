<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Royal Gym - Membership</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="relative h-screen overflow-hidden">

<!-- 🔹 Background Video -->
<video autoplay loop muted playsinline class="absolute top-0 left-0 w-full h-full object-cover opacity-70">
  <source src="your-video.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

<!-- 🔹 Dark overlay for readability -->
<div class="absolute inset-0 bg-black bg-opacity-60"></div>

<!-- 🔹 Main Content -->
<div class="relative z-10 flex flex-col items-center justify-center h-full px-6">

  <!-- STEP 1: PLAN SELECTION -->
  <div id="planSection" class="bg-white bg-opacity-90 backdrop-blur-md rounded-2xl shadow-2xl p-8 max-w-4xl w-full transition-all duration-500">
    <h2 class="text-3xl font-bold text-center text-red-600 mb-6">Choose Your Plan</h2>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <div class="planOption border border-gray-300 hover:border-red-500 p-5 rounded-xl cursor-pointer transition-all duration-300" data-plan="Annual" data-price="19999">
        <p class="text-lg font-bold text-gray-900">ANNUAL</p>
        <p class="text-2xl font-extrabold">₹19,999 <span class="line-through text-gray-400 text-sm ml-2">₹67,270</span></p>
        <p class="text-gray-600 text-sm">₹1,667/month</p>
      </div>

      <div class="planOption border border-gray-300 hover:border-red-500 p-5 rounded-xl cursor-pointer" data-plan="Half-Yearly" data-price="11999">
        <p class="text-lg font-bold text-gray-900">HALF YEARLY</p>
        <p class="text-2xl font-extrabold">₹11,999 <span class="line-through text-gray-400 text-sm ml-2">₹33,360</span></p>
        <p class="text-gray-600 text-sm">₹2,000/month</p>
      </div>

      <div class="planOption border border-gray-300 hover:border-red-500 p-5 rounded-xl cursor-pointer" data-plan="Quarterly" data-price="7499">
        <p class="text-lg font-bold text-gray-900">QUARTERLY</p>
        <p class="text-2xl font-extrabold">₹7,499 <span class="line-through text-gray-400 text-sm ml-2">₹16,390</span></p>
        <p class="text-gray-600 text-sm">₹2,500/month</p>
      </div>

      <div class="planOption border border-gray-300 hover:border-red-500 p-5 rounded-xl cursor-pointer" data-plan="Monthly" data-price="2999">
        <p class="text-lg font-bold text-gray-900">MONTHLY</p>
        <p class="text-2xl font-extrabold">₹2,999 <span class="line-through text-gray-400 text-sm ml-2">₹5,320</span></p>
        <p class="text-gray-600 text-sm">₹2,999/month</p>
      </div>
    </div>

    <div class="text-center mt-8">
      <button id="continueBtn" class="bg-red-600 hover:bg-red-700 text-white font-bold py-3 px-10 rounded-full text-lg transition disabled:opacity-40" disabled>
        Continue
      </button>
    </div>
  </div>

  <!-- STEP 2: PERSONAL DETAILS FORM -->
  <div id="detailsSection" class="hidden bg-white bg-opacity-90 backdrop-blur-md rounded-2xl shadow-2xl p-8 max-w-md w-full transition-all duration-500 transform scale-95 opacity-0">
    <h2 class="text-2xl font-bold text-red-600 mb-4 text-center">Enter Your Personal Details</h2>
    <p id="selectedPlanInfo" class="text-center text-blue-600 font-semibold mb-6"></p>

    <form action="SaveMembershipServlet" method="post">
      <input type="hidden" name="planName" id="planName">
      <input type="hidden" name="planPrice" id="planPrice">

      <input type="text" name="name" placeholder="Full Name" class="w-full mb-3 border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-red-400 focus:outline-none" required>
      <input type="tel" name="mobile" placeholder="Mobile Number" class="w-full mb-3 border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-red-400 focus:outline-none" required>
      <input type="email" name="email" placeholder="Email Address" class="w-full mb-3 border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-red-400 focus:outline-none" required>
      <input type="text" name="city" placeholder="Enter your city" class="w-full mb-5 border border-gray-300 p-3 rounded-lg focus:ring-2 focus:ring-red-400 focus:outline-none" required>

      <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-3 rounded-full transition">
        Confirm & Join Now
      </button>
    </form>
  </div>

</div>

<!-- 🔹 SCRIPT -->
<script>
  const plans = document.querySelectorAll(".planOption");
  const continueBtn = document.getElementById("continueBtn");
  const planSection = document.getElementById("planSection");
  const detailsSection = document.getElementById("detailsSection");
  const selectedPlanInfo = document.getElementById("selectedPlanInfo");
  const planNameInput = document.getElementById("planName");
  const planPriceInput = document.getElementById("planPrice");

  let selectedPlan = null;
  let selectedPrice = null;

  plans.forEach(plan => {
    plan.addEventListener("click", () => {
      plans.forEach(p => p.classList.remove("border-red-500", "bg-red-50"));
      plan.classList.add("border-red-500", "bg-red-50");
      selectedPlan = plan.dataset.plan;
      selectedPrice = plan.dataset.price;
      continueBtn.disabled = false;
    });
  });

  continueBtn.addEventListener("click", () => {
    planSection.classList.add("opacity-0", "scale-95");
    setTimeout(() => {
      planSection.classList.add("hidden");
      detailsSection.classList.remove("hidden");
      setTimeout(() => {
        detailsSection.classList.remove("opacity-0", "scale-95");
        detailsSection.classList.add("opacity-100", "scale-100");
      }, 100);
    }, 300);

    selectedPlanInfo.textContent = `Selected Plan: ${selectedPlan} — ₹${selectedPrice}`;
    planNameInput.value = selectedPlan;
    planPriceInput.value = selectedPrice;
  });
</script>

</body>
</html>
