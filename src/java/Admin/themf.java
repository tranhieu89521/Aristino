/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package Admin;

import java.io.IOException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.sql.*;
/**
 *
 * @author user
 */
public class themf extends SimpleTagSupport {
    private String tenbang;

    public void setTenbang(String tenbang) {
        this.tenbang = tenbang;
    }
    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut(); 
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connect connect=new Connect();
            Connection conn=connect.getConn();
            String sql="select * from "+tenbang;
            PreparedStatement pt=conn.prepareStatement(sql);
            ResultSet rs=pt.executeQuery();
            ResultSetMetaData rsmd=rs.getMetaData();
            int clc=rsmd.getColumnCount();   
            for(int i=2;i<=clc;i++){
                String ten=rsmd.getColumnName(i);
                String att="";
                if(ten.equals("sale")){
                    att="min=\"0\" max=\"100\"";
                }
                if (ten.equals("gia")) {
                    att="minlength=\"10\"";
                }
                if(!ten.equals("giasale")){
                if(ten.equals("id_dm")||ten.equals("id_sp")||ten.equals("id_kc")||ten.equals("id_tr")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<select class=\"form-control\" name=\""+ten+"\">");
                    ResultSet rs1=connect.getF(ten);
                    while (rs1.next()) { 
                            out.println("<option value=\""+rs1.getInt(1)+"\">"+rs1.getString(2)+"</option>");
                    }
                    out.println("</select></div>");
                }
                else if(ten.equals("chitiet")||ten.equals("chatlieu")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<textarea class=\"form-control\" name=\""+ten+"\"></textarea>");
                    out.println("</div>");
                }
                else if(ten.equals("email")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"email\"  placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("VARCHAR")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"text\"  placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("DATE")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"date\"  placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("INT")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"number\"  placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\" "+att+">");
                    out.println("</div>");
                }}
            }
            conn.close();
        } catch (IOException | ClassNotFoundException | SQLException ex) {
        }
    }
    
}
