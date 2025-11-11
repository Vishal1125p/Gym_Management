<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym | Body Building</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Poppins', sans-serif;
      overflow-x: hidden;
    }

    .Building {
      position: relative;
      height: 500px;
      color: white;
      text-align: center;
    }

    .slider {
      position: relative;
      height: 800px;
      overflow: hidden;
    }

    .slide {
      position: absolute;
      top: 0; left: 0;
      width: 100%;
      height: 500px;
      background-size: cover;
      background-position: center;
      opacity: 0;
      transition: opacity 1s ease-in-out;
    }

    .slide.active {
      opacity: 1;
    }

    .body-building {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: rgba(0, 0, 0, 0.4);
      padding: 30px;
      border-radius: 15px;
    }

    .body-building h2 {
      font-size: 2.5rem;
      font-weight: bold;
    }

    .body-building p {
      font-size: 1.2rem;
      margin-bottom: 20px;
    }

    .btn-warning {
      background-color: #FFD700;
      color: black;
      border: none;
      font-weight: bold;
      padding: 10px 25px;
      border-radius: 25px;
      text-decoration: none;
      transition: 0.3s ease;
    }

    .btn-warning:hover {
      background-color: #e0c200;
    }

    /* Navigation Buttons */
    .nav-btn {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background-color: rgba(255, 215, 0, 0.8);
      color: black;
      font-size: 24px;
      border: none;
      padding: 10px 15px;
      cursor: pointer;
      border-radius: 50%;
      transition: background 0.3s ease;
      z-index: 10;
    }

    .nav-btn:hover {
      background-color: #e0c200;
    }

    .nav-btn.left {
      left: 20px;
    }

    .nav-btn.right {
      right: 20px;
    }
  </style>
</head>

<body>
  <div class="Building">
    <div id="slider" class="slider">
      <!-- ✅ Add active to first image -->
      <div class="slide active" style="background-image: url('<%=request.getContextPath()%>/img/slider1.jpg');"></div>
      <div class="slide" style="background-image: url('<%=request.getContextPath()%>/img/slider2.jpg');"></div>
      <div class="slide" style="background-image: url('<%=request.getContextPath()%>/img/slider3.jpg');"></div>
      <div class="slide" style="background-image: url('<%=request.getContextPath()%>/img/slider2.jpg');"></div>
    </div>

    <div class="body-building text-white">
      <h2>Body Building</h2>
      <p>Transform your body, mind, and strength with our top-notch trainers and facilities.</p>
	
    </div>

    <!-- Navigation Buttons -->
    <button class="nav-btn left" onclick="prevSlide()">&#10094;</button>
    <button class="nav-btn right" onclick="nextSlide()">&#10095;</button>
  </div>

  <script>
    let currentSlide = 0;
    const slides = document.querySelectorAll('.slide');
    const totalSlides = slides.length;

    function showSlide(index) {
      slides.forEach((slide, i) => {
        slide.classList.toggle('active', i === index);
      });
    }

    function nextSlide() {
      currentSlide = (currentSlide + 1) % totalSlides;
      showSlide(currentSlide);
    }

    function prevSlide() {
      currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
      showSlide(currentSlide);
    }

    // Auto-slide every 4 seconds
    setInterval(nextSlide, 4000);
  </script>
</body>
</html>
