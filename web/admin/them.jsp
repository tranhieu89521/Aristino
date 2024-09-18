<%-- 
    Document   : themsp
    Created on : Apr 27, 2022, 7:33:31 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/WEB-INF/tlds/themf" prefix="t" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <%@include file="include/head.jsp" %> 

</head>
<body>
    <c:set var="ten" value=""/>
    <c:if test="${param.tenbang=='danhmuc'}">
       <c:set var="ten" value="danh mục"/>
    </c:if>
    <c:if test="${param.tenbang=='sanpham'}">
       <c:set var="ten" value="sản phẩm"/>
    </c:if>
    <c:if test="${param.tenbang=='kichco'}">
       <c:set var="ten" value="kích cỡ"/>
    </c:if>
    <c:if test="${param.tenbang=='anhchitiet'}">
       <c:set var="ten" value="ảnh chi tiết"/>
    </c:if>
    <c:if test="${param.tenbang=='soluong'}">
       <c:set var="ten" value="số lượng"/>
    </c:if>
    <c:if test="${param.tenbang=='tinhtrangdh'}">
       <c:set var="ten" value="tình trạng đơn hàng"/>
    </c:if>
    <c:if test="${param.tenbang=='admin'}">
       <c:set var="ten" value="admin"/>
    </c:if>
       <%@include file="include/header.jsp" %> 
	<div class="row">
       <%@include file="include/list.jsp" %> 
	<div class="col-10">
        <div class="card card-register mx-auto mt-2">
        <div class="card-header">Thêm ${ten}</div>
        <div class="card-body">
        <form method="post" name="myform" onsubmit="return validate()" action="../them">
            <input type="hidden" name="tenbang" value="${param.tenbang}">
            <input type="hidden" name="trang" value="${param.trang}">
            <c:if test="${param.search!=null}">
                <input type="hidden" name="search" value="${param.search}">
             </c:if>
            <t:themf tenbang="${param.tenbang}"></t:themf>
            <button type="submit" name="submit" class="btn btn-info">Thêm</button>
        </form> 
    </div>
    </div>
        <c:if test="${param.tenbang=='sanpham'}">
        <script>
            function validate(){
                let sale=document.forms["myform"]["sale"].value;
                let gia=document.forms["myform"]["gia"].value;
                let gias=gia.toString();
                if(sale>100){
                    alert("Giá trị sale phải từ 0 đến 100");
                    return false;
                }
                if(gias.length>10){
                    alert("Giá của mặt hàng quá lớn");
                    return false;
                }
            }   
        </script>
       </c:if>
        </div>
       </div>
</body>
</html>