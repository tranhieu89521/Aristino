<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/tlds/featured" prefix="f" %>
<%@taglib uri="/WEB-INF/tlds/topsale" prefix="t" %>
<%@taglib uri="/WEB-INF/tlds/list" prefix="l" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ page import="Store.ConnectInfo" %>  
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
            
        <c:set var="back" value="back=index" />
        <%@include file="header.jsp" %>    
        <jsp:useBean id="conn" class="Store.ConnectInfo"></jsp:useBean>
        <s:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="${conn.getUrl()}" password="${conn.getPass()}" user="${conn.getUser()}"/>
        <!-- Main Slider Start -->
        <div class="header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <nav class="navbar bg-light">
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.jsp"><i class="fa fa-home"></i>Trang chủ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="product-list.jsp?type=new&trang=1"><i class="fa fa-shopping-bag"></i>Hàng mới về</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="product-list.jsp?type=sale&trang=1"><i class="fa fa-plus-square"></i>Giảm giá</a>
                                </li>
                                <l:List/>
                            </ul>
                        </nav>
                    </div>
                    <s:query dataSource="${db}" var="bn">
                      select * from banner limit 3;
                    </s:query>
                    <div class="col-md-6">
                        <div class="header-slider normal-slider">
                            <c:forEach items="${bn.rows}" var="bnl">
                            <div class="header-slider-item">
                                <img src="${bnl.banner}" alt="Slider Image" height="400" width="700" />  
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                    <s:query dataSource="${db}" var="bn1">
                      select * from banner limit 2 offset 3;
                    </s:query>
                    <div class="col-md-3">
                        <div class="header-img">
                            <c:forEach items="${bn1.rows}" var="bnl1">
                            <div class="img-item">
                                <a href=""><img src="${bnl1.banner}" height="300" width="400" /></a>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main Slider End -->      
        
        <!-- Brand Start -->
        <div class="brand">
            <div class="container-fluid">
                <div class="brand-slider">
                    <div class="brand-item"><img src="img/brand-1.png" alt=""></div>
                    <div class="brand-item"><img src="img/brand-2.png" alt=""></div>
                    <div class="brand-item"><img src="img/brand-3.png" alt=""></div>
                    <div class="brand-item"><img src="img/brand-4.png" alt=""></div>
                    <div class="brand-item"><img src="img/brand-5.png" alt=""></div>
                    <div class="brand-item"><img src="img/brand-6.png" alt=""></div>
                </div>
            </div>
        </div>
        <!-- Brand End -->      
        
        <!-- Feature Start-->
        <div class="feature">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fab fa-cc-mastercard"></i>
                            <h2>Giao dịch an toàn</h2>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fa fa-truck"></i>
                            <h2>Giao hàng mọi nơi</h2>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fa fa-sync-alt"></i>
                            <h2>90 ngày đổi trả</h2>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fa fa-comments"></i>
                            <h2>Hỗ trợ 24/7</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Feature End-->      
        
        <!-- Category Start-->
        <div class="category">
            <div class="container-fluid">
                <s:query dataSource="${db}" var="bn2">
                      select * from banner limit 6 offset 5;
                </s:query>
                <div class="row">
                    <c:set var="class1" value=""/>
                    <c:forEach items="${bn2.rows}" var="bnl2">
                        <c:if test="${bnl2.id_bn==6||bnl2.id_bn==11}">
                            <c:set var="class1" value="category-item ch-400"/>
                        </c:if>
                        <c:if test="${bnl2.id_bn==7||bnl2.id_bn==10}">
                            <c:set var="class1" value="category-item ch-250"/>
                        </c:if>
                        <c:if test="${bnl2.id_bn==8||bnl2.id_bn==9}">
                            <c:set var="class1" value="category-item ch-150"/>
                        </c:if>
                        <c:if test="${bnl2.id_bn==6||bnl2.id_bn==7||bnl2.id_bn==9||bnl2.id_bn==11}">
                            <c:if test="${bnl2.id_bn!=6}">
                                </div>
                            </c:if>
                            <div class="col-md-3">
                        </c:if>
                        <div class="${class1}">
                            <a href=""><img src="${bnl2.banner}" /></a>
                        </div>
                            <c:if test="${bnl2.id_bn==11}">
                                </div>
                            </c:if>
                    </c:forEach>
                    
                </div>
            </div>
        </div>
        
        <!-- Category End-->         
        
        <!-- Featured Product Start -->
        <div class="featured-product product">
            <div class="container-fluid">
                <div class="section-header">
                    <h1>Giảm giá mạnh</h1>
                </div>
                <div class="row align-items-center product-slider product-slider-4">
                    <f:Featured></f:Featured>
                </div>
            </div>
        </div>
        <!-- Featured Product End -->              
        <!-- Call to Action Start -->
        <div class="call-to-action">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h1>Gọi cho chúng tôi ngay để được tư vấn</h1>
                    </div>
                    <div class="col-md-6">
                        <a href="tel:0123456789">+012-345-6789</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Call to Action End -->    
        <!-- Recent Product Start -->
        <div class="recent-product product">
            <div class="container-fluid">
                <div class="section-header">
                    <h1>Hàng bán chạy</h1>
                </div>
                <div class="row align-items-center product-slider product-slider-4">
                <t:TopSale></t:TopSale>
                </div>
            </div>
        </div>
        <!-- Recent Product End -->        
        
        <%@include file="footer.jsp" %>
        
        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/slick/slick.min.js"></script>
        
        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
