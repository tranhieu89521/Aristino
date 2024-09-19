<%-- 
    Document   : logout
    Created on : Apr 23, 2022, 9:41:20 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.setAttribute("idtk", null);
    session.setAttribute("user", null);
%>
<jsp:forward page="index.jsp"/>