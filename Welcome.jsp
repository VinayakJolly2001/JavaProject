<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.sms.DBConnection" %>
<%@ page session="true" %>
<%
    String name = (String) session.getAttribute("studentName");
    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int studentId = -1;

    try {
        con = DBConnection.getConnection();
        PreparedStatement psSelectId = con.prepareStatement("SELECT id FROM students WHERE name = ?");
        psSelectId.setString(1, name);
        ResultSet rsId = psSelectId.executeQuery();
        if (rsId.next()) {
            studentId = rsId.getInt("id");
        }
        if (rsId != null) rsId.close();
        if (psSelectId != null) psSelectId.close();

        if (studentId != -1) {
            ps = con.prepareStatement("SELECT subject_name FROM subjects WHERE student_id = ?");
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources in a finally block
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <style>
        body {
            font-family: sans-serif;
            background-color: #f4f4f4; /* Light gray background */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .welcome-container {
            background-color: #fff; /* White container */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
            color: #333; /* Dark gray text */
        }

        h2 {
            color: #000; /* Black heading */
            margin-bottom: 20px;
            border-bottom: 1px solid #ccc; /* Light gray separator */
            padding-bottom: 10px;
        }

        h3 {
            color: #555; /* Medium gray text */
            margin-top: 10px;
            margin-bottom: 10px;
            font-size: 1.1em;
        }

        .subjects-container {
            text-align: left;
            margin-top: 20px;
        }

        .subjects-container h3 {
            color: #000; /* Black heading */
            margin-top: 0;
            margin-bottom: 10px;
            font-size: 1.2em;
        }

        .subjects-container ul {
            list-style-type: disc; /* Use bullet points */
            padding-left: 20px;
        }

        .subjects-container li {
            margin-bottom: 5px;
            font-size: 1em;
            color: #333; /* Dark gray text */
        }

        .controls {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .btn {
            padding: 8px 15px;
            border: 1px solid #333; /* Dark gray border */
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            text-decoration: none;
            color: #fff; /* White text */
        }

        .btn-add {
            background-color: #4CAF50; /* Green add button */
            border-color: #4CAF50;
        }

        .btn-add:hover {
            background-color: #45a049;
        }

        .btn-logout {
            background-color: #f44336; /* Red logout button */
            border-color: #f44336;
        }

        .btn-logout:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h2>Hello, <%= name %>!</h2>
        <h3>Course Name: MCA (AIML)</h3>
        <h3>Quota: General</h3>

        <div class="subjects-container">
            <h3>Subjects:</h3>
            <ul>
                <% if (rs != null) {
                    while (rs.next()) { %>
                        <li><%= rs.getString("subject_name") %></li>
                    <% }
                } else { %>
                    <li>No subjects added yet.</li>
                <% } %>
            </ul>
        </div>

        <div class="controls">
            <a href="addSubject.jsp" class="btn btn-add">Add New Subject</a>
            <a href="logout" class="btn btn-logout">Logout</a>
        </div>
    </div>
</body>
</html>
<%
    // Close resources
    if (rs != null) {
        try { rs.close(); } catch (Exception e) {}
    }
    if (ps != null) {
        try { ps.close(); } catch (Exception e) {}
    }
    if (con != null) {
        try { con.close(); } catch (Exception e) {}
    }
%>