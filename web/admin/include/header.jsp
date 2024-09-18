<%-- 
    Document   : header
    Created on : Apr 26, 2022, 10:34:24 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
		<div class="logo">
			<h3>Aristino</h3>
		</div>
		<div class="user">
                    <a href="#"><i class="fas fa-user-circle">${sessionScope.user}</i> </a>
	            <a href="../logout"><i class="fas fa-sign-out-alt"></i> </a>
		</div>
	</header>
