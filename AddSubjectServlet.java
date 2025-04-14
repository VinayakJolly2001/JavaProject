package com.sms;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class AddSubjectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentName") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String subjectName = request.getParameter("subjectName");
        String studentName = (String) session.getAttribute("studentName");
        int studentId = -1;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement psSelect = con.prepareStatement("SELECT id FROM students WHERE name = ?")) {
            psSelect.setString(1, studentName);
            try (java.sql.ResultSet rs = psSelect.executeQuery()) {
                if (rs.next()) {
                    studentId = rs.getInt("id");
                } else {
                    response.getWriter().println("Error: Student ID not found.");
                    return;
                }
            }

            PreparedStatement psInsert = con.prepareStatement("INSERT INTO subjects (student_id, subject_name) VALUES (?, ?)");
            psInsert.setInt(1, studentId);
            psInsert.setString(2, subjectName);
            int rowsAffected = psInsert.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect back to the dashboard to reload all subjects
                response.sendRedirect("dashboard.jsp");
            } else {
                response.getWriter().println("Error adding subject.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }
}