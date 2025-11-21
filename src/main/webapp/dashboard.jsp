<%@page import="in.ps.studentapp.dto.Courses"%>
<%@page import="in.ps.studentapp.dto.Payment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="in.ps.studentapp.dao.PaymentDAOImpl"%>
<%@page import="in.ps.studentapp.dao.PaymentsDAO"%>
<%@page import="in.ps.studentapp.dao.CoursesDAOImpl"%>
<%@page import="in.ps.studentapp.dao.CoursesDAO"%>
<%@page import="in.ps.studentapp.dto.Student"%>
<%@page import="in.ps.studentapp.dao.StudentDAOImpl"%>
<%@page import="in.ps.studentapp.dao.StudentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Dashboard</title>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Reset / base */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

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

body {
	background-color: #f5f7fa;
	color: #333;
	line-height: 1.6;
}

.container {
	display: flex;
	min-height: 100vh;
}

/* Sidebar Styles */
.sidebar {
	width: 280px;
	background: linear-gradient(135deg, var(--secondary), var(--dark));
	color: white;
	padding: 20px 0;
	box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
}

.profile-section {
	text-align: center;
	padding: 20px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	margin-bottom: 20px;
}

.profile-img {
	width: 80px;
	height: 80px;
	border-radius: 50%;
	background-color: var(--primary);
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 15px;
	font-size: 30px;
	color: white;
}

.profile-name {
	font-size: 18px;
	font-weight: 600;
	margin-bottom: 5px;
}

.profile-email {
	font-size: 14px;
	color: var(--light);
	opacity: 0.8;
}

.nav-links {
	list-style: none;
	padding: 0 15px;
}

.nav-links li {
	margin-bottom: 8px;
}

.nav-links a {
	display: flex;
	align-items: center;
	padding: 12px 15px;
	color: white;
	text-decoration: none;
	border-radius: 8px;
	transition: all 0.3s;
}

.nav-links a:hover, .nav-links a.active {
	background-color: rgba(255, 255, 255, 0.1);
	color: var(--primary);
}

.nav-links i {
	margin-right: 12px;
	font-size: 18px;
	width: 20px;
	text-align: center;
}

/* Main Content */
.main-content {
	flex: 1;
	padding: 30px;
	overflow-y: auto;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	padding-bottom: 15px;
	border-bottom: 1px solid #e0e0e0;
}

.page-title {
	font-size: 28px;
	color: var(--secondary);
	font-weight: 600;
}

.alert {
	padding: 12px 20px;
	border-radius: 8px;
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	font-weight: 500;
}

.alert-success {
	background-color: rgba(46, 204, 113, 0.15);
	color: var(--success);
	border-left: 4px solid var(--success);
}

.alert-error {
	background-color: rgba(231, 76, 60, 0.15);
	color: var(--danger);
	border-left: 4px solid var(--danger);
}

.alert i {
	margin-right: 12px;
	font-size: 20px;
}

.section {
	background: white;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
	padding: 25px;
	margin-bottom: 30px;
}

.section-title {
	font-size: 22px;
	color: var(--secondary);
	margin-bottom: 20px;
	padding-bottom: 12px;
	border-bottom: 2px solid #f0f0f0;
	display: flex;
	align-items: center;
}

.section-title i {
	margin-right: 12px;
	color: var(--primary);
}

/* Courses Grid */
.courses-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	gap: 25px;
}

.course-card {
	background: white;
	border-radius: 12px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s, box-shadow 0.3s;
	border: 1px solid #eaeaea;
}

.course-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.course-header {
	height: 120px;
	background: linear-gradient(135deg, var(--primary), var(--primary-dark));
	display: flex;
	align-items: center;
	justify-content: center;
	color: white;
	font-size: 20px;
	font-weight: 600;
	text-align: center;
	padding: 15px;
}

.course-body {
	padding: 20px;
}

