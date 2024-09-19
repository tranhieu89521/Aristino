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
        <c:set var="sl" value="${1}" />
        <c:if test="${param.sl1!=null}">
           <c:choose>
            <c:when test="${param.sl1==0}">
                <c:set var="sl" value="${1}" />
           </c:when>
           <c:otherwise>
                <c:set var="sl" value="${param.sl1}"/>
            </c:otherwise>
          </c:choose>
        </c:if>
        <c:set var="kc" value=""/>
        
        <c:set var="isk" value="idsp=${param.idsp}&kc1=${kc}&sl1=${sl}&" />
        <c:set var="back" value="${isk}back=detail" />
        <%@include file="header.jsp" %>
        
        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container-fluid">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="product-list.jsp?trang=1">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Chi tiết sản phẩm</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->
        <jsp:useBean id="conn" class="Store.ConnectInfo"></jsp:useBean>
        <s:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="${conn.getUrl()}" password="${conn.getPass()}" user="${conn.getUser()}"/>
        <s:query dataSource="${db}" var="rs">
            select * from sanpham where id_sp=${param.idsp};
        </s:query>
        <s:query dataSource="${db}" var="anhct">
            select * from anhchitiet where id_sp=${param.idsp};
        </s:query>
         <s:query dataSource="${db}" var="bl">
            select * from binhluan where id_sp=?;
            <s:param value="${param.idsp}" />
         </s:query>   
         <c:if test="${param.kc1!=null}">
            <s:query dataSource="${db}" var="slcl">
             select soluong from soluong where id_sp=? and id_kc=?;
            <s:param value="${param.idsp}" />
            <s:param value="${param.kc1}" />
            </s:query>
            <c:forEach var="slclr" items="${slcl.rows}">
                <c:if test="${slclr.soluong<sl}">
                    <c:set var="sl" value="${slclr.soluong}"/>
                </c:if>
            </c:forEach>
             <c:set var="kc" value="${param.kc1}"/>
         </c:if>
        <!-- Product Detail Start -->
        <div class="product-detail">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8">
                        <c:set var="isk" value="idsp=${param.idsp}" />
                        <c:forEach items="${rs.rows}" var="list">
                            <c:set var="sql" value="select * from sanpham where id_dm=${list.id_dm} order by RAND() limit 5" />
                        <div class="product-detail-top">
                            <div class="row align-items-center">
                                <div class="col-md-5">
                                    <c:forEach items="${anhct.rows}" var="anhctl">
                                    <div class="product-slider-single normal-slider">
                                        <img src="${list.anhmh}" alt="Product Image">
                                        <c:if test="${anhctl.anhct1!=null}">
                                        <img src="${anhctl.anhct1}" alt="Product Image">
                                        </c:if>
                                        <c:if test="${anhctl.anhct2!=null}">
                                        <img src="${anhctl.anhct2}" alt="Product Image">
                                        </c:if>
                                        <c:if test="${anhctl.anhct3!=null}">
                                        <img src="${anhctl.anhct3}" alt="Product Image">
                                        </c:if>
                                        <c:if test="${anhctl.anhct4!=null}">
                                        <img src="${anhctl.anhct4}" alt="Product Image">
                                        </c:if>
                                        <c:if test="${anhctl.anhct5!=null}">
                                        <img src="${anhctl.anhct5}" alt="Product Image">
                                        </c:if>
                                    </div>
                                        <div style="border: 0px;"  class="product-slider-single-nav normal-slider">
                                        <div class="slider-nav-img"><img src="${list.anhmh}" alt="Product Image"></div>
                                        <c:if test="${anhctl.anhct1!=null}">
                                        <div class="slider-nav-img"><img src="${anhctl.anhct1}" alt="Product Image"></div>
                                        </c:if>
                                        <c:if test="${anhctl.anhct2!=null}">
                                        <div class="slider-nav-img"><img src="${anhctl.anhct2}" alt="Product Image"></div>
                                        </c:if>
                                        <c:if test="${anhctl.anhct3!=null}">
                                        <div class="slider-nav-img"><img src="${anhctl.anhct3}" alt="Product Image"></div>
                                        </c:if>
                                        <c:if test="${anhctl.anhct4!=null}">
                                        <div class="slider-nav-img"><img src="${anhctl.anhct4}" alt="Product Image"></div>
                                        </c:if>
                                        <c:if test="${anhctl.anhct5!=null}">
                                        <div class="slider-nav-img"><img src="${anhctl.anhct5}" alt="Product Image"></div>
                                        </c:if>
                                    </div>
                                    </c:forEach>
                                </div>
                                <div class="col-md-7">
                                    <div class="product-content">
                                        <div class="title"><h2>${list.tensp}</h2></div>
                                        <c:set var="gia" value="${list.gia-(list.gia*list.sale/100)}" />
                                        <div class="price">
                                            <h4>Giá:</h4>
                                            <p><fmt:formatNumber type="number" pattern="###,###,###" value="${gia}"/>đ
                                                <c:if test="${gia!=list.gia}">
                                                <span><fmt:formatNumber type="number" pattern="###,###,###" value="${list.gia}"/>đ</span>
                                                </c:if>
                                            </p>
                                        </div>
                                        <div class="quantity">
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
                                           <c:if test="${(param.kc1!=null)&&(param.kc1!='')}"><c:set var="kc" value="${param.kc1}"/></c:if>
                                            <h4>Số lượng:</h4>
                                            <a href="product-detail.jsp?sl1=${sl-1}&idsp=${param.idsp}&kc1=${kc}"><i class="fa fa-minus"></i></a>
                                            <input type="text" value="${sl}" disabled>
                                            <a href="product-detail.jsp?sl1=${sl+1}&idsp=${param.idsp}&kc1=${kc}"><i class="fa fa-plus"></i></a>
                                        </div>
                                        <div class="p-size">
                                            <c:set var="between" value="between 1 and 7"/>
                                            <c:if test="${(list.id_dm==2)||(list.id_dm==3)}"><c:set var="between" value="between 14 and 18"/></c:if>
                                            <c:if test="${list.id_dm==1}"><c:set var="between" value="between 8 and 13"/></c:if>
                                            <s:query dataSource="${db}" var="size">
                                                select * from kichco where id_kc ${between};
                                            </s:query>
                                            <h4>Kích cỡ:</h4>
                                            <div class="btn-group btn-group-sm">
                                            <c:forEach items="${size.rows}" var="ls">
                                                <c:set var="bg" value=""/>
                                                <c:if test="${param.kc1!=null}">
                                                    <c:if test="${param.kc1==ls.id_kc}">
                                                        <c:set var="bg" value="bg-danger text-white"/>
                                                    </c:if>
                                                </c:if>
                                                <a  class="btn ${bg}" href="product-detail.jsp?kc1=${ls.id_kc}&idsp=${param.idsp}&sl1=${sl}">${ls.kichco}</a>
                                            </c:forEach>
                                            </div> 
                                        </div>
                                        <div class="p-color">
                                            <h4>Màu sắc:</h4>
                                            <div class="btn-group btn-group-sm">
                                                ${list.mausac}
                                            </div> 
                                        </div>
                                        <c:set var="isk" value="idsp=${param.idsp}&kc1=${kc}&sl1=${sl}&" />
                                        <div class="action">
                                            <a class="btn" href="Cart?${isk}sl=${sl}&kc=${kc}&id_sp=${list.id_sp}&gia=${gia}&back=detail"><i class="fa fa-shopping-cart"></i>Thêm vào giỏ</a>
                                            <a class="btn" href="Cart?sl=${sl}&kc=${kc}&id_sp=${list.id_sp}&gia=${gia}&back=checkout"><i class="fa fa-shopping-bag"></i>Mua ngay</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:set var="mt" value="active" />
                        <c:set var="dg" value="" />
                        <c:if test="${param.active!=null}">
                            <c:set var="dg" value="active" />
                            <c:set var="mt" value="" />
                        </c:if>
                        <div class="row product-detail-bottom">
                            <div class="col-lg-12">
                                <ul class="nav nav-pills nav-justified">
                                    <li class="nav-item">
                                        <a class="nav-link ${mt}" data-toggle="pill" href="#description">Mô tả</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="pill" href="#specification">Chất liệu</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${dg}" data-toggle="pill" href="#reviews">Bình luận</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div id="description" class="container tab-pane ${mt}">
                                        <h4>Mô tả sản phẩm</h4>
                                        <p>
                                            ${list.chitiet}
                                        </p>
                                    </div>
                                    <div id="specification" class="container tab-pane fade">
                                        <h4>Chất liệu sản phẩm</h4>
                                        ${list.chatlieu}
                                    </div>
                                    <div id="reviews" class="container tab-pane ${dg}">
                                        <div class="reviews-submitted">
                                            <c:forEach items="${bl.rows}" var="bll" >
                                            <div class="reviewer">${bll.hoten} - <span><fmt:formatDate type="date" value="${bll.ngaybl}"/></span></div>
                                            <p>
                                                ${bll.noidung}
                                            </p>
                                            </c:forEach>
                                        </div>
                                        <div class="reviews-submit">
                                            <h4>Để lại bình luận của bạn:</h4>
                                            <form method="post" action="Xulybl" class="row form">
                                                <input type="hidden" name="idsp" value="${param.idsp}" />
                                                <input type="hidden" name="sl1" value="${sl}" />
                                                <input type="hidden" name="kc1" value="${kc}" />
                                                <input type="hidden" name="active" value="true" />
                                                <c:if test="${sessionScope.idtk==null}">
                                                 <div class="col-sm-6">
                                                     <input name="hoten" type="text" placeholder="Tên" required>
                                                </div>
                                                <div class="col-sm-6">
                                                    <input name="mail" type="email" placeholder="Email" required>
                                                </div>
                                                </c:if>
                                                <div class="col-sm-12">
                                                    <textarea name="noidung" placeholder="Nội dung" required></textarea>
                                                </div>
                                                <div class="col-sm-12">
                                                    <button type="submit">Gửi</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        <div class="product">
                            <div class="section-header">
                                <h1>Sản phẩm liên quan</h1>
                            </div>

                            <div class="row align-items-center product-slider product-slider-3">
                                <s:query dataSource="${db}" var="lk" >
                                    ${sql}
                                </s:query>
                                <c:forEach items="${lk.rows}" var="lklist">
                                <c:choose>
                                    <c:when test="${lklist.id_dm==1}">
                                        <c:set var="kc" value="${8}"/>
                                    </c:when>
                                    <c:when test="${(lklist.id_dm==2)||(lklist.id_dm==3)}">
                                        <c:set var="kc" value="${14}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="kc" value="${1}"/>
                                    </c:otherwise>
                                </c:choose>
                                <c:set var="ten" value="${lklist.tensp}"/>
                                <c:if test="${fn:length(ten)<=32}">
                                    <c:set var="ten" value="${lklist.tensp}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>
                                </c:if>
                                <c:set var="gia" value="${lklist.gia-(lklist.gia*lklist.sale/100)}" />
                                 <div class="col-lg-3">
                                    <div class="product-item">
                                        <div class="product-title">
                                            <a href="product-detail.jsp?idsp=${lklist.id_sp}">${ten}</a>
                                        </div>
                                        <div class="product-image">
                                            <a href="product-detail.jsp?idsp=${lklist.id_sp}">
                                                <img src="${lklist.anhmh}" alt="Product Image" width="90" height="310">
                                            </a>
                                            <div class="product-action">
                                                <a href="Cart?${isk}sl=1&kc=${kc}&id_sp=${lklist.id_sp}&gia=${gia}&back=detail"><i class="fa fa-cart-plus"></i></a>
                                                <a href="product-detail.jsp?idsp=${lklist.id_sp}"><i class="fa fa-search"></i></a>
                                            </div>
                                        </div>
                                        <div class="product-price">
                                            <h3><fmt:formatNumber type="number" pattern="###,###,###" value="${gia}"/><span>đ</span></h3>
                                            <a class="btn" href="Cart?sl=1&kc=${kc}&id_sp=${lklist.id_sp}&gia=${gia}&back=checkout"><i class="fa fa-shopping-cart"></i>Mua</a>
                                        </div>
                                    </div>
                                </div> 
                                </c:forEach>
                            </div>
                        </div>
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
                                <s:query dataSource="${db}" var="lk2">
                                    select * from sanpham order by RAND() limit 3;
                                </s:query>
                                <c:forEach items="${lk2.rows}" var="rl">
                                <c:choose>
                                    <c:when test="${rl.id_dm==1}">
                                        <c:set var="kc" value="${8}"/>
                                    </c:when>
                                    <c:when test="${(rl.id_dm==2)||(rl.id_dm==3)}">
                                        <c:set var="kc" value="${14}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="kc" value="${1}"/>
                                    </c:otherwise>
                                </c:choose>
                                <c:set var="ten" value="${rl.tensp}"/>
                                <c:if test="${fn:length(ten)<=40}">
                                    <c:set var="ten" value="${rl.tensp}<br><br>"/>
                                </c:if>
                                <c:set var="gia" value="${rl.gia-(rl.gia*rl.sale/100)}" />
                                    <div class="product-item">
                                    <div class="product-title">
                                        <a href="product-detail.jsp?idsp=${rl.id_sp}">${ten}</a>
                                    </div>
                                    <div class="product-image">
                                        <a href="product-detail.jsp?idsp=${rl.id_sp}">
                                            <img src="${rl.anhmh}" alt="Product Image" width="90" height="310">
                                        </a>
                                        <div class="product-action">
                                            <a href="Cart?${isk}sl=1&kc=${kc}&id_sp=${rl.id_sp}&gia=${gia}&back=detail"><i class="fa fa-cart-plus"></i></a>
                                            <a href="product-detail.jsp?idsp=${rl.id_sp}"><i class="fa fa-search"></i></a>
                                        </div>
                                    </div>
                                    <div class="product-price">
                                        <h3><fmt:formatNumber type="number" pattern="###,###,###" value="${gia}"/><span>đ</span></h3>
                                        <a class="btn" href="Cart?sl=1&kc=${kc}&id_sp=${rl.id_sp}&gia=${gia}&back=checkout"><i class="fa fa-shopping-cart"></i>Mua</a>
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
        <!-- Product Detail End -->
        
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
