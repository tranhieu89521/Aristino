<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Store.GioHang"%>
<%@page import="Store.KichCo"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.DecimalFormat" %>
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
        <c:set var="back" value="back=cart" />
        <%
            ArrayList<GioHang> gh=(ArrayList<GioHang>)session.getAttribute("cart");
            int j=0;
            if(request.getParameter("remove")!=null){
            if(Integer.parseInt(request.getParameter("l"))==gh.size()){
                gh.remove(Integer.parseInt(request.getParameter("remove")));
            } }
         %>
        <%@include file="header.jsp" %>
        
        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container-fluid">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="product-list.jsp?trang=1">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Giỏ hàng</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->
        
        <!-- Cart Start -->
        <div class="cart-page">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="cart-page-inner">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Kích cỡ</th>
                                            <th>Số lượng</th>
                                            <th>Tổng giá</th>
                                            <th>Xóa</th>
                                        </tr>
                                    </thead>
                                    <tbody class="align-middle">
                                    <%
                                        DecimalFormat df = new DecimalFormat("###,###,###");
                                        int sl=0;
                                        int tg=0;
                                        int k=0;
                                        if(gh!=null){
                                        for(GioHang ghl:gh){
                                        ArrayList<KichCo> kc=ghl.getKcl();
                                        if((request.getParameter("giam")!=null)&&(Integer.parseInt(request.getParameter("giam"))==k)){
                                           ghl.setSl(ghl.getSl()-1);
                                        }
                                        if((request.getParameter("tang")!=null)&&(Integer.parseInt(request.getParameter("tang"))==k)){
                                           ghl.setSl(ghl.getSl()+1);
                                        }
                                        if((request.getParameter("idsp")!=null)&&(Integer.parseInt(request.getParameter("idsp"))==k)){
                                            ghl.setKc(Integer.parseInt(request.getParameter("idkc")));
                                            ghl.setTenkc(request.getParameter("kc"));
                                        }
                                        out.print("<tr>\n" +
                                            "<td>\n" +
                                            "<div class=\"img\">\n" +
                                            "<a href=\"product-detail.jsp?idsp="+ghl.getIdsp()+"\"><img src=\""+ghl.getAnh()+"\" alt=\"Image\"></a>\n" +
                                            "<p>"+ghl.getTen()+"</p>\n" +
                                            "</div>\n" +
                                            "</td>");
                                        out.print("<td>"+df.format(ghl.getGia())+"đ</td>");
                                        out.print("<td><div class=\"dropdown\">\n" +
                                                  "  <button type=\"button\" data-toggle=\"dropdown\">\n" +
                                                  ghl.getTenkc() +
                                                  "  </button>\n" +
                                                  "  <div class=\"dropdown-menu\">");
                                        for(int i=0;i<kc.size();i++){
                                            if(kc.get(i).getIdkc()!=ghl.getKc()){
                                                out.print("<a class=\"dropdown-item\" href=\"cart.jsp?idsp="+k+"&idkc="+kc.get(i).getIdkc()+"&kc="+kc.get(i).getKc()+"\">"+kc.get(i).getKc()+"</a>");
                                            }
                                        }
                                        out.print("</div></div></td>");
                                        out.print("<td>\n" +
                                                    "<a href=\"cart.jsp?giam="+k+"\"><i class=\"fa fa-minus\"></i></a>\n" +
                                                    "<input type=\"text\" value=\""+ghl.getSl()+"\" disabled>\n" +
                                                    "<a href=\"cart.jsp?tang="+k+"\"><i class=\"fa fa-plus\"></i></a>\n" +
                                         "</td>");
                                        out.print("<td>"+df.format((((int)ghl.getGia())*ghl.getSl()))+"đ</td>");
                                        out.print("<td><a href=\"cart.jsp?remove="+j+"&l="+gh.size()+"\"><i class=\"fa fa-trash\"></i></a></td>\n" +
                                         "</tr>");
                                         sl+=ghl.getSl();
                                         tg+=((int)ghl.getGia()*ghl.getSl());
                                         k++;
                                         j++;
                                        }  
                                      }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="cart-page-inner">
                            <div class="row">
                                <div class="col-md-12">
                                </div>
                                <div class="col-md-12">
                                    <div class="cart-summary">
                                        <div class="cart-content">
                                            <h1>Tổng cộng</h1>
                                            <%
                                                out.print("<p>Số lượng<span>"+df.format(sl)+"</span></p>");
                                                out.print("<h2>Tổng giá<span>"+df.format(tg)+"đ</span></h2>");
                                            %>
                                        </div>
                                        <div class="cart-btn">
                                            <br>
                                            <%
                                                if(sl>0){
                                                out.print("<a class=\"btn\" href=\"Xulyco?back=checkout\">Đặt hàng</a>");
                                                }    
                                            %>  
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Cart End -->
        
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
