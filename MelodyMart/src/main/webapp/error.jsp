<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%
    Integer code = (Integer) request.getAttribute("javax.servlet.error.status_code");
    if (code == null) { code = 500; }
    response.setStatus(code);
    String title;
    String detail;
    if (code == 404) { title = "Page not found"; detail = "The page you are looking for does not exist or has moved."; }
    else if (code == 403) { title = "Access denied"; detail = "You do not have permission to view this page."; }
    else { title = "Something went wrong"; detail = "An unexpected error occurred. Please try again in a moment."; }
    if (exception != null) { application.log("Unhandled error on " + request.getAttribute("javax.servlet.error.request_uri"), exception); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %> | MelodyMart</title>
    <style>
        body { margin:0; min-height:100vh; display:flex; align-items:center; justify-content:center;
               font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; background:#0f0f12; color:#eee; }
        .box { text-align:center; max-width:28rem; padding:2rem; }
        .code { font-size:4rem; font-weight:700; color:#8a5cf6; margin:0; }
        h1 { font-size:1.5rem; margin:.5rem 0; }
        p { color:#aaa; }
        a { display:inline-block; margin-top:1rem; padding:.6rem 1.2rem; border-radius:.5rem; background:#8a5cf6; color:#fff; text-decoration:none; }
    </style>
</head>
<body>
<div class="box">
    <p class="code"><%= code %></p>
    <h1><%= title %></h1>
    <p><%= detail %></p>
    <a href="<%= request.getContextPath() %>/index.jsp">Back to MelodyMart</a>
</div>
</body>
</html>
