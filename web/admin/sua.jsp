<%-- 
    Document   : sua
    Created on : May 1, 2022, 3:42:05 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/WEB-INF/tlds/suaf" prefix="s" %>
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
    <c:if test="${param.tenbang=='khachhang'}">
       <c:set var="ten" value="khách hàng"/>
    </c:if>
    <c:if test="${param.tenbang=='taikhoan'}">
       <c:set var="ten" value="tài khoản"/>
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
        <div class="card-header">Sửa ${ten}</div>
        <div class="card-body">
        <form method="post" name="myform" onsubmit="return validate()" action="../sua">
            <input type="hidden" name="tenbang" value="${param.tenbang}">
            <input type="hidden" name="trang" value="${param.trang}">
            <c:set var="s" value=""/>
            <c:if test="${param.search!=null}">
                <c:set var="s" value="&search=${param.search}"/>
                <input type="hidden" name="search" value="${param.search}">
            </c:if>
            <input type="hidden" name="where" value=" where ${param.tenid}=${param.id}">
            <s:suaf tenbang="${param.tenbang}" id="${param.id}" tenid="${param.tenid}"></s:suaf>
            <button type="submit" name="submit" class="btn btn-info">Sửa</button>
            <a href="../xoa?tenbang=${param.tenbang}&tencot=${param.tenid}&id=${param.id}&trang=${param.trang}${s}" onclick="return confirm('Bạn có thực sự muốn xóa?')" class="btn btn-info">Xóa</a>
        </form> 
    </div>
    </div>

        
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
            <c:if test="${param.tenbang=='taikhoan'||param.tenbang=='khachhang'}">
            <script>
            function validate(){
                let x=document.forms["myform"]["sdt"].value;
                let sdt=x.toString();
                if(sdt.length!=11){
                    alert("Số điện thoại phải có 11 số");
                    return false;
                }
            }   
            </script>
            </c:if>
            
</body>
</html>
