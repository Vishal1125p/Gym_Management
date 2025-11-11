<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<!-- ====== The Royal Gym Footer Start ====== -->
<footer class="bg-black text-light pt-5 pb-3 mt-5 border-top border-warning">
  <div class="container">
    <div class="row">

      <!-- Gym Info -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold text-uppercase text-warning mb-3">👑 The Royal Gym</h5>
        <p class="text-secondary">
          Unleash your strength in a royal way! The Royal Gym offers world-class trainers, equipment, and fitness programs to help you reach your best version.
        </p>
        <p class="mb-1">
          <i class="fa-solid fa-location-dot me-2 text-warning"></i> 21 Royal Fitness Road,Satra
        </p>
        <p class="mb-1">
          <i class="fa-solid fa-phone me-2 text-warning"></i> +91 98765 12345
        </p>
        <p>
          <i class="fa-solid fa-envelope me-2 text-warning"></i> info@theroyalgym.com
        </p>
      </div>

      <!-- Quick Links -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold text-uppercase text-warning mb-3">Quick Links</h5>
        <ul class="list-unstyled">
          <li><a href="/about.jsp" class="text-secondary text-decoration-none d-block mb-2"><i class="fa-solid fa-angle-right me-2"></i>About Us</a></li>
          <li><a href="admin/hometrainer.jsp" class="text-secondary text-decoration-none d-block mb-2"><i class="fa-solid fa-angle-right me-2"></i>Our Trainers</a></li>
          <li><a href="admin/gallery.jsp" class="text-secondary text-decoration-none d-block mb-2"><i class="fa-solid fa-angle-right me-2"></i>Gallery</a></li>
          <li><a href="contact.jsp" class="text-secondary text-decoration-none d-block"><i class="fa-solid fa-angle-right me-2"></i>Contact Us</a></li>
        </ul>
      </div>

      <!-- Social Media -->
      <div class="col-md-4 mb-4">
        <h5 class="fw-bold text-uppercase text-warning mb-3">Follow Us</h5>
        <p class="text-secondary mb-3">Join our fitness community and stay updated with Royal news & offers:</p>

        <div class="d-flex gap-3 mb-4">
          <a href="#" class="text-secondary fs-5"><i class="fab fa-facebook-f"></i></a>
          <a href="#" class="text-secondary fs-5"><i class="fab fa-instagram"></i></a>
          <a href="#" class="text-secondary fs-5"><i class="fab fa-twitter"></i></a>
          <a href="#" class="text-secondary fs-5"><i class="fab fa-youtube"></i></a>
        </div>

        <form action="/subscribe" method="post" class="d-flex">
          <input type="email" name="email" class="form-control me-2" placeholder="Your email" required>
          <button type="submit" class="btn btn-warning text-dark fw-bold">Join</button>
        </form>
      </div>
    </div>

    <hr class="border-secondary">

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
      <p class="mb-0 text-secondary">
        © <%= java.time.Year.now() %> The Royal Gym. All rights reserved.
      </p>
      <div class="mt-3 mt-md-0">
        <a href="/terms.jsp" class="text-secondary text-decoration-none me-3">Terms</a>
        <a href="/privacy.jsp" class="text-secondary text-decoration-none me-3">Privacy</a>
        <a href="#" id="backToTop" class="text-secondary text-decoration-none">
          <i class="fa-solid fa-arrow-up me-1"></i>Top
        </a>
      </div>
    </div>
  </div>
</footer>
<!-- ====== The Royal Gym Footer End ====== -->

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Smooth scroll to top
  document.getElementById('backToTop')?.addEventListener('click', function(e) {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
</script>

</body>
</html>
