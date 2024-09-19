<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@page import="Store.GioHang"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.DecimalFormat" %>
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
        <c:set var="back" value="back=checkout" />
        
        <%
            ArrayList<GioHang> gh=(ArrayList<GioHang>)session.getAttribute("cart");
            DecimalFormat df = new DecimalFormat("###,###,###");
            int sl=0;
            int tg=0;
            for(GioHang ghl:gh){
                sl+=ghl.getSl();
                tg+=((int)ghl.getGia()*ghl.getSl());
            }
            int s=gh.size();
            for(int i=0;i<gh.size();i++){
               for(int j=0;j<gh.size();j++){
                 if((gh.get(i).getIdsp()==gh.get(j).getIdsp())&&(gh.get(i).getKc()==gh.get(j).getKc())&&(i!=j)){
                     int sl1=gh.get(i).getSl()+gh.get(j).getSl();
                     gh.get(i).setSl(sl1);
                     gh.remove(j);
                 }
               }
            }
         %>
         <%@include file="header.jsp" %> 
        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container-fluid">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="product-list.jsp?trang=1">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Đặt hàng</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->
        <jsp:useBean id="conn" class="Store.ConnectInfo"></jsp:useBean>
        <s:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="${conn.getUrl()}" password="${conn.getPass()}" user="${conn.getUser()}"/>
        <s:query dataSource="${db}" var="tt">
            select * from khachhang where id_tk=?;
        <s:param value="${sessionScope.idtk}" />
        </s:query>
            
        <c:set var="ho" value="" />
        <c:set var="ten" value="" />
        <c:set var="sdt" value="" />
        <c:set var="mail" value="" />
        <c:set var="dc" value="" />
        <c:set var="idkh" value="" />
        <c:forEach items="${tt.rows}" var="ttl">
            <c:if test="${ttl.id_kh!=null}">
             <c:set var="ho" value="${ttl.ho}" />
            <c:set var="ten" value="${ttl.ten}" />
            <c:set var="sdt" value="${ttl.sdt}" />
            <c:set var="mail" value="${ttl.email}" />
            <c:set var="dc" value="${ttl.diachi}" />
            <c:set var="idkh" value="${ttl.id_kh}" />
            </c:if>
            
         </c:forEach>
        <c:if test="${idkh==''}">
                <s:query dataSource="${db}" var="tt1">
                 select * from taikhoan where id_tk=?;
                <s:param value="${sessionScope.idtk}" />
                </s:query>
                <c:forEach items="${tt1.rows}" var="ttl1">
             <c:set var="ho" value="${ttl1.ho}" />
            <c:set var="ten" value="${ttl1.ten}" />
            <c:set var="sdt" value="${ttl1.sdt}" />
            <c:set var="mail" value="${ttl1.email}" />
            <c:set var="dc" value="${ttl1.diachi}" />
                </c:forEach>
            </c:if>
        <!-- Checkout Start -->
        <div class="checkout">
            <div class="container-fluid"> 
                <form method="post" name="myform" onsubmit="return validate()" action="Xulydon" class="row">
                    <div class="col-lg-8">
                        <div class="checkout-inner">
                            <div class="billing-address">
                                <h2>Điền thông tin</h2>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>Họ</label>
                                        <input class="form-control" name="ho" value="${ho}" type="text" placeholder="Họ" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Tên</label>
                                        <input class="form-control" name="ten" value="${ten}" type="text" placeholder="Tên" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label>E-mail</label>
                                        <input class="form-control" name="mail" value="${mail}" type="email" placeholder="E-mail" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Số điện thoại</label>
                                        <input class="form-control" name="sdt" value="${sdt}" type="number" placeholder="Số điện thoại" required>
                                    </div>
                                    <div class="col-md-12">
                                        <label>Đia chỉ</label>
                                        <input class="form-control" name="dc" value="${dc}" type="text" placeholder="Địa chỉ" required>
                                    </div>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="checkout-inner">
                            <div class="checkout-summary">
                                <h1>Tổng cộng</h1>
                                <%
                                    out.print("<p>Số lượng<span>"+df.format(sl)+"</span></p>");
                                    out.print("<h2>Tổng tiền<span>"+df.format(tg)+"đ</span></h2>");
                                 %>
                            </div>

                            <div class="checkout-payment">
                                <div class="checkout-btn">
                                    <button type="submit">Đặt hàng</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- Checkout End -->
        
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
            
        </script>
    </body>
</html>
