/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package Store;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author user
 */
public class List extends SimpleTagSupport {

    @Override
    public void doTag() throws JspException,IOException {
        JspWriter out = getJspContext().getOut();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connect connect=new Connect();
            Connection conn=connect.getConn();
                String sql="select * from danhmuc";
                PreparedStatement ps=conn.prepareStatement(sql);
                ResultSet rs=ps.executeQuery();
                while(rs.next()){
                    out.println("<li class=\"nav-item\">\n" +
"                                    <a class=\"nav-link\" href=\"product-list.jsp?iddm="+rs.getInt(1)+"&trang=1\"><i class=\"fa fa-tshirt\"></i>"+rs.getString(2)+"</a>\n" +
"                                </li>");
                }
                conn.close();
        } catch (Exception ex) {
            
        }
    }
    
}
