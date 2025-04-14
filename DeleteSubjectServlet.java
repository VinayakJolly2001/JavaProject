package com.sms;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeleteSubjectServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentName") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String subjectIdParam = request.getParameter("id");
        if (subjectIdParam == null || subjectIdParam.isEmpty()) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        int subjectId = Integer.parseInt(subjectIdParam);
        String studentName = (String) session.getAttribute("studentName");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM subjects WHERE subject_id = ? AND student_id = (SELECT id FROM students WHERE name = ?)")) {
            ps.setInt(1, subjectId);
            ps.setString(2, studentName);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("dashboard.jsp"); // Redirect back to dashboard after successful deletion
            } else {
                response.getWriter().println("<div style='color:red;text-align:center;margin-top:20px;'>Error deleting subject or subject does not belong to you.</div>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<div style='color:red;text-align:center;margin-top:20px;'>An error occurred while deleting the subject: " + e.getMessage() + "</div>");
        }
    }
}