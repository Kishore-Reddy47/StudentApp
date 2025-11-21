<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String success = (String) request.getAttribute("success"); String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<!-- fixed viewport spacing -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Management System</title>
<!-- Bootstrap 5 CSS (fixed URL spacing) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome (fixed URL spacing) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--dark-blue: #0a1930;
	--navy-blue: #152642;
	--gold: #d4af37;
	--light-gold: #f1e5ac;
}

body {
	background: linear-gradient(135deg, var(--dark-blue) 0%, var(--navy-blue) 100%);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	/* fixed font-family typo (sans-serif) */
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

.login-container {
	background: rgba(255, 255, 255, 0.04);
	backdrop-filter: blur(8px);
	border-radius: 18px;
	box-shadow: 0 18px 40px rgba(2,6,23,0.6);
	overflow: hidden;
	width: 100%;
	max-width: 480px;
	margin: 20px auto;
	border: 1px solid rgba(255, 215, 0, 0.08);
}

.logo-section {
	background: linear-gradient(135deg, rgba(21,38,66,0.95) 0%, rgba(10,25,48,0.95) 100%);
	padding: 28px 20px;
	text-align: center;
	color: var(--light-gold);
	border-bottom: 2px solid rgba(212,175,55,0.06);
}

.logo-img {
	width: 100px;
	height: 100px;
	margin: 0 auto 12px;
	background: radial-gradient(circle at 30% 30%, rgba(212,175,55,0.18), transparent 35%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	border: 3px solid rgba(212, 175, 55, 0.12);
}

.logo-img img {
	width: 78%;
	height: auto;
	filter: brightness(1.1) saturate(1.05);
}

.form-section {
	padding: 28px;
}

.form-control {
	padding: 12px 14px;
	border-radius: 10px;
	border: 1px solid rgba(255,255,255,0.08);
	margin-bottom: 14px;
	transition: all 0.25s;
	background: rgba(10,25,48,0.7);
	color: white;
}

.form-control::placeholder {
	color: rgba(255,255,255,0.6);
}

.form-control:focus {
	border-color: var(--gold);
	box-shadow: 0 0 0 0.15rem rgba(212,175,55,0.14);
	background: rgba(10,25,48,0.95);
	color: white;
}

/* fixed .btn-login block (removed garbage and completed hover gradient) */
.btn-login {
	background: linear-gradient(135deg, var(--gold) 0%, #c9981a 100%);
	border: none;
	padding: 12px 16px;
	border-radius: 10px;
	color: var(--dark-blue);
	font-weight: 700;
	width: 100%;
	margin-top: 6px;
	transition: all 0.2s;
}

.btn-login:hover { transform: translateY(-2px); box-shadow: 0 8px 22px rgba(201,152,26,0.18);} 

.links { display: flex; justify-content: space-between; margin-top: 12px; flex-wrap: wrap; }
.links a { color: var(--gold); text-decoration: none; margin: 6px 0; }
.links a:hover { color: var(--light-gold); text-decoration: underline; }

.signup-link { text-align: center; margin-top: 20px; color: rgba(255,255,255,0.72); }

.input-icon { position: relative; }
.input-icon i { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--gold); z-index: 2; }
.input-icon input { padding-left: 44px; }

.password-toggle { position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer; color: rgba(255,255,255,0.6); }

footer { text-align: center; color: rgba(255,255,255,0.55); padding: 14px; width: 100%; margin-top: auto; font-size: 0.9rem; }

.custom-alert { border-radius: 10px; margin: 12px 20px; border: 1px solid; background: rgba(255,255,255,0.04); backdrop-filter: blur(6px); }
.alert-success { background: rgba(25,135,84,0.08); border-color: rgba(25,135,84,0.12); color: #dff0d8; }
.alert-danger { background: rgba(220,53,69,0.06); border-color: rgba(220,53,69,0.12); color: #ffd1d1; }

@media (max-width: 576px) { .login-container { max-width: 94%; border-radius: 14px; } .logo-img { width: 86px; height: 86px; } }
</style>
</head>
<body>
	<div class="page-container">
		<div class="login-container">
			<div class="logo-section">
				<div class="logo-img">
					<!-- Replace this image with your actual logo (SVG recommended) -->
					<img src="${pageContext.request.contextPath}/images/logo.svg" alt="Kishore Academy Logo" onerror="this.src='${pageContext.request.contextPath}/images/logo.png'">
				</div>
<h2 class="mb-1"> Kishore Academy</h2>
<p class="mb-0 text-muted">Student Login</p>
</div>

<% if(success!= null) { %>
<div id="serverSuccess" class="alert alert-success alert-dismissible fade show custom-alert" role="alert">
 
<strong><%=success %></strong>
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>

<% if(error!= null) { %>
<div id="serverError" class="alert alert-danger alert-dismissible fade show custom-alert" role="alert">
<strong><%=error %></strong>
<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>

<div class="form-section">
<form id="loginForm" action="login" method="post" novalidate>
<div class="mb-3 input-icon">
<i class="fas fa-envelope"></i>
<input type="email" class="form-control" id="email" name="mail" placeholder="Enter your email address" required aria-required="true" aria-label="Email address" autofocus pattern="^[^@\s]+@[^@\s]+\.[^@\s]+$">
<div class="invalid-feedback">Please enter a valid email address.</div>
</div>

<div class="mb-3 position-relative input-icon">
<i class="fas fa-lock"></i>
<input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required aria-required="true" aria-label="Password" minlength="4">
<span id="togglePwd" class="password-toggle" aria-hidden="true" title="Show / hide password"><i class="fa-regular fa-eye"></i></span>
<div class="invalid-feedback">Password is required (min 4 characters).</div>
</div>

<div class="d-flex justify-content-between align-items-center mb-3">
<div class="form-check">
<input class="form-check-input" type="checkbox" id="remember" name="remember">
<label class="form-check-label text-white-50" for="remember">Remember me</label>
</div>
<a href="forgot.jsp" class="text-decoration-none text-warning small">Forgot password?</a>
</div>

<button type="submit" class="btn btn-login">Login to Dashboard</button>

<div class="links">
<a href="signup.jsp" class="text-decoration-none">Create an account</a>
<a href="admin.jsp" class="text-decoration-none">Admin</a>
</div>
</form>

<div class="signup-link">
<p class="mb-0">Don't have an account? <a href="signup.jsp" class="text-decoration-none fw-bold">Sign up here</a></p>
</div>
</div>
</div>

<footer>
<p>© <script>document.write(new Date().getFullYear())</script> Pentagon Space Pvt. Ltd. All rights reserved.</p>
</footer>
</div>

<!-- Bootstrap & Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script>
// Client-side validation and UX helpers
(function(){
    'use strict';
    const form = document.getElementById('loginForm');
    form.addEventListener('submit', function(event){
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
            form.classList.add('was-validated');
            // focus first invalid
            const firstInvalid = form.querySelector(':invalid');
            if(firstInvalid) firstInvalid.focus();
        }
    }, false);

    // password toggle
    const pwd = document.getElementById('password');
    const toggle = document.getElementById('togglePwd');
    toggle.addEventListener('click', function(){
        if(pwd.type === 'password'){
            pwd.type = 'text';
            this.innerHTML = '<i class="fa-regular fa-eye-slash"></i>';
        } else {
            pwd.type = 'password';
            this.innerHTML = '<i class="fa-regular fa-eye"></i>';
        }
        pwd.focus();
    });

    // Auto dismiss server alerts after a few seconds
    const s = document.getElementById('serverSuccess');
    const e = document.getElementById('serverError');
    setTimeout(()=>{ if(s) { try { var bs = new bootstrap.Alert(s); bs.close(); } catch(_){} } }, 5000);
    setTimeout(()=>{ if(e) { try { var be = new bootstrap.Alert(e); be.close(); } catch(_){} } }, 7000);
})();
</script>
</body>
</html>