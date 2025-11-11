<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Profile - The Royal Gym</title>
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    
    <style>
        /* Base styles */
        body {
            background: linear-gradient(135deg, #1f2937, #111827);
            min-height: 100vh;
        }

        /* NEW MODAL STYLING */
        /* Modal Backdrop/Overlay */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7); 
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 50;
        }

        /* Modal Box Styling - RE-INTRODUCED AUTO SCROLL + MAX HEIGHT */
        .modal-content {
            width: 720px; 
            max-width: 90%; 
            max-height: 90vh; /* Re-added max-height for responsive overflow */
            overflow-y: auto; /* Re-added auto overflow */
            border-radius: 0.75rem; 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.8); 
            transform: scale(1); 
        }

        /* --- INVISIBLE SCROLLER STYLES (The key change) --- */

        /* Hide scrollbar for Chrome, Safari and Opera (Webkit browsers) */
        .modal-content::-webkit-scrollbar {
            width: 0px;
            background: transparent; /* make scrollbar transparent */
        }
        .modal-content::-webkit-scrollbar-thumb {
            background: transparent; /* make scrollbar thumb transparent */
        }

        /* Hide scrollbar for IE and Edge */
        .modal-content {
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }
        
        /* --- END INVISIBLE SCROLLER STYLES --- */
        
        /* Input Field Overrides (Simulating the readonly look) */
        .form-input-readonly {
            background-color: #374151; 
            color: #f9fafb; 
            font-weight: 500;
            border: 1px solid #4b5563; 
            padding: 0.75rem;
            border-radius: 0.5rem;
            transition: border-color 0.2s;
        }

        .form-input-readonly:hover {
            border-color: #facc15; 
        }
        
        /* Status Badges */
        .status-active {
            background-color: #16a34a; 
            color: white;
            font-weight: bold;
        }
        .status-expired {
            background-color: #dc2626; 
            color: white;
            font-weight: bold;
        }

        /* Profile picture interactive container styles */
        .profile-pic-clickable {
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .profile-pic-clickable:hover {
            transform: scale(1.1) translateY(-50%);
            box-shadow: 0 0 15px rgba(250, 202, 21, 0.8); 
        }
    </style>
</head>
<body>

<%
    String email = (String) session.getAttribute("userEmail");

    if (email == null) {
%>
<div class="fixed inset-0 bg-black bg-opacity-75 flex justify-center items-center z-50">
    <div class="bg-gray-800 p-8 rounded-xl text-center shadow-2xl">
        <h3 class="text-yellow-400 mb-4 text-xl font-semibold">You must be logged in to view profile!</h3>
        <button class="bg-yellow-500 hover:bg-yellow-600 text-gray-900 font-bold py-2 px-4 rounded transition duration-150 ease-in-out" 
                onclick="alert('Login Modal functionality requires custom Tailwind/JS setup.')">
            Login
        </button>
    </div>
</div>
<%
    } else {
        String name = "", mobile = "", city = "";
        String plan = "No Plan", price = "0";
        LocalDate joinDate = null, expiryDate = null;
        boolean isActive = false;
        // Placeholder logic to use initials if name is available, otherwise generic 'U'
        String initials = name.isEmpty() ? "U" : name.substring(0, 1).toUpperCase();
        String profileImage = "https://via.placeholder.com/64/FBBF24/1F2937?text=" + initials; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Gym_management", "root", "Vishu@1125");

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM members WHERE email=? ORDER BY join_date DESC LIMIT 1");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            java.time.LocalDate today = java.time.LocalDate.now();

            if (rs.next()) {
                name = rs.getString("name");
                mobile = rs.getString("mobile");
                city = rs.getString("city");
                plan = rs.getString("plan_name");
                price = rs.getString("plan_price");

                java.sql.Date joinDateSQL = rs.getDate("join_date");
                java.sql.Date expiryDateSQL = rs.getDate("expiry_date");

                joinDate = (joinDateSQL != null) ? joinDateSQL.toLocalDate() : today;
                expiryDate = (expiryDateSQL != null) ? expiryDateSQL.toLocalDate() : joinDate.plusDays(30);

                isActive = today.isBefore(expiryDate) || today.isEqual(expiryDate);
                
                // Update initials and dynamic image URL after fetching the name
                initials = name.isEmpty() ? "U" : name.substring(0, 1).toUpperCase();
                profileImage = "https://via.placeholder.com/64/FBBF24/1F2937?text=" + initials;
                
                // Assuming 'profile_image_url' column exists and overrides placeholder
                String retrievedImageUrl = rs.getString("profile_image_url");
                if (retrievedImageUrl != null && !retrievedImageUrl.isEmpty()) {
                    profileImage = retrievedImageUrl;
                }

            }

            con.close();
        } catch(Exception e){
            out.println("<p class='text-red-500 p-4'>Error: " + e.getMessage() + "</p>");
        }
%>

<div class="modal-overlay" id="profileModalOverlay">
    
    <div class="modal-content text-white bg-gray-900 shadow-2xl">
        
        <div class="flex justify-between items-center p-4 border-b border-gray-700">
            <h5 class="text-xl font-semibold"><i class="fas fa-id-badge mr-2 text-yellow-500"></i> Member Profile</h5>
            <button type="button" class="text-gray-400 hover:text-white focus:outline-none" onclick="document.getElementById('profileModalOverlay').style.display='none';">
                 <i class="fas fa-times text-2xl"></i>
            </button>
        </div>
        
        <div class="p-5">
            <div class="profile-card bg-gray-800 rounded-xl shadow-2xl p-0">
                
                <div class="relative pb-10 rounded-t-xl overflow-hidden">
                    <div class="h-20" style="background: linear-gradient(90deg, #facc15 0%, #f97316 100%);"></div>

                    <div class="absolute inset-x-0 top-1/2 flex justify-center transform -translate-y-1/2">
                        <form id="profileImageForm" method="post" enctype="multipart/form-data" action="uploadProfilePic.jsp">
                            <img src="<%= profileImage %>" 
                                 alt="<%= name %> Profile" 
                                 id="mainProfilePic"
                                 class="profile-pic-clickable w-20 h-20 rounded-full border-4 border-gray-800 shadow-xl object-cover" 
                                 title="Click to change image">
                            
                            <input type="file" id="imageUpload" name="profileImage" accept="image/*" class="hidden">
                        </form>
                    </div>
                </div>
                
                <div class="pt-2 pb-6 text-center">
                    <h2 class="text-2xl font-extrabold text-white"><%= name.isEmpty() ? "Guest Member" : name %></h2>
                    <p class="text-sm text-gray-400 mt-1"><i class="fas fa-envelope mr-1 text-yellow-500"></i> <%= email %></p>
                </div>
                
                <hr class="mx-6 border-gray-700">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 p-6">

                    <div class="border-r border-gray-700 pr-4 md:pr-2">
                        <h3 class="text-lg font-bold text-yellow-500 mb-4 flex items-center"><i class="fas fa-user-circle mr-2"></i> Personal Information</h3>
                        
                        <div class="grid grid-cols-1 gap-4">
                            <div class="pb-1">
                                <label class="block text-sm font-medium text-gray-400 mb-1">Mobile Number</label>
                                <input type="text" class="form-input-readonly w-full" value="<%=mobile%>" readonly>
                            </div>
                            <div class="pb-1">
                                <label class="block text-sm font-medium text-gray-400 mb-1">City/Location</label>
                                <input type="text" class="form-input-readonly w-full" value="<%=city%>" readonly>
                            </div>
                        </div>
                    </div>
                    
                    <div class="md:pl-2">
                        <h3 class="text-lg font-bold text-yellow-500 mb-4 flex items-center"><i class="fas fa-calendar-check mr-2"></i> Membership Details</h3>

                        <div class="grid grid-cols-2 gap-4">
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-400 mb-1">Plan</label>
                                <input type="text" class="form-input-readonly w-full" value="<%=plan%>" readonly>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-400 mb-1">Price</label>
                                <input type="text" class="form-input-readonly w-full" value="₹<%=price%>" readonly>
                            </div>
                            <div class="col-span-2"> 
                                <label class="block text-sm font-medium text-gray-400 mb-1">Join Date</label>
                                <input type="text" class="form-input-readonly w-full" value="<%=joinDate%>" readonly>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-gray-400 mb-1">Expiry Date</label>
                                <input type="text" class="form-input-readonly w-full" value="<%=expiryDate%>" readonly>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-gray-400 mb-1">Status</label>
                                <input type="text" class="text-center w-full rounded-lg py-3 tracking-wider <%= isActive ? "status-active" : "status-expired" %>" 
                                       value="<%= isActive ? "ACTIVE" : "EXPIRED" %>" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            
            <div class="mt-8 text-center">
                <a href="<%=request.getContextPath()%>/index.jsp" class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-3 px-6 rounded-lg shadow-xl transition duration-150 ease-in-out transform hover:scale-105 inline-block">
                    home <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Image Update Logic
        const mainPic = document.getElementById('mainProfilePic');
        const fileInput = document.getElementById('imageUpload');
        const profileImageForm = document.getElementById('profileImageForm'); 
        
        // 1. Trigger file input on image click
        if (mainPic) {
            mainPic.addEventListener('click', function() {
                fileInput.click();
            });
        }

        // 2. Add an event listener to preview the image and SUBMIT the form
        if (fileInput) {
            fileInput.addEventListener('change', function(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        mainPic.src = e.target.result;
                        
                        
                        alert('New image selected! (Form submission for database update is currently commented out)');
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
    });
</script>

<% } %>

</body>
</html>