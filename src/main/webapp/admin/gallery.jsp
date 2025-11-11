<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym | Gallery</title>

  <!-- ✅ Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- ✅ Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Anton&family=Roboto:wght@400;700&display=swap" rel="stylesheet">

  <style>
    /* 🌟 Gallery Section Styling */
    .gallery-section {
      background: radial-gradient(circle at top, #000000, #1a1a1a 80%);
      color: white;
      font-family: 'Roboto', sans-serif;
      overflow-x: hidden;
      padding-bottom: 80px;
    }

    .gallery-section h1 {
      font-family: 'Anton', sans-serif;
      letter-spacing: 3px;
      text-transform: uppercase;
      text-align: center;
      margin-top: 50px;
      font-size: 3rem;
      color: #FFD700;
      text-shadow: 0 0 10px #FFD700;
    }

    /* 3D Slider Container */
    .gallery-slider {
      position: relative;
      width: 400px;
      height: 400px;
      margin: 100px auto;
      transform-style: preserve-3d;
      animation: galleryRotate 20s infinite linear;
    }

    .gallery-slider span {
      position: absolute;
      width: 100%;
      height: 100%;
      transform-origin: center;
      transform-style: preserve-3d;
      transform: rotateY(calc(var(--i) * 45deg)) translateZ(500px);
      transition: transform 1s;
    }

    .gallery-slider span img {
      position: absolute;
      width: 100%;
      height: 100%;
      border-radius: 20px;
      object-fit: cover;
      box-shadow: 0 0 20px #FFD700;
      border: 3px solid #FFD700;
      transition: 0.5s ease;
    }

    .gallery-slider span img:hover {
      transform: scale(1.08);
      box-shadow: 0 0 35px #ffcc00, 0 0 70px #ffcc00;
    }

    @keyframes galleryRotate {
      0% { transform: rotateY(0deg); }
      100% { transform: rotateY(360deg); }
    }

    /* Hover Pause */
    .gallery-slider:hover {
      animation-play-state: paused;
    }

    /* Golden glow behind slider */
    .gallery-light-effect {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 700px;
      height: 700px;
      background: radial-gradient(circle, rgba(255,215,0,0.15), transparent 70%);
      filter: blur(80px);
      z-index: -1;
    }

    
  </style>
</head>

<body>

  <!-- ✅ GALLERY SECTION -->
  <section class="gallery-section">
    <h1>Our Gym Gallery</h1>

    <!-- 3D Rotating Image Slider -->
    <div class="gallery-slider">
      <span style="--i:1;"><img src="<%=request.getContextPath()%>/img/s1.webp" alt="Gym Image 1"></span>
      <span style="--i:2;"><img src="<%=request.getContextPath()%>/img/s2.jpg" alt="Gym Image 2"></span>
      <span style="--i:3;"><img src="<%=request.getContextPath()%>/img/s3.webp" alt="Gym Image 3"></span>
      <span style="--i:4;"><img src="<%=request.getContextPath()%>/img/s4.webp" alt="Gym Image 4"></span>
      <span style="--i:5;"><img src="<%=request.getContextPath()%>/img/s5.webp" alt="Gym Image 5"></span>
      <span style="--i:6;"><img src="<%=request.getContextPath()%>/img/s6.webp" alt="Gym Image 6"></span>
      <span style="--i:7;"><img src="<%=request.getContextPath()%>/img/s7.webp" alt="Gym Image 7"></span>
      <span style="--i:8;"><img src="<%=request.getContextPath()%>/img/s8.webp" alt="Gym Image 8"></span>
      <span style="--i:9;"><img src="<%=request.getContextPath()%>/img/s9.webp" alt="Gym Image 4"></span>
      <span style="--i:10;"><img src="<%=request.getContextPath()%>/img/s10.webp" alt="Gym Image 5"></span>
      <span style="--i:11;"><img src="<%=request.getContextPath()%>/img/s11.webp" alt="Gym Image 6"></span>
      
      
      <div class="gallery-light-effect"></div>
    </div>

   
  </section>

  <!-- ✅ Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
