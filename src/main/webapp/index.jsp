<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>The Royal Gym</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

  <!-- Custom CSS -->
  <link rel="stylesheet" href="css/gym.css">
</head>
<body>
	  <jsp:include page="navbar.jsp"></jsp:include>
	
   <!-- ✅ Hero Section -->
  
  	<jsp:include page="firstmain.jsp"></jsp:include>
  		
  	  <jsp:include page="admin/hometrainer.jsp"></jsp:include>

  <!-- ✅ Include Other JSPs -->
      <jsp:include page="admin/gallery.jsp"></jsp:include>
  
    <jsp:include page="homemembership.jsp"></jsp:include>
  
  <jsp:include page="footer.jsp"></jsp:include>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const userEmail = "<%= session.getAttribute("userEmail") %>";

    if (!userEmail || userEmail === "null") {
      setTimeout(function () {
        const registerModal = new bootstrap.Modal(document.getElementById('userRegisterModal'));
        registerModal.show();
      }, 450000); 
    }
  });
</script>
</body>
</html>
