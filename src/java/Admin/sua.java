/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.RequestDispatcher;
/**
 *
 * @author user
 */
public class sua extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connect connect=new Connect();
                Connection conn=connect.getConn();  
                String tenbang=request.getParameter("tenbang");
                String sql="select * from "+tenbang;
                PreparedStatement pt=conn.prepareStatement(sql);
                ResultSet rs=pt.executeQuery();
                ResultSetMetaData rsmd=rs.getMetaData();
                int clc=rsmd.getColumnCount();
                String sql1="update "+tenbang+" set ";
                for(int i=2;i<=clc;i++){
                    if(i==clc){
                        if(rsmd.getColumnTypeName(i).equals("VARCHAR")||rsmd.getColumnTypeName(i).equals("DATE")||rsmd.getColumnTypeName(i).equals("DATETIME")){
                        sql1+=rsmd.getColumnName(i)+"='"+request.getParameter(rsmd.getColumnName(i))+"'";
                    }else{
                        sql1+=rsmd.getColumnName(i)+"="+request.getParameter(rsmd.getColumnName(i));
                    }
                    }
                    else{
                        if(rsmd.getColumnTypeName(i).equals("VARCHAR")||rsmd.getColumnTypeName(i).equals("DATE")||rsmd.getColumnTypeName(i).equals("DATETIME")){
                        sql1+=rsmd.getColumnName(i)+"='"+request.getParameter(rsmd.getColumnName(i))+"',";
                    }
                    else if(rsmd.getColumnName(i).equals("giasale")){
                        Float gia=Float.parseFloat(request.getParameter("gia"));
                        Float sale=Float.parseFloat(request.getParameter("sale"));
                        float giasale=gia-((gia*sale)/100);
                        sql1+="giasale="+(int)giasale+",";
                    }
                    else{
                        sql1+=rsmd.getColumnName(i)+"="+request.getParameter(rsmd.getColumnName(i))+",";
                    }
                    }     
                }
                sql1+=request.getParameter("where");
                pt=conn.prepareStatement(sql1);
                int i=pt.executeUpdate();
                if(i>0){
                    String ten="";
                       switch (tenbang) {
                        case "sanpham":
                            ten="sản phẩm";
                            break;
                        case "admin":
                            ten="admin";
                            break;
                        case "anhchitiet":
                            ten="ảnh chi tiết";
                            break;
                        case "danhmuc":
                            ten="danh mục";
                            break;
                        case "kichco":
                            ten="kích cỡ";
                            break;
                        case "soluong":
                            ten="số lượng";
                            break;
                        case "tinhtrangdh":
                            ten="tình trạng đơn hàng";
                            break;
                        case "donhang":
                            ten="đơn hàng";
                            break;
                        case "khachhang":
                            ten="khách hàng";
                            break;
                        case "taikhoan":
                            ten="tài khoản";
                            break;
                         case "banner":
                            ten="banner";
                            break;
                       }
                       out.print("<script>window.alert(\"Sửa "+ten+" thành công\");location='admin/bang.jsp?trang=1&tenbang="+tenbang+"';</script>");
                }
                conn.close();
            } catch (Exception e) {e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
