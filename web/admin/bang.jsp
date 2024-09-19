<%-- 
    Document   : sanpham
    Created on : Apr 27, 2022, 9:23:54 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/WEB-INF/tlds/bang" prefix="b" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <%@include file="include/head.jsp" %> 

</head>
<body>
    <c:set var="ten" value=""/>
    <c:set var="flex" value=""/>
    <c:if test="${param.tenbang=='danhmuc'}">
       <c:set var="ten" value="danh mục"/>
       <c:set var="flex" value="class=\"flex\""/>
    </c:if>
    <c:if test="${param.tenbang=='sanpham'}">
       <c:set var="ten" value="sản phẩm"/>
       <c:set var="flex" value="class=\"flex\""/>
    </c:if>
    <c:if test="${param.tenbang=='kichco'}">
       <c:set var="ten" value="kích cỡ"/>
       <c:set var="flex" value="class=\"flex\""/>
    </c:if>
    <c:if test="${param.tenbang=='anhchitiet'}">
       <c:set var="ten" value="ảnh chi tiết"/>
       <c:set var="flex" value="class=\"flex\""/>
    </c:if>
    <c:if test="${param.tenbang=='soluong'}">
       <c:set var="ten" value="số lượng"/>
       <c:set var="flex" value="class=\"flex\""/>
    </c:if>
    <c:if test="${param.tenbang=='khachhang'}">
       <c:set var="ten" value="khách hàng"/>
    </c:if>
    <c:if test="${param.tenbang=='donhang'}">
       <c:set var="ten" value="đơn hàng"/>
    </c:if>
    <c:if test="${param.tenbang=='chitietdh'}">
       <c:set var="ten" value="chi tiết đơn hàng"/>
    </c:if>
    <c:if test="${param.tenbang=='binhluan'}">
       <c:set var="ten" value="bình luận"/>
    </c:if>
    <c:if test="${param.tenbang=='taikhoan'}">
       <c:set var="ten" value="tài khoản"/>
    </c:if>
    <c:if test="${param.tenbang=='tinhtrangdh'}">
       <c:set var="ten" value="tình trạng đơn hàng"/>
       <c:set var="flex" value="class=\"flex\""/>
    </c:if>
    <c:if test="${param.tenbang=='admin'}">
       <c:set var="ten" value="admin"/>
       <c:set var="flex" value="class=\"flex\""/>
    </c:if>
       <%@include file="include/header.jsp" %> 
	<div class="row">
       <%@include file="include/list.jsp" %> 
	<div class="col-10">
        <h2><b>${ten}</b></h2>
        <div ${flex}>
            <c:if test="${(param.tenbang!='donhang')&&(param.tenbang!='chitietdh')&&(param.tenbang!='binhluan')&&(param.tenbang!='khachhang')&&(param.tenbang!='taikhoan')}">
                <c:set var="s" value=""/>
                <c:if test="${param.search!=null}">
                     <c:set var="s" value="&search=${param.search}"/>
                </c:if>
                <a class="btn btn-primary" href="them.jsp?tenbang=${param.tenbang}&trang=${param.trang}${s}">Thêm ${ten}</a>
            </c:if>   
        <form method="get" action="bang.jsp">
            <input name="search" type="search">
            <input type="hidden" name="tenbang" value="${param.tenbang}">
            <input type="hidden" name="trang" value="1">
            <input type="submit" class="btn btn-primary" value="search">
        </form>
        </div>
        <c:if test="${param.search!=null}">
            <b:bang search="${param.search}" tenbang="${param.tenbang}" trang="${param.trang}"></b:bang>
        </c:if>
        <c:if test="${param.search==null}">
            <b:bang tenbang="${param.tenbang}" trang="${param.trang}"></b:bang>
        </c:if>
        </div>
       </div>
</body>
</html>