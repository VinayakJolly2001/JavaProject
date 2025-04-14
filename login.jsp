<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login | Student Management System</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #74ebd5, #9face6);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-container {
            background: #fff;
            padding: 30px 25px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            width: 320px;
            box-sizing: border-box;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        input[type="email"],
        input[type="password"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .back-link {
            display: block;
            margin-top: 15px;
            font-size: 14px;
            color: #555;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post" autocomplete="off">
            <!-- Dummy field to confuse autofill -->
            <input type="text" name="dummy" style="display:none" autocomplete="off">
            
            <input type="email" name="email" placeholder="Enter Email" required autocomplete="off">
            <input type="password" name="password" placeholder="Enter Password" required autocomplete="new-password">
            <input type="submit" value="Login">
        </form>
        <a href="index.html" class="back-link">← Back to Home</a>
    </div>
</body>
</html>
