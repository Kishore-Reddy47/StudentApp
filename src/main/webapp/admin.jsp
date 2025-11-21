<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, in.ps.studentapp.dao.*, in.ps.studentapp.dto.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f8f9fa; }
    .page-heading { padding: 18px 0; }
    .msg { padding: 10px; margin-bottom: 10px; }
    .error { padding: 10px; margin-bottom: 10px; }
    .form-inline { display: inline; }
    .panel { background: #fff; padding: 18px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Admin</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="admin.jsp">Dashboard</a>
        </li>
      </ul>
      <form method="post" action="logout.jsp" class="d-flex">
        <button class="btn btn-outline-light" type="submit">Logout</button>
      </form>
    </div>
  </div>
</nav>

<div class="container py-4">
<div class="page-heading d-flex justify-content-between align-items-center">
    <h1 class="h3">Admin Dashboard</h1>
</div>

<%
    String action = request.getParameter("action");
    String message = null;
    String error = null;

    StudentDAO sdao = new StudentDAOImpl();
    CoursesDAO cdao = new CoursesDAOImpl();
    PaymentsDAO pdao = new PaymentDAOImpl();

    try {
        if ("deleteStudent".equals(action)) {
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            boolean ok = sdao.deleteStudent(id);
            message = ok ? "Student deleted successfully." : "Failed to delete student.";
        } else if ("addCourse".equals(action) && "POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("courseName");
            String info = request.getParameter("courseInfo");
            String monthsStr = request.getParameter("months");
            String feesStr = request.getParameter("fees");
            Courses c = new Courses();
            c.setCourseName(name);
            c.setCourseInfo(info);
            try { c.setMonths(Integer.parseInt(monthsStr)); } catch(Exception ex){ c.setMonths(0); }
            try { c.setFees(Double.parseDouble(feesStr)); } catch(Exception ex){ c.setFees(0); }
            boolean ok = cdao.insertCourse(c);
            message = ok ? "Course added successfully." : "Failed to add course.";
        } else if ("deleteCourse".equals(action)) {
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            boolean ok = cdao.deleteCourse(id);
            message = ok ? "Course deleted successfully." : "Failed to delete course.";
        } else if ("updateCourse".equals(action) && "POST".equalsIgnoreCase(request.getMethod())) {
            String idStr = request.getParameter("id");
            String name = request.getParameter("courseName");
            String info = request.getParameter("courseInfo");
            String monthsStr = request.getParameter("months");
            String feesStr = request.getParameter("fees");
            int id = Integer.parseInt(idStr);
            Courses c = cdao.getCourses(id);
            if (c != null) {
                c.setCourseName(name);
                c.setCourseInfo(info);
                try { c.setMonths(Integer.parseInt(monthsStr)); } catch(Exception ex){ }
                try { c.setFees(Double.parseDouble(feesStr)); } catch(Exception ex){ }
                boolean ok = cdao.updateCourse(c);
                message = ok ? "Course updated successfully." : "Failed to update course.";
            } else {
                error = "Course not found for update.";
            }
        } else if ("approvePayment".equals(action)) {
            String idStr = request.getParameter("id");
            String status = request.getParameter("status"); // expected "successful" or "failed"
            int id = Integer.parseInt(idStr);
            Payment pay = pdao.getPayment(id);
            if (pay != null) {
                pay.setStatus(status);
                boolean ok = pdao.updatePayment(pay);
                message = ok ? "Payment status updated." : "Failed to update payment status.";
            } else {
                error = "Payment not found.";
            }
        }
    } catch(Exception ex) {
        error = ex.getMessage();
        ex.printStackTrace();
    }
%>

<% if (message != null) { %>
    <div class="alert alert-success"><%= message %></div>
<% } %>
<% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
<% } %>

<div class="panel mb-4">
<h2 class="h5">Users</h2>
<form method="get" action="admin.jsp" class="mb-2">
    <input type="hidden" name="action" value="viewUsers" />
    <button type="submit" class="btn btn-sm btn-secondary">Refresh Users</button>
</form>
<%
    ArrayList<Student> students = sdao.getStudent();
    if (students != null && students.size() > 0) {
%>
<table class="table table-striped table-hover">
    <thead class="table-light">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Mail</th>
        <th>Phone</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Student st : students) { %>
    <tr>
        <td><%= st.getId() %></td>
        <td><%= st.getName() %></td>
        <td><%= st.getMail() %></td>
        <td><%= st.getPhone() %></td>
        <td>
            <form class="form-inline d-inline" method="post" action="admin.jsp">
                <input type="hidden" name="action" value="deleteStudent" />
                <input type="hidden" name="id" value="<%= st.getId() %>" />
                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Delete this user?');">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } else { %>
    <p>No users found.</p>
<% } %>
</div>

