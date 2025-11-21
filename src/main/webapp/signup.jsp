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
<title>Student Management System - Sign Up</title>
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

.page-container {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	width: 100%;
	justify-content: center;
	align-items: center;
}

.signup-container {
	background: rgba(255, 255, 255, 0.05);
	backdrop-filter: blur(10px);
	border-radius: 20px;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
	overflow: hidden;
	width: 100%;
	max-width: 450px;
	margin: 20px auto;
	border: 1px solid rgba(255, 215, 0, 0.1);
}

.logo-section {
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

.form-section {
	padding: 25px;
}

.form-control {
	padding: 14px 20px;
	border-radius: 10px;
	border: 2px solid rgba(255, 255, 255, 0.1);
	margin-bottom: 18px;
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

.btn-signup {
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

.btn-signup:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
	background: linear-gradient(135deg, #e6c052 0%, #c9981a 100%);
}

.links {
	display: flex;
	justify-content: center;
	margin-top: 20px;
	flex-wrap: wrap;
}

.links a {
	color: var(--gold);
	text-decoration: none;
	transition: color 0.3s;
	margin: 5px 0;
}

.links a:hover {
	color: var(--light-gold);
	text-decoration: underline;
}

.login-link {
	text-align: center;
	margin-top: 25px;
	color: rgba(255, 255, 255, 0.7);
}

.login-link a {
	color: var(--gold);
	font-weight: 600;
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
	margin-top: auto;
	font-size: 0.9rem;
}

.form-check-input:checked {
	background-color: var(--gold);
	border-color: var(--gold);
}

.form-check-label {
	color: rgba(255, 255, 255, 0.8);
}

.password-toggle {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--gold);
	cursor: pointer;
	z-index: 2;
}

.input-icon.password-field {
	position: relative;
}

.custom-alert {
	border-radius: 10px;
	margin: 15px;
	border: 1px solid;
	background: rgba(255, 255, 255, 0.1);
	backdrop-filter: blur(10px);
}

.alert-warning {
	background: rgba(255, 193, 7, 0.15);
	border-color: rgba(255, 193, 7, 0.3);
	color: #ffd700;
	text-align: center;
}

.alert-success {
	background: rgba(25, 135, 84, 0.15);
	border-color: rgba(25, 135, 84, 0.3);
	color: #90ee90;
	text-align: center;
}

.alert-danger {
	background: rgba(220, 53, 69, 0.15);
	border-color: rgba(220, 53, 69, 0.3);
	color: #ff6b6b;
}

.alert-dismissible .btn-close {
	filter: invert(1);
	opacity: 0.8;
	text-align: center;
}

.alert-dismissible .btn-close:hover {
	opacity: 1;
}

@media ( max-height : 800px) {
	.signup-container {
		margin: 10px auto;
	}
	.logo-section {
		padding: 20px 15px;
	}
	.form-section {
		padding: 20px;
	}
}

@media ( max-width : 576px) {
	.signup-container {
		border-radius: 15px;
	}
	.logo-img {
		width: 80px;
		height: 80px;
	}
	h2 {
		font-size: 1.5rem;
	}
}
</style>
</head>
<body>

	<div class="page-container">
		<div class="signup-container">

			<div class="logo-section">
				<div class="logo-img">
					<img src="${pageContext.request.contextPath}/images/logo.svg"
						alt="Student Management System Logo">
				</div>
				<h2>Pentagon Space Pvt. Ltd.</h2>
				<p class="mb-0">Create your account</p>
			</div>

			<!-- Alert Box - Conditionally Displayed -->
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

			<div class="form-section">
				<form id="signupForm" action="signup" method="POST">
					<div class="mb-3 input-icon">
						<i class="fas fa-user"></i> <input type="text"
							class="form-control" id="name" name="name"
							placeholder="Enter your full name" required>
					</div>

					<div class="mb-3 input-icon">
						<i class="fas fa-phone"></i> <input type="tel"
							class="form-control" id="phone" name="phone"
							placeholder="Enter your phone number" required>
					</div>

					<div class="mb-3 input-icon">
						<i class="fas fa-envelope"></i> <input type="email"
							class="form-control" id="email" name="mail"
							placeholder="Enter your email address" required>
					</div>

					<div class="mb-3 input-icon password-field">
						<i class="fas fa-lock"></i> <input type="password"
							class="form-control" id="password" name="password"
							placeholder="Set your password" required> <span
							class="password-toggle" onclick="togglePassword('password')">
							<i class="fas fa-eye"></i>
						</span>
					</div>

					<div class="mb-3 input-icon password-field">
						<i class="fas fa-lock"></i> <input type="password"
							class="form-control" id="confirm" name="confirm"
							placeholder="Confirm your password" required> <span
							class="password-toggle" onclick="togglePassword('confirm')">
							<i class="fas fa-eye"></i>
						</span>
					</div>

					<div class="form-check mb-4">
						<input class="form-check-input" type="checkbox" id="terms"
							name="terms" required> <label class="form-check-label"
							for="terms">I agree to the <a href="#" class="text-gold">Terms
								& Conditions</a></label>
					</div>

					<button type="submit" class="btn btn-signup">Create
						Account</button>

					<div class="login-link">
						<p>
							Already have an account? <a href="login.jsp"
								class="text-decoration-none fw-bold">Sign in here</a>
						</p>
					</div>
				</form>
			</div>
		</div>

		<footer>
			<p>© 2025 Kishore Academy Pvt. Ltd. All rights reserved.</p>
		</footer>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

	<script>
function togglePassword(inputId) {
  var passwordInput = document.getElementById(inputId);
  var eyeIcon = passwordInput.parentElement.querySelector('.password-toggle i');
  if (passwordInput.type === 'password') {
    passwordInput.type = 'text';
    eyeIcon.classList.remove('fa-eye');
    eyeIcon.classList.add('fa-eye-slash');
  } else {
    passwordInput.type = 'password';
    eyeIcon.classList.remove('fa-eye-slash');
    eyeIcon.classList.add('fa-eye');
  }
}
</script>
</body>
</html>