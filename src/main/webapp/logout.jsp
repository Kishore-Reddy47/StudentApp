<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate session and forward to login with a success message
    try {
        if (session != null) {
            session.invalidate();
        }
    } catch(Exception e) {
        // ignore
    }
    request.setAttribute("success", "You have been logged out successfully.");
    request.getRequestDispatcher("login.jsp").forward(request, response);
%>