<div class="panel mb-4">
<h2 class="h5">Courses</h2>
<!-- Add Course form -->
<h3 class="h6">Add Course</h3>
<form method="post" action="admin.jsp" class="row g-2 mb-3">
    <input type="hidden" name="action" value="addCourse" />
    <div class="col-md-6">
        <input class="form-control" placeholder="Course Name" type="text" name="courseName" required />
    </div>
    <div class="col-md-6">
        <input class="form-control" placeholder="Course Info" type="text" name="courseInfo" required />
    </div>
    <div class="col-md-4">
        <input class="form-control" placeholder="Months" type="number" name="months" min="0" required />
    </div>
    <div class="col-md-4">
        <input class="form-control" placeholder="Fees" type="number" step="0.01" name="fees" required />
    </div>
    <div class="col-md-4">
        <button class="btn btn-primary w-100" type="submit">Add Course</button>
    </div>
</form>

<%
    ArrayList<Courses> courses = cdao.getCourses();
    if (courses != null && courses.size() > 0) {
%>
<table class="table table-bordered table-hover">
    <thead class="table-light">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Info</th>
        <th>Months</th>
        <th>Fees</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Courses cr : courses) { %>
    <tr>
        <td><%= cr.getCourseId() %></td>
        <td><%= cr.getCourseName() %></td>
        <td><%= cr.getCourseInfo() %></td>
        <td><%= cr.getMonths() %></td>
        <td><%= cr.getFees() %></td>
        <td>
            <form class="form-inline d-inline" method="get" action="admin.jsp">
                <input type="hidden" name="action" value="showUpdateCourse" />
                <input type="hidden" name="id" value="<%= cr.getCourseId() %>" />
                <button type="submit" class="btn btn-sm btn-outline-secondary">Edit</button>
            </form>
            <form class="form-inline d-inline" method="post" action="admin.jsp">
                <input type="hidden" name="action" value="deleteCourse" />
                <input type="hidden" name="id" value="<%= cr.getCourseId() %>" />
                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Delete this course?');">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } else { %>
    <p>No courses available.</p>
<% } %>
</div>

<%
    // If the user clicked Edit on a course, show the update form
    if ("showUpdateCourse".equals(action)) {
        String idStr = request.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            Courses cr = cdao.getCourses(id);
            if (cr != null) {
%>
<div class="panel mb-4">
<h3 class="h6">Update Course (ID: <%= cr.getCourseId() %>)</h3>
<form method="post" action="admin.jsp" class="row g-2">
    <input type="hidden" name="action" value="updateCourse" />
    <input type="hidden" name="id" value="<%= cr.getCourseId() %>" />
    <div class="col-md-6"><input class="form-control" type="text" name="courseName" value="<%= cr.getCourseName() %>" required /></div>
    <div class="col-md-6"><input class="form-control" type="text" name="courseInfo" value="<%= cr.getCourseInfo() %>" required /></div>
    <div class="col-md-4"><input class="form-control" type="number" name="months" value="<%= cr.getMonths() %>" min="0" required /></div>
    <div class="col-md-4"><input class="form-control" type="number" step="0.01" name="fees" value="<%= cr.getFees() %>" required /></div>
    <div class="col-md-4"><button class="btn btn-success w-100" type="submit">Update Course</button></div>
</form>
</div>
<%
            } else {
                out.println("<p class='error'>Course not found.</p>");
            }
        } catch(Exception ex) {
            out.println("<p class='error'>Invalid course id.</p>");
        }
    }
%>

<div class="panel mb-4">
<h2 class="h5">Payments</h2>
<%
    ArrayList<Payment> payments = pdao.getPayment();
    if (payments != null && payments.size() > 0) {
%>
<table class="table table-striped table-hover">
    <thead class="table-light">
    <tr>
        <th>Payment ID</th>
        <th>Student ID</th>
        <th>Course ID</th>
        <th>Transaction ID</th>
        <th>Method</th>
        <th>Date</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% for (Payment pm : payments) { %>
    <tr>
        <td><%= pm.getPaymentId() %></td>
        <td><%= pm.getStudentId() %></td>
        <td><%= pm.getCourseId() %></td>
        <td><%= pm.getTransactionId() %></td>
        <td><%= pm.getMethod() %></td>
        <td><%= pm.getPayment_date() %></td>
        <td><%= pm.getStatus() %></td>
        <td>
            <form class="form-inline d-inline" method="post" action="admin.jsp">
                <input type="hidden" name="action" value="approvePayment" />
                <input type="hidden" name="id" value="<%= pm.getPaymentId() %>" />
                <input type="hidden" name="status" value="successful" />
                <button type="submit" class="btn btn-sm btn-success">Approve</button>
            </form>
            <form class="form-inline d-inline" method="post" action="admin.jsp">
                <input type="hidden" name="action" value="approvePayment" />
                <input type="hidden" name="id" value="<%= pm.getPaymentId() %>" />
                <input type="hidden" name="status" value="failed" />
                <button type="submit" class="btn btn-sm btn-danger">Decline</button>
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } else { %>
    <p>No payments found.</p>
<% } %>
</div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>