.course-title {
	font-size: 18px;
	font-weight: 600;
	margin-bottom: 10px;
	color: var(--secondary);
}

.course-info {
	display: flex;
	justify-content: space-between;
	color: var(--gray);
	font-size: 14px;
	margin-bottom: 15px;
}

.course-details {
	color: #666;
	font-size: 14px;
	margin-bottom: 15px;
	line-height: 1.5;
}

.course-fee {
	font-size: 18px;
	font-weight: 700;
	color: var(--primary);
	text-align: right;
	margin-top: 10px;
}

.no-courses {
	text-align: center;
	padding: 50px 20px;
	color: var(--gray);
}

.no-courses i {
	font-size: 60px;
	margin-bottom: 20px;
	color: #ddd;
}

.no-courses h3 {
	font-size: 22px;
	margin-bottom: 10px;
	color: var(--secondary);
}

/* Payments Table */
.payments-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

.payments-table th {
	background-color: #f8f9fa;
	padding: 15px 20px;
	text-align: left;
	font-weight: 600;
	color: var(--secondary);
	border-bottom: 2px solid #e0e0e0;
}

.payments-table td {
	padding: 15px 20px;
	border-bottom: 1px solid #eee;
}

.payments-table tr:last-child td {
	border-bottom: none;
}

.payments-table tr:hover {
	background-color: #f8f9fa;
}

.status {
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
}

.status-completed {
	background-color: rgba(46, 204, 113, 0.15);
	color: var(--success);
}

.status-pending {
	background-color: rgba(243, 156, 18, 0.15);
	color: var(--warning);
}

.amount {
	font-weight: 600;
	color: var(--secondary);
}

.transaction-id {
	font-family: monospace;
	color: var(--dark);
}

@media ( max-width :992px) {
	.container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		height: auto;
	}
	.courses-grid {
		grid-template-columns: 1fr;
	}
}

.logout-btn {
	background: rgba(231, 76, 60, 0.1);
	color: var(--danger);
	border: 1px solid rgba(231, 76, 60, 0.3);
}

