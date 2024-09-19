<%-- 
    Document   : forward
    Created on : Apr 18, 2022, 5:05:50 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="s" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Store.GioHang"%>
<jsp:useBean id="conn" class="Store.ConnectInfo"></jsp:useBean>
<s:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="${conn.getUrl()}" password="${conn.getPass()}" user="${conn.getUser()}"/>
<s:query dataSource="${db}" var="tsl" >
    select soluong from soluong where id_sp=? and id_kc=?;
<s:param value="${param.id_sp}"/>
<s:param value="${param.kc}"/>
</s:query>
<c:forEach items="${tsl.rows}" var="list">
    <c:choose>
        <c:when test="${list.soluong<param.sl}">
            <script>window.alert("Cửa hàng chúng tôi hiện còn khoảng "+list.soluong+" sản phẩm,mời bạn chọn lại")</script>
            <jsp:include page="product-detail.jsp" />
        </c:when>
        <c:otherwise>
            <%
                ArrayList<GioHang> cart=(ArrayList<GioHang>)session.getAttribute("cart");
                boolean check=false;   
            %>
            <s:query dataSource="${db}" var="gh">
                select * from sanpham where id_sp=?
            <s:param value="${param.id_sp}"/>
            </s:query>
                <c:forEach items="${gh.rows}" var="ghl">
                    <jsp:useBean id="giohang" class="Store.GioHang"/>
                    <jsp:setProperty name="giohang" property="anh" value="${ghl.anhmh}"/>
                    <jsp:setProperty name="giohang" property="ten" value="${ghl.tensp}"/>
                    <jsp:setProperty name="giohang" property="gia" value="${param.gia}"/>
                    <jsp:setProperty name="giohang" property="sl" value="${param.sl}"/>
                    <jsp:setProperty name="giohang" property="kc" value="${param.kc}"/>
                    <jsp:setProperty name="giohang" property="idsp" value="${param.id_sp}"/>
                    <jsp:setProperty name="giohang" property="iddm" value="${ghl.id_dm}"/>
                    <%
                       giohang.setKcl();
                       cart.add(giohang);
                    %>
                    <c:if test="${param.back=='index'}">
                        <jsp:forward page="index.jsp" />
                    </c:if>
                    <c:if test="${param.back=='list'}">
                        <jsp:forward page="product-list.jsp" />
                    </c:if>
                    <c:if test="${param.back=='detail'}">
                        <jsp:forward page="product-detail.jsp" />
                    </c:if>
                    <c:if test="${param.back=='checkout'}">
                        <jsp:forward page="Xulyco" />
                    </c:if>
                </c:forEach>
        </c:otherwise>
    </c:choose>
</c:forEach>

