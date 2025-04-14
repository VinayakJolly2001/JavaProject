package com.sms;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        HttpSession session = req.getSession(false); // fetch session if exists
        if (session != null) {
            session.invalidate(); // invalidate session
        }
        res.sendRedirect("index.html"); // redirect to home page
    }
}
