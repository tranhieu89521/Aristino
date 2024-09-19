<%-- 
    Document   : header
    Created on : Apr 17, 2022, 9:55:05 AM
    Author     : user
--%>

<%@page import="Store.GioHang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!-- Top bar Start -->
        <div class="top-bar">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6">
                        <i class="fa fa-envelope"></i>
                        support@email.com
                    </div>
                    <div class="col-sm-6">
                        <i class="fa fa-phone-alt"></i>
                        +012-345-6789
                    </div>
                </div>
            </div>
        </div>
        <!-- Top bar End -->
        
        <!-- Nav Bar Start -->
        <div class="nav">
            <div class="container-fluid">
                <nav class="navbar navbar-expand-md bg-dark navbar-dark">
                    <a href="#" class="navbar-brand">MENU</a>
                    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <div class="navbar-nav mr-auto">
                            <a href="index.jsp" class="nav-item nav-link">Trang chủ</a>
                            <a href="product-list.jsp?trang=1" class="nav-item nav-link">Sản phẩm</a>
                            <a href="cart.jsp" class="nav-item nav-link">Giỏ hàng</a>
                            <c:choose>
                                    <c:when test="${sessionScope.idtk==null}">
                                       <a href="login.jsp?${back}" class="nav-item nav-link">Đăng nhập</a>
                                       <a href="register.jsp?${back}" class="nav-item nav-link">Đăng ký</a>
                                    </c:when>
                                    <c:otherwise>
                                       <a href="my-account.jsp" class="nav-item nav-link">Tài khoản của tôi</a>
                                    </c:otherwise>
                            </c:choose> 
                            <a href="contact.jsp" class="nav-item nav-link">Liên hệ</a>
                            
                        </div>
                        <div class="navbar-nav ml-auto">
                           <c:if test="${sessionScope.idtk!=null}">
                               ${sessionScope.user}
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Nav Bar End -->      
        
        <!-- Bottom Bar Start -->
        <div class="bottom-bar">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <div class="logo">
                            <a href="index.jsp">
                                <img src="img/logo.png" alt="Logo">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <form class="search" method="get" action="product-list.jsp">
                            <input type="text" name="search" placeholder="Search">
                            <input type="hidden" name="trang" value="1">
                            <button type="submit"><i class="fa fa-search"></i></button>
                        </form>
                    </div>
                    <div class="col-md-3">
                        <div class="user">
                            <a href="cart.jsp" class="btn cart">
                                <i class="fa fa-shopping-cart"></i>
                                <%
                                    ArrayList<GioHang> ghs=(ArrayList<GioHang>)session.getAttribute("cart");
                                    if(ghs==null){
                                    out.print("<span>(0)</span>");
                                    }
                                    else{
                                    out.print("<span>("+ghs.size()+")</span>");
                                    }
                                %>  
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bottom Bar End -->   

