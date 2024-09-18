<%-- 
    Document   : session
    Created on : Apr 17, 2022, 4:42:24 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Store.GioHang"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<GioHang> gh=new ArrayList<GioHang>();
    session.setAttribute("cart", gh);
    session.setAttribute("idtk", null);
    session.setAttribute("user", null);
%>
<jsp:forward page="index.jsp"/>