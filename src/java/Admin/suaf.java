/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.text.DecimalFormat;

/**
 *
 * @author user
 */
public class suaf extends SimpleTagSupport {

    private String tenbang;

    public void setTenbang(String tenbang) {
        this.tenbang = tenbang;
    }
    
    private String tenid;

    public void setTenid(String tenid) {
        this.tenid = tenid;
    }
    private int id;

    public void setId(int id) {
        this.id = id;
    }
    
    
    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();
        DecimalFormat df = new DecimalFormat("###,###,###");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connect connect=new Connect();
            Connection conn=connect.getConn();
            String sql="select * from "+tenbang+" where "+tenid+"="+id;
            PreparedStatement pt=conn.prepareCall(sql);
            ResultSet rs=pt.executeQuery();
            ResultSetMetaData rsmd=rs.getMetaData();
            int clc=rsmd.getColumnCount();   
            while (rs.next()) {
            for(int i=2;i<=clc;i++){
                String ten=rsmd.getColumnName(i);
                String att="";
                if(ten.equals("sale")){
                    att="min=\"0\" max=\"100\"";
                }
                if (ten.equals("gia")) {
                    att="minlength=\"10\"";
                }
                if (ten.equals("sdt")) {
                    att="minlength=\"11\" maxlength=\"11\"";
                }
                if(ten.equals("id_dm")||ten.equals("id_sp")||ten.equals("id_tk")||ten.equals("id_kc")||ten.equals("id_tr")||(ten.equals("id_kh"))){
                    if((tenbang.equals("donhang"))&&(ten.equals("id_kh"))){
                    String sql1="select ho,ten from khachhang where id_kh="+rs.getInt(i);
                    PreparedStatement pt1=conn.prepareStatement(sql1);
                    ResultSet rs2=pt1.executeQuery();
                    while (rs2.next()) {                            
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"text\" value=\""+rs2.getString(1)+" "+rs2.getString(2)+"\" readonly>");
                    out.println("<input class=\"form-control\" type=\"hidden\" value=\""+rs.getInt(i)+"\" name=\""+ten+"\">");
                    out.println("</div>");
                    }
                    }
                    else{
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<select class=\"form-control\" name=\""+ten+"\">");
                    ResultSet rs1=connect.getF(ten);
                    while (rs1.next()) {   
                        String sel="";
                        if(rs1.getInt(1)==rs.getInt(i)){
                            sel="selected";
                        }
                        if(ten.equals("id_kh")){
                            out.println("<option value=\""+rs1.getInt(1)+"\""+sel+">"+rs1.getString(2)+" "+rs1.getString(3)+"</option>");
                        }
                        else{
                            out.println("<option value=\""+rs1.getInt(1)+"\""+sel+">"+rs1.getString(2)+"</option>");
                        }
                    }
                    out.println("</select></div>");}
                }
                else if(ten.equals("chitiet")||ten.equals("chatlieu")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<textarea class=\"form-control\" name=\""+ten+"\">"+rs.getString(i)+"</textarea>");
                    out.println("</div>");
                } 
                else if(ten.equals("email")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"email\" value=\""+rs.getString(i)+"\"  placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("VARCHAR")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"text\" value=\""+rs.getString(i)+"\"  placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("DATE")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"date\" value=\""+rs.getString(i)+"\" placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("INT")){
                    String re="";
                    if(ten.equals("tongtien")||ten.equals("giasale")){
                        re="readonly";
                    }
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"number\" value=\""+rs.getInt(i)+"\" placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\" "+re+" "+att+">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("BIGINT")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"number\" value=\""+rs.getLong(i)+"\" placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\" "+att+">");
                    out.println("</div>");
                }
                else if(rsmd.getColumnTypeName(i).equals("DATETIME")){
                    out.println("<div class=\"form-group\">");
                    out.println("<span>"+connect.getName(ten)+"</span>");
                    out.println("<input class=\"form-control\" type=\"text\" value=\""+rs.getString(i)+"\" placeholder=\""+connect.getName(ten)+"\" name=\""+ten+"\" readonly>");
                    out.println("</div>");
                }
            }}
            conn.close();
        } catch (Exception ex) {
           ex.printStackTrace();
        }
    }
    
}
