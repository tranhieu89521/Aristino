<%-- 
    Document   : login
    Created on : May 6, 2022, 7:50:09 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<script src="https://kit.fontawesome.com/2669f91611.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,400;1,700&display=swap" rel="stylesheet">
	<style type="text/css">
		*{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: 'Poppins', sans-serif;
		}
		body{
			background: #343a40;
		}
		form{
			width: 30%;
			background: white;
			margin: 50px auto;
			padding: 20px;
			border-radius: 10px;
		}
		form h3{
			font-weight: bold;
			margin-bottom: 30px;
		}
		form .form-group input{
			padding: 25px 12px;
		}
		form button{
			margin-top: 20px;
			width: 100%;
		}
	</style>
</head>
<body>
         <c:set var="user" value=""/>
         <c:set var="pass" value=""/>
         <c:if test="${(param.user!=null)&&(param.pass!=null)}">
             <c:set var="user" value="${param.user}"/>
             <c:set var="pass" value="${param.pass}"/>
         </c:if>
	<form action="../login" method="post">
		<h3>Login</h3>
  		<div class="form-group">
                 <input type="text" name="user" value="${user}" class="form-control" placeholder="Username" required>
  		</div>
  		<div class="form-group">
    		<input type="password" name="pass" value="${pass}" class="form-control" placeholder="Password" required>
  		</div>
  		<button type="submit" class="btn btn-primary">Login</button>
  		<button type="reset" class="btn btn-dark">Cancel</button>
	</form>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
