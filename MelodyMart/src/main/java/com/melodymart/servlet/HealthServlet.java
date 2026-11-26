package com.melodymart.servlet;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.melodymart.util.DBConnection;

/**
 * Liveness/readiness probe for the hosting platform.
 * GET /health returns 200 when the app is up; add ?db=true to also check the database.
 */
@WebServlet("/health")
public class HealthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-store");
        if ("true".equalsIgnoreCase(request.getParameter("db"))) {
            boolean ok = DBConnection.isHealthy();
            response.setStatus(ok ? HttpServletResponse.SC_OK : HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            response.getWriter().write("{\"status\":\"" + (ok ? "UP" : "DOWN") + "\",\"database\":\"" + (ok ? "UP" : "DOWN") + "\"}");
        } else {
            response.getWriter().write("{\"status\":\"UP\"}");
        }
    }
}
