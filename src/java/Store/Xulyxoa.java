/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Store;

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
public class Xulyxoa extends HttpServlet {

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
                int iddh=Integer.parseInt(request.getParameter("iddh"));
                int idsp=Integer.parseInt(request.getParameter("idsp"));
                int idkc=Integer.parseInt(request.getParameter("idkc"));
                int sl=Integer.parseInt(request.getParameter("sl"));
                String sql="select id_tr from donhang where id_dh=?";
                PreparedStatement pt=conn.prepareStatement(sql);
                pt.setInt(1, iddh);
                boolean test=false;
                ResultSet rs=pt.executeQuery();
                while (rs.next()) {                    
                    if(rs.getInt(1)==1){
                        test=true;
                    }
                }
                if(test){
                    sql="select tonggia from chitietdh where id_dh=? and id_sp=? and id_kc=?";
                    pt=conn.prepareStatement(sql);pt.setInt(1, iddh);pt.setInt(2, idsp);pt.setInt(3, idkc);
                    rs=pt.executeQuery();
                    int tonggia=0;int tongtien=0;
                    while (rs.next()) {     
                        tonggia=rs.getInt(1);  
                    }
                    sql="select tongtien from donhang where id_dh=?";
                    pt=conn.prepareStatement(sql);pt.setInt(1, iddh);
                    rs=pt.executeQuery();
                    while (rs.next()) {                            
                         tongtien=rs.getInt(1);
                    }
                    sql="delete from chitietdh where id_dh=? and id_sp=? and id_kc=?";
                    pt=conn.prepareStatement(sql);pt.setInt(1, iddh);pt.setInt(2, idsp);pt.setInt(3, idkc);
                    int i=pt.executeUpdate();
                     if(i>0){
                               sql="select daban from sanpham where id_sp=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, idsp);
                               rs=pt.executeQuery();int daban=0;
                               while (rs.next()) {                                   
                                   daban=rs.getInt(1)-sl;
                               }
                               sql="update sanpham set daban=? where id_sp=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, daban);pt.setInt(2, idsp);
                               i=pt.executeUpdate();
                               if(i>0){
                               sql="select soluong from soluong where id_sp=? and id_kc=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, idsp);pt.setInt(2, idkc);
                               rs=pt.executeQuery();int soluong=0;
                               while (rs.next()) {                                   
                                   soluong=rs.getInt(1)+sl;
                               }
                               sql="update soluong set soluong=? where id_sp=? and id_kc=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, soluong);pt.setInt(2, idsp);pt.setInt(3, idkc);
                               i=pt.executeUpdate();  
                               }
                           }
                    if(i>0){
                        if((tongtien-tonggia)==0){
                        sql="delete from donhang where id_dh=?";
                        pt=conn.prepareStatement(sql);pt.setInt(1, iddh);
                        i=pt.executeUpdate();
                        if(i>0){
                        RequestDispatcher rd=request.getRequestDispatcher("/my-account.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Xóa đơn thành công\")</script>");
                        }
                         }
                    else{
                        sql="update donhang set tongtien=? where id_dh=?";
                        pt=conn.prepareStatement(sql);pt.setInt(1, (tongtien-tonggia));pt.setInt(2, iddh);
                        i=pt.executeUpdate();
                        if(i>0){
                        RequestDispatcher rd=request.getRequestDispatcher("/my-account.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Xóa hàng trong đơn thành công\")</script>");
                        }
                        }
                    }   
                }
                else{
                    RequestDispatcher rd=request.getRequestDispatcher("/my-account.jsp");
                    rd.include(request, response);
                    out.print("<script>window.alert(\"Đơn hàng đã được xác nhận xong không thể xóa đơn\")</script>");
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
