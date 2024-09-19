/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package Store;

import java.io.IOException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.text.DecimalFormat;
import java.sql.*;
/**
 *
 * @author user
 */
public class Featured extends SimpleTagSupport {

    /**
     * Called by the container to invoke this tag. The implementation of this method is provided by the tag library developer, and handles all tag processing, body iteration, etc.
     */
    @Override
    public void doTag() throws JspException,IOException {
        JspWriter out = getJspContext().getOut();
        
        try {
            DecimalFormat df = new DecimalFormat("###,###,###");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connect connect=new Connect();
            Connection conn=connect.getConn();
                String sql="select * from sanpham order by sale desc limit 5";
                PreparedStatement ps=conn.prepareStatement(sql);
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    String ten=rs.getString(3);
                    if(ten.length()<=32){
                        ten=ten+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    }
                    float sale=((float)rs.getInt(6))/100;
                    float gia=((float)rs.getInt(5))-(((float)rs.getInt(5))*sale);
                    int kc;
                    if(rs.getInt(2)==1){
                        kc=8;
                    }
                    else if((rs.getInt(2)==2)||(rs.getInt(2)==3)){
                        kc=14;
                    }
                    else{
                        kc=1;
                    }
                    out.println("<div class=\"col-lg-3\">");
                    out.println("<div class=\"product-item\">");
                    out.println("<div class=\"product-title\">");
                    out.println("<a href=\"product-detail.jsp?idsp="+rs.getInt(1)+"\">"+ten+"</a>");
                    out.println("</div>");
                    out.println("<div class=\"product-image\">");
                    out.println(" <a href=\"product-detail.jsp?idsp="+rs.getInt(1)+"\">");
                    out.println("<img src=\""+rs.getString(4)+"\" alt=\"Product Image\">");
                    out.println("</a>");
                    out.println("<div class=\"product-action\">");
                    out.println("<a href=\"Cart?sl=1&kc="+kc+"&id_sp="+rs.getInt(1)+"&gia="+(int)gia+"&back=index\"><i class=\"fa fa-cart-plus\"></i></a>");
                    out.println("<a href=\"product-detail.jsp?idsp="+rs.getInt(1)+"\"><i class=\"fa fa-search\"></i></a>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("<div class=\"product-price\">");
                    out.println("<h3>"+df.format((int)gia)+"<span>đ</span></h3>");
                    out.println("<a class=\"btn\" href=\"Cart?sl=1&kc="+kc+"&id_sp="+rs.getInt(1)+"&gia="+(int)gia+"&back=checkout\"><i class=\"fa fa-shopping-cart\"></i>Mua ngay</a>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("</div>");
                }
                conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
}
