<%@page import="in.ps.studentapp.dto.Courses"%>
<%@page import="java.util.ArrayList"%>
<%@page import="in.ps.studentapp.dao.CoursesDAOImpl"%>
<%@page import="in.ps.studentapp.dao.CoursesDAO"%>
<%@page import="in.ps.studentapp.dto.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Available Courses</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary: #3498db;
	--primary-dark: #2980b9;
	--secondary: #2c3e50;
	--light: #ecf0f1;
	--success: #2ecc71;
	--warning: #f39c12;
	--danger: #e74c3c;
	--gray: #95a5a6;
	--dark: #34495e;
}

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: #333;
	min-height: 100vh;
	padding: 20px;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
}

.header {
	text-align: center;
	margin-bottom: 30px;
	color: white;
}

.header h1 {
	font-size: 2.5rem;
	margin-bottom: 10px;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.header p {
	font-size: 1.1rem;
	opacity: 0.9;
}

.back-btn {
	display: inline-flex;
	align-items: center;
	padding: 10px 20px;
	background: rgba(255, 255, 255, 0.2);
	color: white;
	text-decoration: none;
	border-radius: 25px;
	margin-bottom: 20px;
	transition: all 0.3s;
}

.back-btn:hover {
	background: rgba(255, 255, 255, 0.3);
	transform: translateY(-2px);
}

.back-btn i {
	margin-right: 8px;
}

.alert {
	padding: 15px 20px;
	border-radius: 10px;
	margin-bottom: 25px;
	text-align: center;
	font-weight: 500;
}

.alert-success {
	background-color: rgba(46, 204, 113, 0.9);
	color: white;
}

.alert-error {
	background-color: rgba(231, 76, 60, 0.9);
	color: white;
}

.courses-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 25px;
	margin-top: 30px;
}

.course-card {
	background: white;
	border-radius: 15px;
	overflow: hidden;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
	transition: all 0.3s ease;
	position: relative;
}

.course-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.18);
}

.course-header {
	height: 140px;
	background: linear-gradient(135deg, var(--primary), var(--primary-dark));
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 22px;
	font-weight: 700;
	text-align: center;
	padding: 20px;
	position: relative;
	overflow: hidden;
}

.course-body {
	padding: 20px;
}

.course-title {
	font-size: 20px;
	font-weight: 700;
	color: var(--secondary);
	margin-bottom: 12px;
}

.course-description {
	color: #666;
	line-height: 1.6;
	margin-bottom: 16px;
	font-size: 15px;
}

.course-details {
	display: flex;
	justify-content: space-between;
	margin-bottom: 16px;
	padding: 12px;
	background: #f8f9fa;
	border-radius: 10px;
}

.course-detail {
	text-align: center;
	flex: 1;
}

.detail-label {
	font-size: 12px;
	color: var(--gray);
	text-transform: uppercase;
	font-weight: 600;
	margin-bottom: 6px;
}

.detail-value {
	font-size: 16px;
	font-weight: 700;
	color: var(--secondary);
}

.course-price {
	text-align: center;
	margin-bottom: 12px;
}

.price {
	font-size: 28px;
	font-weight: 800;
	color: var(--primary);
}

.price-period {
	font-size: 14px;
	color: var(--gray);
}

.purchase-form {
	text-align: center;
}

.purchase-btn {
	background: linear-gradient(135deg, var(--success), #27ae60);
	color: white;
	border: none;
	padding: 12px 20px;
	font-size: 15px;
	font-weight: 600;
	border-radius: 50px;
	cursor: pointer;
	transition: all 0.3s;
	width: 100%;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	box-shadow: 0 5px 15px rgba(46, 204, 113, 0.25);
}

.purchase-btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 20px rgba(46, 204, 113, 0.35);
}

.no-courses {
	text-align: center;
	padding: 60px 20px;
	color: white;
}

.no-courses i {
	font-size: 80px;
	margin-bottom: 20px;
	opacity: 0.8;
}

