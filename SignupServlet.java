package com.sms;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String pass = req.getParameter("password");

        // Regex patterns
        String namePattern = "^[A-Za-z\\s]+$";
        String passPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{6,}$";

        try {
            if (!name.matches(namePattern)) {
                out.println("<h3 style='color:red;'>Invalid name. Only alphabets and spaces are allowed.</h3>");
                return;
            }

            if (!pass.matches(passPattern)) {
                out.println("<h3 style='color:red;'>Password must include at least one letter, one number, and one special character (!@#$%^&*), and be at least 6 characters long.</h3>");
                return;
            }

            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO students (name, email, password) VALUES (?, ?, ?)");

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.executeUpdate();

            // ✅ Show success message and user data in browser
            out.println("<html><body>");
            out.println("<h2 style='color:green;'>Registration Successful!</h2>");
            out.println("<h3>User Details:</h3>");
            out.println("<p><strong>Name:</strong> " + name + "</p>");
            out.println("<p><strong>Email:</strong> " + email + "</p>");
            out.println("<p><strong>Password:</strong> " + pass + "</p>");
            out.println("<br><a href='login.jsp'>Click here to Login</a>");
            out.println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Something went wrong. Please try again.</h3>");
        }
    }
}
