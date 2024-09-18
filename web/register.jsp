<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Aristino</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="eCommerce HTML Template Free Download" name="keywords">
        <meta content="eCommerce HTML Template Free Download" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400|Source+Code+Pro:700,900&display=swap" rel="stylesheet">

        <!-- CSS Libraries -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="lib/slick/slick.css" rel="stylesheet">
        <link href="lib/slick/slick-theme.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <c:set var="type" value=""/>
        <c:set var="iddm" value=""/>
        <c:set var="search" value=""/>
        <c:set var="trang" value=""/>
        <c:set var="idsp" value=""/>
        <c:set var="kc1" value=""/>
        <c:set var="sl1" value=""/>
        <c:if test="${param.type!=null}">
           <c:set var="type" value="&type=${param.type}"/>
        </c:if>
        <c:if test="${param.iddm!=null}">
           <c:set var="iddm" value="&iddm=${param.iddm}"/>
        </c:if>
        <c:if test="${param.search!=null}">
           <c:set var="search" value="&search=${param.search}"/>
        </c:if>
        <c:if test="${param.trang!=null}">
           <c:set var="trang" value="&trang=${param.trang}"/>
        </c:if>
        <c:if test="${param.idsp!=null}">
           <c:set var="idsp" value="&idsp=${param.idsp}"/>
        </c:if>
        <c:if test="${param.kc1!=null}">
           <c:set var="kc1" value="&kc1=${param.kc1}"/>
        </c:if>
        <c:if test="${param.sl1!=null}">
           <c:set var="sl1" value="&sl1=${param.sl1}"/>
        </c:if>
        <c:set var="back" value="back=${param.back}${type}${iddm}${search}${trang}${idsp}${kc1}${sl1}" />
        <%@include file="header.jsp" %> 
        
        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container-fluid">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="product-list.jsp?trang=1">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Đăng ký</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->
        
        <!-- Login Start -->
        <div class="login">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">    
                        <div class="register-form">
                            <form method="post" name="myform" onsubmit="return validate()" action="Xulydk" class="row">
                                <input type="hidden" name="back" value="${param.back}">
                                <c:if test="${param.type!=null}">
                                    <input type="hidden" name="type" value="${param.type}">
                                </c:if>
                                <c:if test="${param.iddm!=null}">
                                    <input type="hidden" name="iddm" value="${param.iddm}">
                                </c:if>
                                <c:if test="${param.search!=null}">
                                    <input type="hidden" name="search" value="${param.search}">
                                </c:if>
                                <c:if test="${param.trang!=null}">
                                    <input type="hidden" name="trang" value="${param.trang}">
                                </c:if>
                                <c:if test="${param.idsp!=null}">
                                    <input type="hidden" name="idsp" value="${param.idsp}">
                                </c:if>
                                <c:if test="${param.kc1!=null}">
                                    <input type="hidden" name="kc1" value="${param.kc1}">
                                </c:if>
                                <c:if test="${param.sl1!=null}">
                                    <input type="hidden" name="sl1" value="${param.sl1}">
                                </c:if>
                                <div class="col-md-12">
                                   <label>Tên tài khoản</label>
                                   <input class="form-control" name="user" value="${param.user}" type="text" placeholder="Tên tài khoản" required>
                                 </div>
                                <div class="col-md-6">
                                    <label>Họ</label>
                                    <input class="form-control" name="ho" value="${param.ho}" type="text" placeholder="Họ" required>
                                </div>
                                <div class="col-md-6">
                                    <label>Tên</label>
                                    <input class="form-control" name="ten" type="text" value="${param.ten}" placeholder="Tên" required>
                                </div>
                                <div class="col-md-6">
                                    <label>E-mail</label>
                                    <input class="form-control" name="mail" type="email" value="${param.mail}" placeholder="E-mail" required>
                                </div>
                                <div class="col-md-6">
                                    <label>Số điện thoại</label>
                                    <input class="form-control" name="sdt" type="number" value="" placeholder="Số điện thoại" required>
                                </div>
                                <div class="col-md-6">
                                    <label>Mật khẩu</label>
                                    <input class="form-control" name="pass" type="password" value="${param.pass}" placeholder="Mật khẩu" required>
                                </div>
                                <div class="col-md-6">
                                    <label>Nhập lại mật khẩu</label>
                                    <input class="form-control" name="repass" type="password" value="${param.repass}" placeholder="Nhập lại mật khẩu" required>
                                </div>
                                <div class="col-md-12">
                                     <label>Đia chỉ</label>
                                     <input class="form-control" name="dc" type="text" value="${param.dc}" placeholder="Địa chỉ" required>
                                 </div>
                                <div class="col-md-12">
                                    <button type="submit" class="btn">Đăng ký</button>
                                </div>
                            </form>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
        <!-- Login End -->
        
        <%@include file="footer.jsp" %>
        
        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/slick/slick.min.js"></script>
        
        <!-- Template Javascript -->
        <script src="js/main.js"></script>
        <script>
            function validate(){
                let x=document.forms["myform"]["sdt"].value;
                let pass=document.forms["myform"]["pass"].value;
                let repass=document.forms["myform"]["repass"].value;
                let sdt=x.toString();
                if(sdt.length!=11){
                    alert("Số điện thoại phải có 11 số");
                    return false;
                }
                if(pass!=repass){
                    alert("Nhập lại mật khẩu phải giống với mật khẩu");
                    return false;
                }
            }   
        </script>
    </body>
</html>
