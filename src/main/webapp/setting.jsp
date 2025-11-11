<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>The Royal Gym | Settings</title>

  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Font Awesome -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
    ::-webkit-scrollbar {
      width: 6px;
    }
    ::-webkit-scrollbar-thumb {
      background: #0284c7; /* Sky Blue */
      border-radius: 10px;
    }
  </style>
</head>
<body class="bg-white text-sky-700 font-[Poppins]">

  <!-- Sidebar Include -->
  <jsp:include page="sidebar.jsp"></jsp:include>

  <!-- Main Layout -->
  <div class="ml-64 flex flex-col min-h-screen">

    <!-- Header -->
    <header class="bg-sky-600 shadow-md sticky top-0 z-50 flex items-center justify-between px-10 py-4 border-b-4 border-sky-700 text-white">
      <h2 class="text-2xl font-bold text-white flex items-center gap-2">
        <i class="fa-solid fa-gear"></i> Settings
      </h2>
      <div class="flex items-center space-x-4">
        <span>Welcome, <b>Admin</b></span>
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
             class="w-11 h-11 rounded-full border-2 border-white shadow-lg">
      </div>
    </header>

    <!-- Settings Content -->
    <main class="flex-1 bg-sky-50 p-10 space-y-10">

      <!-- Section 1: Admin Profile -->
      <section class="bg-white border border-sky-500 rounded-2xl shadow-lg p-6">
        <h2 class="text-xl font-semibold text-sky-700 mb-6 flex items-center gap-2">
          <i class="fa-solid fa-user"></i> Admin Profile
        </h2>

        <form action="UpdateAdminServlet" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label class="block text-sm text-sky-700 mb-2">Full Name</label>
            <input type="text" name="name" value="Admin"
                   class="w-full px-4 py-2 rounded-lg border border-sky-500 focus:ring-2 focus:ring-sky-400 outline-none">
          </div>

          <div>
            <label class="block text-sm text-sky-700 mb-2">Email</label>
            <input type="email" name="email" value="admin@royalgym.com"
                   class="w-full px-4 py-2 rounded-lg border border-sky-500 focus:ring-2 focus:ring-sky-400 outline-none">
          </div>

          <div>
            <label class="block text-sm text-sky-700 mb-2">Phone Number</label>
            <input type="text" name="phone" value="9876543210"
                   class="w-full px-4 py-2 rounded-lg border border-sky-500 focus:ring-2 focus:ring-sky-400 outline-none">
          </div>

          <div>
            <label class="block text-sm text-sky-700 mb-2">Profile Picture URL</label>
            <input type="text" name="profile" placeholder="Enter image URL..."
                   class="w-full px-4 py-2 rounded-lg border border-sky-500 focus:ring-2 focus:ring-sky-400 outline-none">
          </div>

          <div class="col-span-2 text-right">
            <button type="submit"
                    class="bg-sky-600 hover:bg-sky-700 text-white font-semibold px-6 py-2 rounded-lg shadow-md transition transform hover:-translate-y-1">
              <i class="fa-solid fa-floppy-disk mr-2"></i> Save Changes
            </button>
          </div>
        </form>
      </section>

      <!-- Section 2: Change Password -->
      <section class="bg-white border border-sky-500 rounded-2xl shadow-lg p-6">
        <h2 class="text-xl font-semibold text-sky-700 mb-6 flex items-center gap-2">
          <i class="fa-solid fa-lock"></i> Change Password
        </h2>

        <form action="ChangePasswordServlet" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div>
            <label class="block text-sm text-sky-700 mb-2">Current Password</label>
            <input type="password" name="currentPassword" required
                   class="w-full px-4 py-2 rounded-lg border border-sky-500 focus:ring-2 focus:ring-sky-400 outline-none">
          </div>

          <div>
            <label class="block text-sm text-sky-700 mb-2">New Password</label>
            <input type="password" name="newPassword" required
                   class="w-full px-4 py-2 rounded-lg border border-sky-500 focus:ring-2 focus:ring-sky-400 outline-none">
          </div>

          <div>
            <label class="block text-sm text-sky-700 mb-2">Confirm Password</label>
            <input type="password" name="confirmPassword" required
                   class="w-full px-4 py-2 rounded-lg border border-sky-500 focus:ring-2 focus:ring-sky-400 outline-none">
          </div>

          <div class="col-span-3 text-right">
            <button type="submit"
                    class="bg-sky-600 hover:bg-sky-700 text-white font-semibold px-6 py-2 rounded-lg shadow-md transition transform hover:-translate-y-1">
              <i class="fa-solid fa-key mr-2"></i> Update Password
            </button>
          </div>
        </form>
      </section>

      <!-- Section 3: Preferences -->
      <section class="bg-white border border-sky-500 rounded-2xl shadow-lg p-6">
        <h2 class="text-xl font-semibold text-sky-700 mb-6 flex items-center gap-2">
          <i class="fa-solid fa-sliders"></i> Preferences
        </h2>

        <form action="UpdatePreferenceServlet" method="post" class="space-y-4">
          <div class="flex items-center justify-between">
            <span>Enable Notifications</span>
            <input type="checkbox" name="notifications"
                   class="w-5 h-5 text-sky-600 rounded focus:ring-2 focus:ring-sky-400">
          </div>

          <div class="flex items-center justify-between">
            <span>Dark Mode</span>
            <input type="checkbox" name="darkmode"
                   class="w-5 h-5 text-sky-600 rounded focus:ring-2 focus:ring-sky-400">
          </div>

          <div class="flex items-center justify-between">
            <span>Auto Backup</span>
            <input type="checkbox" name="backup"
                   class="w-5 h-5 text-sky-600 rounded focus:ring-2 focus:ring-sky-400">
          </div>

          <div class="text-right mt-6">
            <button type="submit"
                    class="bg-sky-600 hover:bg-sky-700 text-white font-semibold px-6 py-2 rounded-lg shadow-md transition transform hover:-translate-y-1">
              <i class="fa-solid fa-save mr-2"></i> Save Preferences
            </button>
          </div>
        </form>
      </section>

    </main>
  </div>
</body>
</html>
