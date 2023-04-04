package com.example.assets_hoa;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class DB {

    public static final String DB_URL = "jdbc:mysql://localhost:3306/hoadb?useTimezone=true&serverTimezone=UTC" +
            "&user=root&password=12345678&useSSL=FALSE";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, "root", "12345678");
            return conn;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}

