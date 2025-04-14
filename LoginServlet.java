package com.sms;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT name FROM students WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");

                HttpSession session = req.getSession();
                session.setAttribute("studentName", name);
                
                res.sendRedirect("Welcome.jsp");
            } else {
                res.getWriter().println("The user is not registered. Please Sign Up first.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("An error occurred.");
        }
    }
}
