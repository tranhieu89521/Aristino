<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <%@include file="header.jsp" %>
        
        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container-fluid">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="product-list.jsp?trang=1">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Tài khoản của tôi</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->
        
        <!-- My Account Start -->
        <div class="my-account">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <div class="nav flex-column nav-pills" role="tablist" aria-orientation="vertical">
                            <a class="nav-link active" id="orders-nav" data-toggle="pill" href="#orders-tab" role="tab"><i class="fa fa-shopping-bag"></i>Đơn hàng</a>
                            <a class="nav-link" id="address-nav" data-toggle="pill" href="#address-tab" role="tab"><i class="fa fa-map-marker-alt"></i>Địa chỉ giao hàng</a>
                            <a class="nav-link" id="account-nav" data-toggle="pill" href="#account-tab" role="tab"><i class="fa fa-user"></i>Thông tin tài khoản</a>
                            <a class="nav-link" href="logout.jsp"><i class="fa fa-sign-out-alt"></i>Đăng xuất</a>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane fade show active" id="orders-tab" role="tabpanel" aria-labelledby="orders-nav">
                            <jsp:useBean id="conn" class="Store.ConnectInfo"></jsp:useBean>
                            <s:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="${conn.getUrl()}" password="${conn.getPass()}" user="${conn.getUser()}"/>
                            <s:query dataSource="${db}" var="dh">
                                select ctdh.id_dh as id_dh,ctdh.id_sp as id_sp,ctdh.id_kc as id_kc,sp.tensp as tensp,kc.kichco as kichco,ctdh.soluong as soluong,ctdh.tonggia as tonggia,dh.ngaydat as ngaydat,trdh.tentr as tentr from sanpham sp,kichco kc,chitietdh ctdh,donhang dh,tinhtrangdh trdh,khachhang kh where sp.id_sp=ctdh.id_sp and kc.id_kc=ctdh.id_kc and ctdh.id_dh=dh.id_dh and trdh.id_tr=dh.id_tr and kh.id_kh=dh.id_kh and kh.id_tk=?;
                                <s:param value="${sessionScope.idtk}"/>
                            </s:query>
                                <s:query dataSource="${db}" var="dc">
                                    select diachi from khachhang where id_tk=?
                                    <s:param value="${sessionScope.idtk}" />
                                </s:query>
                                    <c:set var="dcgh" value="" />
                                    <c:forEach items="${dc.rows}" var="dcl">
                                        <c:set var="dcgh" value="${dcl.diachi}" />
                                    </c:forEach>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>Stt</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Kích cỡ</th>
                                                <th>Số lượng</th>
                                                <th>Tổng giá</th>
                                                <th>Ngày đặt</th>
                                                <th>Trạng thái</th>
                                                <th>Hủy mua</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="i" value="${0}"/>
                                            <c:forEach items="${dh.rows}" var="dhl">
                                                <c:set var="i" value="${i+1}"/>
                                            <tr>
                                                <td>${i}</td>
                                                <td>${dhl.tensp}</td>
                                                <td>${dhl.kichco}</td>
                                                <td>${dhl.soluong}</td>
                                                <td><fmt:formatNumber type="number" pattern="###,###,###" value="${dhl.tonggia}"/>đ</td>
                                                <td>${dhl.ngaydat}</td>
                                                <td>${dhl.tentr}</td>
                                                <td><a href="Xulyxoa?iddh=${dhl.id_dh}&idsp=${dhl.id_sp}&idkc=${dhl.id_kc}&sl=${dhl.soluong}"><i class="fa fa-trash"></i></a></td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="address-tab" role="tabpanel" aria-labelledby="address-nav">
                                <h4>Địa chỉ giao hàng</h4>
                                <div class="row">
                                    <form method="post" action="Xulydc" class="col-md-12">
                                        <textarea rows="5" cols="110" name="dc" placeholder="Địa chỉ giao hàng" required>${dcgh}</textarea><br>
                                        <button class="btn">Thay đổi</button>
                                    </form>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="account-tab" role="tabpanel" aria-labelledby="account-nav">
                                <s:query dataSource="${db}" var="tt">
                                    select * from khachhang where id_tk=?;
                                    <s:param value="${sessionScope.idtk}" />
                                </s:query>
                                    <c:set var="ho" value="" />
                                    <c:set var="ten" value="" />
                                    <c:set var="sdt" value="" />
                                    <c:set var="mail" value="" />
                                    <c:set var="dc" value="" />
                                    <c:forEach items="${tt.rows}" var="ttl">
                                        <c:set var="ho" value="${ttl.ho}" />
                                        <c:set var="ten" value="${ttl.ten}" />
                                        <c:set var="sdt" value="${ttl.sdt}" />
                                        <c:set var="mail" value="${ttl.email}" />
                                        <c:set var="dc" value="${ttl.diachi}" />
                                    </c:forEach>
                                <h4>Thông tin tài khoản</h4>
                                <form method="post" name="myform" onsubmit="return validate()" action="Xulytt" class="row">
                                    <div class="col-md-6">
                                        <input class="form-control" name="ho" value="${ho}" type="text" placeholder="Họ" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input class="form-control" name="ten" value="${ten}"  type="text" placeholder="Tên" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input class="form-control" name="sdt" value="${sdt}" type="number" placeholder="Số điện thoại" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input class="form-control" name="mail" value="${mail}" type="email" placeholder="Email" required>
                                    </div>
                                    <div class="col-md-12">
                                        <input class="form-control" name="dc" value="${dc}" type="text" placeholder="Địa chỉ" required>
                                    </div>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn">Cập nhật thông tin</button>
                                        <br><br>
                                    </div>
                                </form>
                                <h4>Password change</h4>
                                <form method="post" name="myform1" onsubmit="return validate1()" action="Xulymk" class="row">
                                    <div class="col-md-12">
                                        <input class="form-control" name="cpass" type="password" placeholder="Mật khẩu hiện tại" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input class="form-control" name="pass" type="password" placeholder="Mật khẩu mới" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input class="form-control" name="repass" type="password" placeholder="Nhập lại mật khẩu mới" required>
                                    </div>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn">Save Changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- My Account End -->
        
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
                let sdt=x.toString();
                if(sdt.length!=11){
                    alert("Số điện thoại phải có 11 số");
                    return false;
                }   
            }
            function validate1(){
                let pass=document.forms["myform1"]["pass"].value;
                let repass=document.forms["myform1"]["repass"].value;
                 if(pass!=repass){
                    alert("Nhập lại mật khẩu phải giống với mật khẩu");
                    return false;
                }
            }
        </script>
    </body>
</html>
