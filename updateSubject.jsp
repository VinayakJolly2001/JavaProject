<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.sms.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    String name = (String) session.getAttribute("studentName");
    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String subjectIdParam = request.getParameter("id");
    if (subjectIdParam == null || subjectIdParam.isEmpty()) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    int subjectId = Integer.parseInt(subjectIdParam);
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String subjectName = "";

    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT subject_name FROM subjects WHERE subject_id = ? AND student_id = (SELECT id FROM students WHERE name = ?)");
        ps.setInt(1, subjectId);
        ps.setString(2, name);
        rs = ps.executeQuery();
        if (rs.next()) {
            subjectName = rs.getString("subject_name");
        } else {
            response.getWriter().println("<div style='color:red;text-align:center;margin-top:20px;'>Subject not found or does not belong to you.</div>");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("<div style='color:red;text-align:center;margin-top:20px;'>An error occurred while fetching subject details.</div>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Subject</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #fbc2eb, #a6c0ee);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .edit-subject-container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        input[type="hidden"],
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        button {
            background-color: #007bff; /* Bootstrap primary color */
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
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
</head>
<body>
    <div class="edit-subject-container">
        <h2>Edit Subject</h2>
        <form action="EditSubjectServlet" method="post">
            <input type="hidden" name="subjectId" value="<%= subjectId %>">
            <input type="text" name="subjectName" placeholder="Enter New Subject Name" value="<%= subjectName %>" required>
            <button type="submit">Update Subject</button>
        </form>
        <a href="dashboard.jsp" class="back-link">Back to Dashboard</a>
    </div>
</body>
</html>