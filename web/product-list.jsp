<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/tlds/list" prefix="l" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
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
        <jsp:useBean id="conn" class="Store.ConnectInfo"></jsp:useBean>
        <s:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="${conn.getUrl()}" password="${conn.getPass()}" user="${conn.getUser()}"/>
                            <c:set var="trang" value="${param.trang}"/>
                            <c:if test="${param.trang==0}"><c:set var="trang" value="${1}"/></c:if>
                            <c:set var="type" value=""/>
                            <c:set var="req1" value=""/>
                            <c:set var="rtype" value=""/>
                            <c:if test="${param.type!=null}">
                                <c:set var="aorw" value="and"/>
                                <c:if test="${(param.search==null)&&(param.iddm==null)}"><c:set var="aorw" value="where"/></c:if>
                                <c:if test="${param.type=='sale'}">
                                    <c:set var="type" value=" ${aorw} not sale=0 order by sale desc"/>
                                    <c:set var="rtype" value="${aorw} not sale=0"/>
                                </c:if>
                                <c:if test="${param.type=='new'}">
                                    <c:set var="type" value="order by ngaynhap desc"/>
                                </c:if>
                                <c:if test="${param.type=='banchay'}">
                                    <c:set var="type" value="order by daban desc"/>
                                </c:if>
                                <c:if test="${param.type=='asc'}">
                                    <c:set var="type" value="order by giasale asc"/>
                                </c:if>
                                <c:if test="${param.type=='desc'}">
                                    <c:set var="type" value="order by giasale desc"/>
                                </c:if>
                                <c:if test="${param.type=='range1'}">
                                    <c:set var="type" value="${aorw} (giasale between 0 and 500000) order by giasale asc"/>
                                    <c:set var="rtype" value="${aorw} (giasale between 0 and 500000)"/>
                                </c:if>
                                <c:if test="${param.type=='range2'}">
                                    <c:set var="type" value="${aorw} (giasale between 500000 and 1000000) order by giasale asc"/>
                                    <c:set var="rtype" value="${aorw} (giasale between 500000 and 1000000)"/>
                                </c:if>
                                <c:if test="${param.type=='range3'}">
                                    <c:set var="type" value="${aorw} (giasale between 1000000 and 1500000) order by giasale asc"/>
                                    <c:set var="rtype" value="${aorw} (giasale between 1000000 and 1500000)"/>
                                </c:if>
                                <c:if test="${param.type=='range4'}">
                                    <c:set var="type" value="${aorw} (giasale between 1500000 and 2000000) order by giasale asc"/>
                                    <c:set var="rtype" value="${aorw} (giasale between 1500000 and 2000000)"/>
                                </c:if>
                                <c:set var="req1" value="type=${param.type}&"/>
                            </c:if>
                            <c:set var="sql" value="select * from sanpham ${type} limit 9 offset ${(trang-1)*9}"/>
                            <c:set var="sql1" value="select count(id_sp) as max from sanpham ${type}"/>
                            <c:set var="sql2" value="select * from sanpham ${rtype} order by RAND() limit 3"/>
                            <c:set var="req" value="" />
                            <c:if test="${param.search!=null}">
                                <c:set var="sql" value="select distinct * from sanpham where ((tensp like '%${param.search}%')  or (giasale like '%${param.search}%')  or (sale like '%${param.search}%') or (mausac like '%${param.search}%')) ${type} limit 9 offset  ${(trang-1)*9}"/>
                                <c:set var="sql2" value="select distinct * from sanpham where ((tensp like '%${param.search}%')  or (giasale like '%${param.search}%')  or (sale like '%${param.search}%') or (mausac like '%${param.search}%')) ${rtype} order by RAND() limit 3" />
                                <c:set var="sql1" value="select count(id_sp) as max from sanpham where ((tensp like '%${param.search}%')  or (giasale like '%${param.search}%')  or (sale like '%${param.search}%') or (mausac like '%${param.search}%')) ${type}"/>
                                <c:set var="req" value="search=${param.search}&"/>
                            </c:if>
                            <c:if test="${param.iddm!=null}">
                                <c:set var="sql" value="select * from sanpham where id_dm=${param.iddm} ${type} limit 9 offset  ${(trang-1)*9}"/>
                                <c:set var="sql1" value="select count(id_sp) as max from sanpham where id_dm=${param.iddm} ${type}"/>
                                <c:set var="sql2" value="select * from sanpham where id_dm=${param.iddm} ${rtype} order by RAND() limit 3"/>
                                <c:set var="req" value="iddm=${param.iddm}&"/>
                            </c:if>
       <c:set var="back" value="${req}${req1}trang=${trang}&back=list" />
       <%@include file="header.jsp" %>
        
        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container-fluid">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Sản phẩm</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->
        
        <!-- Product List Start -->
        <div class="product-view">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="product-view-top">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <form class="product-search" method="get" action="product-list.jsp">
                                                <input type="text" name="search" placeholder="Search">
                                                <input type="hidden" name="trang" value="1">
                                                <button type="submit"><i class="fa fa-search"></i></button>
                                            </form>
                                        </div>
                        
                                        <div class="col-md-4">
                                            <div class="product-short">
                                                <div class="dropdown">
                                                    <div class="dropdown-toggle" data-toggle="dropdown">Sắp xếp sản phẩm theo</div>
                                                    <div class="dropdown-menu dropdown-menu-right">
                                                        <a href="product-list.jsp?${req}type=new&trang=1" class="dropdown-item">Hàng mới về</a>
                                                        <a href="product-list.jsp?${req}type=sale&trang=1" class="dropdown-item">Giảm giá</a>
                                                        <a href="product-list.jsp?${req}type=banchay&trang=1" class="dropdown-item">Bán chạy</a>
                                                        <a href="product-list.jsp?${req}type=asc&trang=1" class="dropdown-item">Giá từ thấp lên cao</a>
                                                        <a href="product-list.jsp?${req}type=desc&trang=1" class="dropdown-item">Giá từ cao xuống thấp</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="product-price-range">
                                                <div class="dropdown">
                                                    <div class="dropdown-toggle" data-toggle="dropdown">Chọn theo khoảng giá</div>
                                                    <div class="dropdown-menu dropdown-menu-right">
                                                        <a href="product-list.jsp?${req}type=range1&trang=1" class="dropdown-item">Từ 0đ đến 500,000đ</a>
                                                        <a href="product-list.jsp?${req}type=range2&trang=1" class="dropdown-item">Từ 500,000đ đến 1,000,000đ</a>
                                                        <a href="product-list.jsp?${req}type=range3&trang=1" class="dropdown-item">Từ 1,000,000đ đến 1,500,000đ</a>
                                                        <a href="product-list.jsp?${req}type=range4&trang=1" class="dropdown-item">Từ 1,500,000đ đến 2,000,000đ</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <s:query dataSource="${db}" var="rs">
                                ${sql}
                            </s:query>
                            <c:forEach var="list" items="${rs.rows}">
                                <c:set var="ten" value="${list.tensp}"/>
                                <c:if test="${fn:length(ten)<=32}">
                                    <c:set var="ten" value="${list.tensp}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>
                                </c:if>
                                <c:set var="gia" value="${list.gia-(list.gia*list.sale/100)}" />
                                <c:choose>
                                    <c:when test="${list.id_dm==1}">
                                        <c:set var="kc" value="${8}"/>
                                    </c:when>
                                    <c:when test="${(list.id_dm==2)||(list.id_dm==3)}">
                                        <c:set var="kc" value="${14}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="kc" value="${1}"/>
                                    </c:otherwise>
                                </c:choose>
                                <div class="col-md-4">
                                <div class="product-item">
                                    <div class="product-title">
                                        <a href="product-detail.jsp?idsp=${list.id_sp}">${ten}</a>
                                    </div>
                                    <div class="product-image">
                                        <a href="product-detail.jsp?idsp=${list.id_sp}">
                                            <img src="${list.anhmh}" alt="Product Image" width="90" height="310">
                                        </a>
                                        <div class="product-action">
                                            <a href="Cart?sl=1&kc=${kc}&id_sp=${list.id_sp}&gia=${gia}&${req}${req1}trang=${trang}&back=list"><i class="fa fa-cart-plus"></i></a>
                                            <a href="product-detail.jsp?idsp=${list.id_sp}"><i class="fa fa-search"></i></a>
                                        </div>
                                    </div>
                                    <div class="product-price"> 
                                        <h3><fmt:formatNumber type="number" pattern="###,###,###" value="${gia}"/><span>đ</span></h3>
                                        <a class="btn" href="Cart?sl=1&kc=${kc}&id_sp=${list.id_sp}&gia=${gia}&back=checkout"><i class="fa fa-shopping-cart"></i>Mua</a>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                           <s:query dataSource="${db}" var="rs1">
                                ${sql1}
                            </s:query>
                           <c:set var="sotrang" value="${0}"/>
                            <c:forEach items="${rs1.rows}" var="list1">
                                <c:choose>
                                    <c:when test="${list1.max%9==0}">
                                        <c:set var="sotrang" value="${list1.max/9}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="sotrang" value="${((list1.max-(list1.max%9))/9)+1}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                        <!-- Pagination Start -->
                        <div class="col-md-12">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${sotrang>0}">
                                        <li class="page-item">
                                            <a class="page-link" href="product-list.jsp?${req}${req1}trang=${trang-1}">Previous</a>
                                        </li>
                                    </c:if>
                                    <c:forEach var="i" begin="1" end="${sotrang}">
                                        <c:if test="${i==trang}">
                                            <li class="page-item active"><a class="page-link" href="product-list.jsp?${req}${req1}trang=${i}">${i}</a></li>
                                        </c:if>
                                        <c:if test="${i!=trang}">
                                            <li class="page-item"><a class="page-link" href="product-list.jsp?${req}${req1}trang=${i}">${i}</a></li>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${sotrang>0}">
                                    <li class="page-item">
                                        <a class="page-link" href="product-list.jsp?${req}${req1}trang=${trang+1}">Next</a>
                                    </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div> 
                        
                        <!-- Pagination Start -->
                    </div>           
                    
                    <!-- Side Bar Start -->
                    <div class="col-lg-4 sidebar">
                        <div class="sidebar-widget category">
                            <h2 class="title">Category</h2>
                            <nav class="navbar bg-light">
                                <ul class="navbar-nav">
                                    <l:List/>
                                </ul>
                            </nav>
                        </div>
                        
                        <div class="sidebar-widget widget-slider">
                            <div class="sidebar-slider normal-slider">
                                <s:query dataSource="${db}" var="ran">
                                    ${sql2}
                                </s:query>
                                <c:forEach items="${ran.rows}" var="rand">
                                <c:choose>
                                    <c:when test="${rand.id_dm==1}">
                                        <c:set var="kc" value="${8}"/>
                                    </c:when>
                                    <c:when test="${(rand.id_dm==2)||(rand.id_dm==3)}">
                                        <c:set var="kc" value="${14}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="kc" value="${1}"/>
                                    </c:otherwise>
                                </c:choose>
                                <c:set var="ten" value="${rand.tensp}"/>
                                <c:if test="${fn:length(ten)<=32}">
                                    <c:set var="ten" value="${rand.tensp}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>
                                </c:if>
                                <c:set var="gia" value="${rand.gia-(rand.gia*rand.sale/100)}" />
                                    <div class="product-item">
                                    <div class="product-title">
                                         <a href="product-detail.jsp?idsp=${rand.id_sp}">${ten}</a>
                                    </div>
                                    <div class="product-image">
                                        <a href="product-detail.jsp?idsp=${rand.id_sp}">
                                            <img src="${rand.anhmh}" alt="Product Image" width="90" height="310">
                                        </a>
                                        <div class="product-action">
                                            <a href="Cart?sl=1&kc=${kc}&id_sp=${rand.id_sp}&gia=${gia}&${req}${req1}trang=${trang}&back=list"><i class="fa fa-cart-plus"></i></a>
                                            <a href="product-detail.jsp?idsp=${rand.id_sp}"><i class="fa fa-search"></i></a>
                                        </div>
                                    </div>
                                    <div class="product-price">
                                        <h3><fmt:formatNumber type="number" pattern="###,###,###" value="${gia}"/><span>đ</span></h3>
                                        <a class="btn" href="Cart?sl=1&kc=${kc}&id_sp=${rand.id_sp}&gia=${gia}&back=checkout"><i class="fa fa-shopping-cart"></i>Mua</a>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- Side Bar End -->
                </div>
            </div>
        </div>
        <!-- Product List End -->  
        
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
