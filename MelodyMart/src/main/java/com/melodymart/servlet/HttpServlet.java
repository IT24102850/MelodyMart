package main.java.com.melodymart.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public abstract class HttpServlet {


    protected abstract void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;
}
