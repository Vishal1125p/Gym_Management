<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym | Sidebar</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-gray-100">

  <!-- Sidebar -->
  <aside class="w-64 h-screen bg-sky-600 text-white flex flex-col justify-between p-6 fixed shadow-xl">

    <!-- Logo Section -->
    <div>
      <h2 class="text-center text-3xl font-extrabold mb-10 tracking-wider uppercase 
                 bg-white text-sky-600 py-3 rounded-lg shadow-md">
        The Royal Gym
      </h2>

      <ul class="space-y-3">
        <li>
          <a href="adminDashboard.jsp" 
             class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white hover:text-sky-600 transition-all shadow-sm">
            <i class="fa-solid fa-gauge-high w-5"></i> Dashboard
          </a>
        </li>
        <li>
          <a href="trainer.jsp" 
             class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white hover:text-sky-600 transition-all shadow-sm">
            <i class="fa-solid fa-dumbbell w-5"></i> Trainers
          </a>
        </li>
         <li>
          <a href="admin_cantact_list.jsp" 
             class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white hover:text-sky-600 transition-all shadow-sm">
            <i class="fa-solid fa-envelope"></i> Contact
          </a>
        </li>
        <li>
          <a href="totaluser.jsp" 
             class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white hover:text-sky-600 transition-all shadow-sm">
            <i class="fa-solid fa-users w-5"></i> Total User
          </a>
        </li>
        <li>
          <a href="user/members.jsp" 
             class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white hover:text-sky-600 transition-all shadow-sm">
            <i class="fa-solid fa-user-group w-5"></i> Members
          </a>
        </li>
        <li>
          <a href="equipment.jsp" 
             class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white hover:text-sky-600 transition-all shadow-sm">
            <i class="fa-solid fa-weight-hanging w-5"></i> Equipment
          </a>
        </li>
        <li>
          <a href="setting.jsp" 
             class="flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-white hover:text-sky-600 transition-all shadow-sm">
            <i class="fa-solid fa-gear w-5"></i> Settings
          </a>
        </li>
      </ul>
    </div>

    <!-- Logout Button -->
    <a href="<%=request.getContextPath()%>/index.jsp"
       class="block text-center bg-white text-sky-600 font-bold py-3 rounded-lg shadow-lg hover:bg-sky-700 hover:text-white transition-all">
       <i class="fa-solid fa-right-from-bracket mr-2"></i> Logout
    </a>

  </aside>

</body>
</html>
