/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/TagHandler.java to edit this template
 */
package Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DecimalFormat;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author user
 */
public class bang extends SimpleTagSupport {

    /**
     * Called by the container to invoke this tag. The implementation of this method is provided by the tag library developer, and handles all tag processing, body iteration, etc.
     */
    private int trang;

    public void setTrang(int trang) {
        this.trang = trang;
    }
    
    private String tenbang;

    public void setTenbang(String tenbang) {
        this.tenbang = tenbang;
    }
    
    private String search=null;

    public void setSearch(String search) {
        this.search = search;
    } 
    
    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();
        try {
            DecimalFormat df = new DecimalFormat("###,###,###");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connect connect=new Connect();
            Connection conn=connect.getConn();
            int ssp=8;
            if(tenbang.equals("soluong")){
                ssp=17;
            }
            String where="";
            String s="";
            if(search!=null){ 
            String sql1;
            if(tenbang.equals("anhchitiet")||tenbang.equals("binhluan")||tenbang.equals("chitietdh")||tenbang.equals("donhang")||tenbang.equals("khachhang")||tenbang.equals("sanpham")||tenbang.equals("soluong")){
                sql1=connect.search(tenbang)[0];
            }
            else{
                sql1="select * from "+tenbang;
            }  
            s="&search="+search;
            PreparedStatement ps1=conn.prepareStatement(sql1);
            ResultSet rs1=ps1.executeQuery();
            ResultSetMetaData rsmd1=rs1.getMetaData();
            int clc1=rsmd1.getColumnCount();
            int sb1;
            if(tenbang.equals("chitietdh")){
                sb1=clc1-2;
            }
            else{
                sb1=clc1;
            }
            for(int i=1;i<=sb1;i++){
                if(i==1){
                    where=" where ("+rsmd1.getColumnName(i)+" like '%"+search+"%')";
                }
                else{
                    where+=" or ("+rsmd1.getColumnName(i)+" like '%"+search+"%')";
                }   
            }
            }
            String sql;
            if(tenbang.equals("anhchitiet")||tenbang.equals("binhluan")||tenbang.equals("chitietdh")||tenbang.equals("donhang")||tenbang.equals("khachhang")||tenbang.equals("sanpham")||tenbang.equals("soluong")){
                sql=connect.search(tenbang)[0]+where+" limit "+ssp+" OFFSET "+((trang-1)*ssp);
            }
            else{
                sql="select * from "+tenbang+where+" limit "+ssp+" OFFSET "+((trang-1)*ssp);
            }
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery();
            ResultSetMetaData rsmd=rs.getMetaData();
            int clc=rsmd.getColumnCount();
            int i=((trang-1)*ssp)+1;
            int j1;
            int sb;
            if(tenbang.equals("chitietdh")){
                j1=1;
                sb=clc-2;
            }
            else{
                j1=2;
                sb=clc;
            }       
            out.println("<table class=\"table table-striped table-bordered\"><thead><tr>");
            out.println("<th>Stt</th>");
            for(int j=j1;j<=sb;j++){
                out.println("<th>"+connect.getName(rsmd.getColumnName(j))+"</th>");
            }
            out.println("<th>Cập nhật</th>");
            out.println("</tr></thead><tbody>");
            while (rs.next()) {                
                out.println("<tr>");
                out.println("<td>"+i+"</td>");
                for(int j=j1;j<=sb;j++){
                    String ten=rsmd.getColumnName(j);
                    if(ten.equals("anhmh")||ten.equals("anhct1")||ten.equals("anhct2")||ten.equals("anhct3")||ten.equals("anhct4")||ten.equals("anhct5")||ten.equals("banner")){
                        out.println("<td><img src=\"../"+rs.getString(j)+"\"></td>");
                    }
                    else if(ten.equals("chitiet")||ten.equals("chatlieu")){
                        out.println("<td><p class=\"ctcl\">"+rs.getString(j)+"</p></td>");
                    }   
                    else if(rsmd.getColumnTypeName(j).equals("VARCHAR")||rsmd.getColumnTypeName(j).equals("DATE")||rsmd.getColumnTypeName(j).equals("DATETIME")){
                        out.println("<td>"+rs.getString(j)+"</td>");
                    }
                    else if(rsmd.getColumnTypeName(j).equals("BIGINT")){
                        out.println("<td>"+rs.getLong(j)+"</td>");
                    }
                    else{
                        out.println("<td>"+rs.getInt(j)+"</td>");
                    }
                }
                if(tenbang.equals("binhluan")||tenbang.equals("chitietdh")){
                    String sk="";
                    if(tenbang.equals("chitietdh")){
                        sk="&idsp="+rs.getInt(6)+"&idkc="+rs.getInt(7);
                    }
                    out.println("<td><a href=\"../xoa?tenbang="+tenbang+"&tencot="+rsmd.getColumnName(1)+"&id="+rs.getInt(1)+sk+"&trang="+trang+s+"\" onclick=\"return confirm('Bạn có thực sự muốn xóa?')\" class=\"btn btn-warning\">Xóa</a></td>");
                }
                else{
                    out.println("<td><a href=\"sua.jsp?tenbang="+tenbang+"&id="+rs.getInt(1)+"&tenid="+rsmd.getColumnName(1)+"&trang="+trang+s+"\" class=\"btn btn-warning\">Cập nhật</a></td>");
                } 
                out.println("</tr>");
                i++;
            }
            out.println("</tbody></table>");
            int tt=0;
            int st; 
            if(tenbang.equals("anhchitiet")||tenbang.equals("binhluan")||tenbang.equals("chitietdh")||tenbang.equals("donhang")||tenbang.equals("khachhang")||tenbang.equals("sanpham")||tenbang.equals("soluong")){
                sql=connect.search(tenbang)[1]+where;
            }
            else{
                sql="select count("+rsmd.getColumnName(1)+") from "+tenbang+where;
            }
            ps=conn.prepareStatement(sql);
            rs=ps.executeQuery();
            while (rs.next()) {                
                tt=rs.getInt(1);
            }
            if(tt%ssp==0){
                st=tt/ssp;
            }
            else{
                st=((tt-(tt%ssp))/ssp)+1;
            }
            if(st>1){
            out.println("<ul class=\"pagination\">");
            for(int k=1;k<=st;k++){
                if(k==trang){
                     out.println("<li class=\"page-item active\"><a class=\"page-link\"  href=\"bang.jsp?tenbang="+tenbang+"&trang="+k+s+"\">"+k+"</a></li>");
                }
                else{
                    out.println("<li class=\"page-item\"><a class=\"page-link\"  href=\"bang.jsp?tenbang="+tenbang+"&trang="+k+s+"\">"+k+"</a><br></li>");
                }   
            }
            out.println("</ul>");}
            conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
