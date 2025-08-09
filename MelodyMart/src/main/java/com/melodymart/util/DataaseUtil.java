package com.melodymart.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DatabaseUtil {
    private static String url;
    private static String username;
    private static String password;

    static {
        try {
            Properties props = new Properties();
            props.load(DatabaseUtil.class.getClassLoader().getResourceAsStream("db.properties"));
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(url, username, password);
    }
}