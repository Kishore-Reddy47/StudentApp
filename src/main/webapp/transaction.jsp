<%@ page import="in.ps.studentapp.dto.Courses" %>
<%@ page import="in.ps.studentapp.dao.CoursesDAO" %>
<%@ page import="in.ps.studentapp.dao.CoursesDAOImpl" %>
<%@ page import="in.ps.studentapp.dto.Student" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background: linear-gradient(135deg,#eef2f6,#dfe9f3); font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
.container { max-width:640px; margin-top:40px; }
.card { border-radius:12px; }
</style>
</head>
<body>
<div class="container">
<%
    Student s = (Student) session.getAttribute("student");
    if (s == null) {
        request.setAttribute("error", "Please login before making a payment.");
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
        return;
    }

    String courseIdStr = request.getParameter("courseId");
    if (courseIdStr == null) {
        // nothing selected, go back
        request.setAttribute("error", "No course selected for enrollment.");
        RequestDispatcher rd = request.getRequestDispatcher("courses.jsp");
        rd.forward(request, response);
        return;
    }
    int courseId = 0;
    try { courseId = Integer.parseInt(courseIdStr); } catch(Exception ex) { 
        request.setAttribute("error", "Invalid course selected.");
        RequestDispatcher rd = request.getRequestDispatcher("courses.jsp");
        rd.forward(request, response);
        return;
    }
    CoursesDAO cdao = new CoursesDAOImpl();
    Courses course = cdao.getCourses(courseId);
    if (course == null) {
        request.setAttribute("error", "Selected course not found.");
        RequestDispatcher rd = request.getRequestDispatcher("courses.jsp");
        rd.forward(request, response);
        return;
    }
%>

<div class="card shadow-sm">
  <div class="card-body">
    <h4 class="card-title">Confirm Payment</h4>
    <p class="text-muted">Student: <strong><%= s.getName() %></strong> &nbsp; | &nbsp; Email: <%= s.getMail() %></p>
    <hr/>
    <h5><%= course.getCourseName() %></h5>
    <p><%= course.getCourseInfo() != null ? course.getCourseInfo() : "Course details" %></p>
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div>
        <div class="text-muted small">Duration</div>
        <div class="fw-bold"><%= course.getMonths() %> months</div>
      </div>
      <div class="text-end">
        <div class="text-muted small">Fees</div>
        <div class="fs-4 fw-bold">₹<%= course.getFees() %></div>
      </div>
    </div>

    <!-- Payment form posts to Enroll servlet which handles uploads -->
    <form action="<%= request.getContextPath() %>/submit" method="post" enctype="multipart/form-data" onsubmit="this.querySelector('button[type=submit]').disabled=true;">
      <input type="hidden" name="courseId" value="<%= course.getCourseId() %>" />

      <div class="mb-3">
        <label for="tranId" class="form-label">Transaction ID</label>
        <input type="text" class="form-control" id="tranId" name="tranId" required placeholder="Enter transaction/UTR/ID">
      </div>

      <div class="mb-3">
        <label for="method" class="form-label">Payment Method</label>
        <select class="form-select" id="method" name="method" required>
          <option value="UPI">UPI</option>
          <option value="NetBanking">NetBanking</option>
          <option value="Card">Card</option>
          <option value="Cash">Cash</option>
        </select>
      </div>

      <div class="mb-3">
        <label for="proof" class="form-label">Payment proof (optional)</label>
        <input class="form-control" type="file" id="proof" name="proof" accept="application/pdf,image/*">
        <div class="form-text">Attach PDF or image if you have a payment receipt.</div>
      </div>

      <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">Submit Payment & Enroll</button>
        <a href="courses.jsp" class="btn btn-outline-secondary">Cancel</a>
      </div>
    </form>

  </div>
</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>