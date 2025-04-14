<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Signup | Student Management System</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #c3cfe2, #c3e0e5);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .signup-container {
      background-color: #fff;
      padding: 40px 30px;
      border-radius: 15px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
      width: 400px;
      text-align: center;
    }

    h2 {
      color: #2c3e50;
      margin-bottom: 25px;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 15px;
    }

    input[type="submit"] {
      background-color: #27ae60;
      color: white;
      border: none;
      padding: 12px;
      font-size: 16px;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      margin-top: 15px;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #219150;
    }

    .back-link {
      display: block;
      margin-top: 20px;
      font-size: 14px;
      color: #555;
      text-decoration: none;
    }

    .back-link:hover {
      text-decoration: underline;
    }
  </style>

  <script>
    function validateForm() {
      const name = document.forms["signupForm"]["name"].value;
      const email = document.forms["signupForm"]["email"].value;
      const password = document.forms["signupForm"]["password"].value;

      const nameRegex = /^[A-Za-z\s]+$/;
      const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/;

      if (!nameRegex.test(name)) {
        alert("Name should contain only alphabets and spaces.");
        return false;
      }

      if (!passwordRegex.test(password)) {
        alert("Password must include at least one letter, one number, and one special character.");
        return false;
      }

      return true;
    }
  </script>
</head>
<body>
  <div class="signup-container">
    <h2>Signup Form</h2>
    <form name="signupForm" onsubmit="return validateForm()" method="post" action="SignupServlet" autocomplete="off">
      <!-- Hidden dummy field to prevent autofill -->
      <input type="text" name="dummy" style="display:none" autocomplete="off">
      
      <input type="text" name="name" placeholder="Enter Your Name" required autocomplete="off"><br>
      <input type="text" name="email" placeholder="Enter Your Email" required autocomplete="off"><br>
      <input type="password" name="password" placeholder="Create a Password" required autocomplete="new-password"><br>
      <input type="submit" value="Sign Up">
    </form>
    <a href="index.html" class="back-link">← Back to Home</a>
  </div>
</body>
</html>

