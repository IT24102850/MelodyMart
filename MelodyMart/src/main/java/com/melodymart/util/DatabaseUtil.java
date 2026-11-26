package com.melodymart.util;

import java.sql.Connection;
import java.sql.SQLException;

/** Kept for existing callers; delegates to {@link DBConnection}. */
public final class DatabaseUtil {
    private DatabaseUtil() {
    }

    public static Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }
}
