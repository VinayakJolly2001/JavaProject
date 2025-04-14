package com.sms;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class EditSubjectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentName") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        String subjectName = request.getParameter("subjectName");
        String studentName = (String) session.getAttribute("studentName");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE subjects SET subject_name = ? WHERE subject_id = ? AND student_id = (SELECT id FROM students WHERE name = ?)")) {
            ps.setString(1, subjectName);
            ps.setInt(2, subjectId);
            ps.setString(3, studentName);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("dashboard.jsp");
            } else {
                response.getWriter().println("Error updating subject or subject does not belong to you.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }
}