.no-courses h3 {
	font-size: 28px;
	margin-bottom: 15px;
}

.student-info {
	background: rgba(255, 255, 255, 0.1);
	padding: 12px 18px;
	border-radius: 10px;
	margin-bottom: 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	color: white;
	backdrop-filter: blur(10px);
}

.student-welcome {
	font-size: 18px;
	font-weight: 600;
}

.student-email {
	opacity: 0.9;
}

@media ( max-width : 768px) {
	.courses-grid {
		grid-template-columns: 1fr;
	}
	.student-info {
		flex-direction: column;
		text-align: center;
		gap: 10px;
	}
	.header h1 {
		font-size: 2rem;
	}
}
</style>
</head>
<body>
	<div class="container">
		<!-- Student Info Bar -->
		<% Student s = (Student)session.getAttribute("student"); %>
		<% if(s != null) { %>
		<div class="student-info">
			<div>
				<div class="student-welcome">
					Welcome,
					<%= s.getName() %>!
				</div>
				<div class="student-email"><%= s.getMail() %></div>
			</div>
			<a href="dashboard.jsp" class="back-btn"><i
				class="fas fa-arrow-left"></i> Back to Dashboard</a>
		</div>
		<% } %>

		<!-- Header -->
		<div class="header">
			<h1>Available Courses</h1>
			<p>Enhance your skills with our comprehensive course catalog</p>
		</div>

		<!-- Success/Error Messages -->
		<%
        String success = (String)request.getAttribute("success");
        String error = (String)request.getAttribute("error");
    %>
		<% if(success != null) { %>
		<div class="alert alert-success">
			<i class="fas fa-check-circle"></i>
			<%= success %></div>
		<% } %>
		<% if(error != null) { %>
		<div class="alert alert-error">
			<i class="fas fa-exclamation-circle"></i>
			<%= error %></div>
		<% } %>

		<!-- Courses Grid -->
		<%
        if(s != null) {
            CoursesDAO cdao = new CoursesDAOImpl();
            ArrayList<Courses> courses = cdao.getCourses();
            if(courses != null && !courses.isEmpty()) {
    %>
		<div class="courses-grid">
			<% for(Courses c : courses) { %>
			<div class="course-card">
				<div class="course-header"><%= c.getCourseName() %></div>
				<div class="course-body">
					<h3 class="course-title"><%= c.getCourseName() %></h3>
					<p class="course-description"><%= c.getCourseInfo() != null ? c.getCourseInfo() : "A comprehensive course designed to enhance your skills and knowledge in this field." %></p>
					<div class="course-details">
						<div class="course-detail">
							<div class="detail-label">Duration</div>
							<div class="detail-value"><%= c.getMonths() %>
								months
							</div>
						</div>
						<div class="course-detail">
							<div class="detail-label">Seats</div>
							<div class="detail-value">N/A</div>
						</div>
					</div>
					<div class="course-price">
						<div class="price">
							₹<%= c.getFees()%></div>
						<div class="price-period">one-time</div>
						<form class="purchase-form" action="<%= request.getContextPath() %>/transaction.jsp" method="post" onsubmit="this.querySelector('button[type=submit]').disabled=true;">
							<input type="hidden" name="courseId"
								value="<%= c.getCourseId() %>">
							<button type="submit" class="purchase-btn">
								<i class="fas fa-shopping-cart"></i> Enroll Now
							</button>
						</form>
					</div>
				</div>
			</div>
			<% } %>
		</div>
		<%      } else { %>
		<div class="no-courses">
			<i class="fas fa-book"></i>
			<h3>No Courses Available</h3>
			<p>We're currently updating our course catalog. Please check back
				later.</p>
		</div>
		<%      }
        } else {
            request.setAttribute("error", "Session expired! Please login again.");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    %>
	</div>

	<script>
    // Add animation delay to course cards
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.course-card');
        cards.forEach((card, index) => { card.style.animationDelay = (index * 0.1) + 's'; });
    });
</script>
</body>
</html>