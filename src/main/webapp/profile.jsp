<%@page import="in.ps.studentapp.dto.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String success = (String) request.getAttribute("success");
String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Profile - Student Management System</title>
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--dark-blue: #0a1930;
	--navy-blue: #152642;
	--gold: #d4af37;
	--light-gold: #f1e5ac;
}

body {
	background: linear-gradient(135deg, var(--dark-blue) 0%,
		var(--navy-blue) 100%);
	min-height: 100vh;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	padding: 20px;
	margin: 0;
}

.profile-container {
	background: rgba(255, 255, 255, 0.05);
	backdrop-filter: blur(10px);
	border-radius: 20px;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
	overflow: hidden;
	width: 100%;
	max-width: 800px;
	margin: 20px auto;
	border: 1px solid rgba(255, 215, 0, 0.1);
}

.header-section {
	background: linear-gradient(135deg, var(--navy-blue) 0%,
		var(--dark-blue) 100%);
	padding: 25px 20px;
	text-align: center;
	color: var(--light-gold);
	border-bottom: 2px solid var(--gold);
}

.logo-img {
	width: 90px;
	height: 90px;
	margin: 0 auto 15px;
	background: linear-gradient(135deg, var(--navy-blue) 0%,
		var(--dark-blue) 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	border: 3px solid var(--gold);
	box-shadow: 0 0 20px rgba(212, 175, 55, 0.4);
}

.logo-img img {
	width: 90%;
	height: auto;
	filter: brightness(1.2);
}

.profile-section {
	padding: 30px;
}

.profile-card {
	background: rgba(255, 255, 255, 0.05);
	border-radius: 15px;
	padding: 25px;
	margin-bottom: 25px;
	border: 1px solid rgba(255, 255, 255, 0.1);
}

.profile-header {
	display: flex;
	align-items: center;
	margin-bottom: 25px;
	padding-bottom: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.profile-avatar {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	background: linear-gradient(135deg, var(--gold) 0%, #b8860b 100%);
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 20px;
	font-size: 40px;
	color: var(--dark-blue);
}

.profile-info h3 {
	color: var(--light-gold);
	margin-bottom: 5px;
}

.profile-info p {
	color: rgba(255, 255, 255, 0.7);
	margin-bottom: 0;
}

.detail-row {
	display: flex;
	margin-bottom: 15px;
	padding-bottom: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.detail-label {
	flex: 0 0 200px;
	color: var(--gold);
	font-weight: 600;
}

.detail-value {
	flex: 1;
	color: rgba(255, 255, 255, 0.9);
}

.btn-update {
	background: linear-gradient(135deg, var(--gold) 0%, #b8860b 100%);
	border: none;
	padding: 12px 30px;
	border-radius: 10px;
	color: var(--dark-blue);
	font-weight: 700;
	margin-right: 15px;
	transition: all 0.3s;
	letter-spacing: 0.5px;
}

.btn-update:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
	background: linear-gradient(135deg, #e6c052 0%, #c9981a 100%);
}

.btn-back {
	background: rgba(255, 255, 255, 0.1);
	border: 1px solid var(--gold);
	padding: 12px 30px;
	border-radius: 10px;
	color: var(--light-gold);
	font-weight: 600;
	transition: all 0.3s;
}

.btn-back:hover {
	background: rgba(255, 255, 255, 0.2);
	color: white;
}

.action-buttons {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

footer {
	text-align: center;
	color: rgba(255, 255, 255, 0.6);
	padding: 15px;
	width: 100%;
	margin-top: 20px;
	font-size: 0.9rem;
}

@media ( max-width :768px) {
	.profile-header {
		flex-direction: column;
		text-align: center;
	}
	.profile-avatar {
		margin-right: 0;
		margin-bottom: 15px;
	}
	.detail-row {
		flex-direction: column;
	}
	.detail-label {
		flex: none;
		margin-bottom: 5px;
	}
	.action-buttons {
		flex-direction: column;
		gap: 10px;
	}
	.btn-update, .btn-back {
		width: 100%;
		margin-right: 0;
	}
}
</style>
</head>
<body>
	<div class="profile-container">
		<div class="header-section">
			<div class="logo-img">
				<img src="${pageContext.request.contextPath}/images/logo.svg"
					alt="Student Management Logo">
			</div>
			<h2>Student Profile</h2>
			<p class="mb-0">View and manage your academic information</p>
		</div>

		<%
		if (success != null) {
		%>
		<div class="alert alert-success alert-dismissible fade show"
			role="alert">
			<strong><%=success%></strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		%>

		<%
		if (error != null) {
		%>
		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">
			<strong><%=error%></strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		%>

		<div class="profile-section">
			<%
			Student s = (Student) session.getAttribute("student");
			if (s != null) {
			%>

			<div class="profile-card">
				<div class="profile-header">
					<div class="profile-avatar">
						<i class="fas fa-user-graduate"></i>
					</div>
					<div class="profile-info">
						<h3><%=s.getName()%></h3>
						<p>
							Student ID:
							<%=s.getId()%></p>
					</div>
				</div>

				<div class="detail-row">
					<div class="detail-label">Email Address:</div>
					<div class="detail-value"><%=s.getMail()%></div>
				</div>

				<div class="detail-row">
					<div class="detail-label">Phone Number:</div>
					<div class="detail-value"><%=s.getPhone()%></div>
				</div>

				<div class="action-buttons">
					<a href="update.jsp" class="btn btn-update"> <i
						class="fas fa-edit me-2"></i>Update Profile
					</a> <a href="dashboard.jsp" class="btn btn-back"> <i
						class="fas fa-arrow-left me-2"></i>Back to Dashboard
					</a>
				</div>
			</div>

			<%
			} else {
			%>

			<div class="text-center py-5">
				<div class="profile-avatar mx-auto mb-3">
					<i class="fas fa-exclamation-triangle"></i>
				</div>
				<h4 class="text-warning">No Student Data Found</h4>
				<p class="text-light">Please log in to view your profile
					information.</p>
				<a href="login.jsp" class="btn btn-update mt-3"> <i
					class="fas fa-sign-in-alt me-2"></i>Go to Login
				</a>
			</div>

			<%
			}
			%>
		</div>
	</div>

	<footer>
		<p>© 2025 Student Management System. All rights reserved.</p>
	</footer>

	<!-- Bootstrap & Popper.js -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

	<script>
		function goBack() {
			window.location.href = 'dashboard.jsp';
		}
	</script>
</body>
</html>