.logout-btn:hover {
	background: rgba(231, 76, 60, 0.2);
}
</style>
</head>
<body>
	<div class="container">
		<!-- Sidebar -->
		<div class="sidebar">
			<div class="profile-section">
				<div class="profile-img">
					<i class="fas fa-user-graduate"></i>
				</div>
				<%
				Student s = (Student) session.getAttribute("student");
				if (s != null) {
				%>
				<div class="profile-name"><%=s.getName()%></div>
				<div class="profile-email"><%=s.getMail()%></div>

			</div>

			<ul class="nav-links">
				<li><a href="#" class="active"><i class="fas fa-home"></i>
						Dashboard</a></li>
				<li><a href="profile.jsp"><i class="fas fa-user"></i> View
						Profile</a></li>
				<li><a href="update.jsp"><i class="fas fa-edit"></i> Update
						Account</a></li>
				<li><a href="courses.jsp"><i class="fas fa-book"></i>
						Browse Courses</a></li>
				<li><a href="logout" class="logout-btn"><i
						class="fas fa-sign-out-alt"></i> Logout</a></li>
			</ul>
		</div>

		<!-- Main Content -->
		<div class="main-content">
			<div class="header">
				<h1 class="page-title">Student Dashboard</h1>
				<div>
					<p>
						Welcome
						<%=s.getName()%></p>
				</div>
			</div>

			<!-- Success/Error Messages -->
			<%
			String success = (String) request.getAttribute("success");
			String error = (String) request.getAttribute("error");
			%>

			<%
			if (success != null) {
			%>
			<div class="alert alert-success">
				<i class="fas fa-check-circle"></i> <span><%=success%></span>
			</div>
			<%
			}
			%>

			<%
			if (error != null) {
			%>
			<div class="alert alert-error">
				<i class="fas fa-exclamation-circle"></i> <span><%=error%></span>
			</div>
			<%
			}
			%>


			<div class="section">
				<h2 class="section-title">
					<i class="fas fa-book-open"></i> My Enrolled Courses
				</h2>

				<%
				StudentDAO sdao = new StudentDAOImpl();
				CoursesDAO cdao = new CoursesDAOImpl();
				PaymentsDAO pdao = new PaymentDAOImpl();
				ArrayList<Courses> courses = new ArrayList<>();
				ArrayList<Payment> payments = pdao.getPaymentByStudentId(s.getId());
				if (payments != null && !payments.isEmpty()) {
					for (Payment p : payments) {
						Courses c = cdao.getCourses(p.getCourseId());
						if (c != null) {
					courses.add(c);
						}
					}
				%>

				<div class="courses-grid">
					<%
					for (Courses c : courses) {
					%>
					<div class="course-card">
						<div class="course-header">
							<%=c.getCourseName()%>
						</div>
						<div class="course-body">
							<h3 class="course-title"><%=c.getCourseName()%></h3>
							<div class="course-info">
								<span><i class="far fa-clock"></i> <%=c.getMonths()%>
									months</span>
							</div>
							<p class="course-details"><%=c.getCourseInfo() != null ? c.getCourseInfo() : "Comprehensive course covering all aspects."%></p>
							<div class="course-fee">
								₹
								<%=c.getFees()%></div>
						</div>
					</div>
					<%
					}
					%>
				</div>

				<%
				} else {
				%>

				<div class="no-courses">
					<i class="fas fa-book"></i>
					<h3>No Courses Enrolled</h3>
					<p>You haven't enrolled in any courses yet. Browse our catalog
						to get started with your learning journey.</p>

					<a href="courses.jsp"
						style="display: inline-block; margin-top: 15px; padding: 10px 20px; background: var(--primary); color: white; text-decoration: none; border-radius: 5px;">
						<i class="fas fa-search"></i> Browse Courses
					</a>
				</div>

				<%
				}
				%>
			</div>

			<!-- Recent Payments Section -->
			<div class="section">
				<h2 class="section-title">
					<i class="fas fa-credit-card"></i> Recent Payments
				</h2>

				<%
				if (payments != null && !payments.isEmpty()) {
				%>
				<table class="payments-table">
					<thead>
						<tr>
							<th>Payment ID</th>
							<th>Course</th>
							<th>Transaction ID</th>
							<th>Date</th>
							<th>Amount</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Payment p : payments) {
							Courses c = cdao.getCourses(p.getCourseId());
							String courseName = (c != null) ? c.getCourseName() : "Course #" + p.getCourseId();
						%>
						<tr>
							<td>#<%= p.getPaymentId() %></td>
							<td><%= courseName %></td>
							<td class="transaction-id"><%= p.getTransactionId() %></td>
							<td><%= p.getPayment_date() %></td>
							<td class="amount">₹<%= (c != null ? c.getFees() : 0) %></td>
							<td><span
								class='<%= "status " + ("Completed".equalsIgnoreCase(p.getStatus()) ? "status-completed" : "status-pending") %>'><%= p.getStatus() %></span></td>
						</tr>
						<% } %>

					</tbody>
				</table>
				<% } else { %>
				<div class="no-courses">
					<i class="fas fa-credit-card"></i>
					<h3>No Payment History</h3>
					<p>You haven't made any payments yet. Enroll in a course to see
						your payment history here.</p>
				</div>
				<% } %>
			</div>
		</div>
	</div>

	<script>
// Add active class to clicked nav item
document.querySelectorAll('.nav-links a').forEach(link => {
  link.addEventListener('click', function() {
    document.querySelectorAll('.nav-links a').forEach(item => item.classList.remove('active'));
    this.classList.add('active');
  });
});
</script>
	<% } else {
request.setAttribute("error","Session expired!");
RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
rd.forward(request, response);
} %>
</body>
</html>