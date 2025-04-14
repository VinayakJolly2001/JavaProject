package com.sms;

import java.sql.*;

public class DBConnection {

    static Connection getConnection;
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/student_db", "root", "#Vinayak2001");
    }

}
