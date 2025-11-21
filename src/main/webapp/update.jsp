<%@page import="in.ps.studentapp.dto.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Profile - Student Management System</title>
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
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	padding: 20px;
	margin: 0;
}

.update-container {
	background: rgba(255, 255, 255, 0.05);
	backdrop-filter: blur(10px);
	border-radius: 20px;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
	overflow: hidden;
	width: 100%;
	max-width: 500px;
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
	width: 80px;
	height: 80px;
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

.form-section {
	padding: 30px;
}

.form-control {
	padding: 14px 20px;
	border-radius: 10px;
	border: 2px solid rgba(255, 255, 255, 0.1);
	margin-bottom: 20px;
	transition: all 0.3s;
	background: rgba(10, 25, 48, 0.7);
	color: white;
}

.form-control::placeholder {
	color: rgba(255, 255, 255, 0.6);
}

.form-control:focus {
	border-color: var(--gold);
	box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
	background: rgba(10, 25, 48, 0.9);
	color: white;
}

.btn-update {
	background: linear-gradient(135deg, var(--gold) 0%, #b8860b 100%);
	border: none;
	padding: 14px;
	border-radius: 10px;
	color: var(--dark-blue);
	font-weight: 700;
	width: 100%;
	margin-top: 10px;
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
	padding: 14px;
	border-radius: 10px;
	color: var(--light-gold);
	font-weight: 600;
	width: 100%;
	margin-top: 15px;
	transition: all 0.3s;
}

.btn-back:hover {
	background: rgba(255, 255, 255, 0.2);
	color: white;
}

.input-icon {
	position: relative;
}

.input-icon i {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--gold);
	z-index: 2;
}

.input-icon input {
	padding-left: 45px;
}

footer {
	text-align: center;
	color: rgba(255, 255, 255, 0.6);
	padding: 15px;
	width: 100%;
	margin-top: 20px;
	font-size: 0.9rem;
}

.student-id {
	text-align: center;
	color: var(--light-gold);
	margin-bottom: 20px;
	font-size: 1.1rem;
	font-weight: 600;
}

@media ( max-height : 800px) {
	.update-container {
		margin: 10px auto;
	}
	.header-section {
		padding: 20px 15px;
	}
	.form-section {
		padding: 20px;
	}
}

@media ( max-width : 576px) {
	.update-container {
		border-radius: 15px;
	}
	.logo-img {
		width: 70px;
		height: 70px;
	}
	h2 {
		font-size: 1.5rem;
	}
}
</style>
</head>
<body>
	<%
	Student s = (Student) session.getAttribute("student");
	if (s != null) {
	%>

	<div class="update-container">
		<div class="header-section">
			<div class="logo-img">
				<!-- Replace this image with your actual logo -->
				<img src="${pageContext.request.contextPath}/images/logo.svg"
					alt="Student Management Logo">
			</div>
			<h2>Update Profile</h2>
			<p class="mb-0">Modify your personal information</p>
		</div>

		<div class="form-section">
			<div class="student-id">
				Student ID:
				<%=s.getId() > 0 ? s.getId() : "N/A"%></div>

			<form action="update" method="post" id="updateForm">
				<div class="mb-3 input-icon">
					<i class="fas fa-user"></i> <input type="text" class="form-control"
						id="name" name="name" placeholder="Enter your full name"
						value="<%=s.getName()%>" required />
				</div>

				<div class="mb-3 input-icon">
					<i class="fas fa-phone"></i> <input type="tel" class="form-control"
						id="phone" name="phone" placeholder="Enter your phone number"
						value="<%=s.getPhone()%>" required />
				</div>

				<div class="mb-3 input-icon">
					<i class="fas fa-envelope"></i> <input type="email"
						class="form-control" id="email" name="mail"
						placeholder="Enter your email address" value="<%=s.getMail()%>"
						required />
				</div>

				<button type="submit" class="btn btn-update">
					<i class="fas fa-save me-2"></i>Update Profile
				</button>
				<a href="dashboard.jsp"
					class="btn btn-back d-block text-center mt-2"> <i
					class="fas fa-arrow-left me-2"></i>Back
				</a>
			</form>
		</div>
	</div>

	<footer>
		<p>© 2025 Student Management System. All rights reserved.</p>
	</footer>

	<%
	} else {
	request.setAttribute("error", "Session expired! Please login again.");
	RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
	rd.forward(request, response);
	}
	%>

	<!-- Bootstrap & Popper.js -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>