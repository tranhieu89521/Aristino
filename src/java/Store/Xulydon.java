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
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author user
 */
public class Xulydon extends HttpServlet {

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
                HttpSession session=request.getSession();
                ArrayList<GioHang> gh=(ArrayList<GioHang>)session.getAttribute("cart");
                int tonggia=0;
                for(GioHang ghl:gh){
                    tonggia+=((int)ghl.getGia()*ghl.getSl());
                }
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connect connect=new Connect();
                Connection conn=connect.getConn();
                String ho=request.getParameter("ho");
                String ten=request.getParameter("ten");
                String email=request.getParameter("mail");
                Long sdt=Long.parseLong(request.getParameter("sdt"));
                String dc=request.getParameter("dc");
                String sql;
                int maxidkh=0;
                    sql="select id_kh from khachhang where id_tk=?";
                    PreparedStatement pt=conn.prepareStatement(sql);pt.setInt(1, (int)session.getAttribute("idtk"));
                    ResultSet rs=pt.executeQuery();
                    while (rs.next()) {  
                        maxidkh=rs.getInt(1);
                    } 
                sql="update khachhang set ho=?,ten=?,email=?,sdt=?,diachi=? where id_tk="+(int)session.getAttribute("idtk");
                pt=conn.prepareStatement(sql);
                pt.setString(1, ho);pt.setString(2, ten);pt.setString(3, email);pt.setLong(4, sdt);pt.setString(5, dc);
                int i=pt.executeUpdate();
                if(i>0){
                    sql="insert into donhang(id_kh,id_tr,tongtien,ngaydat) values(?,1,?,now())";
                    pt=conn.prepareStatement(sql);pt.setInt(1, maxidkh);pt.setInt(2, tonggia);
                    i=pt.executeUpdate();
                    if(i>0){
                        int maxiddh=connect.max("donhang", "id_dh");
                        int j=0;
                        for(GioHang ghl:gh){
                           int gia=((int)ghl.getGia()*ghl.getSl());
                           sql="insert into chitietdh values(?,?,?,?,?)";
                           pt=conn.prepareStatement(sql);
                           pt.setInt(1, maxiddh);pt.setInt(2, ghl.getIdsp());pt.setInt(3, ghl.getKc());pt.setInt(4, ghl.getSl());pt.setInt(5, gia);
                           int k=pt.executeUpdate();
                           j+=k;
                           if(k>0){
                               sql="select daban from sanpham where id_sp=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, ghl.getIdsp());
                               rs=pt.executeQuery();int daban=0;
                               while (rs.next()) {                                   
                                   daban=rs.getInt(1)+ghl.getSl();
                               }
                               sql="update sanpham set daban=? where id_sp=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, daban);pt.setInt(2, ghl.getIdsp());
                               int l=pt.executeUpdate();
                               j+=l;
                               if(l>0){
                               sql="select soluong from soluong where id_sp=? and id_kc=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, ghl.getIdsp());pt.setInt(2, ghl.getKc());
                               rs=pt.executeQuery();int soluong=0;
                               while (rs.next()) {                                   
                                   soluong=rs.getInt(1)-ghl.getSl();
                               }
                               sql="update soluong set soluong=? where id_sp=? and id_kc=?";
                               pt=conn.prepareStatement(sql);pt.setInt(1, soluong);pt.setInt(2, ghl.getIdsp());pt.setInt(3, ghl.getKc());
                               int p=pt.executeUpdate();
                               j+=p;
                               }
                           }
                        }
                        if(j>0){
                            gh.removeAll(gh);
                            RequestDispatcher rd=request.getRequestDispatcher("/my-account.jsp");
                            rd.include(request, response);
                            out.print("<script>window.alert(\"Đặt hàng thành công\")</script>");
                        }
                        else{
                            RequestDispatcher rd=request.getRequestDispatcher("/my-account.jsp");
                            rd.include(request, response);
                        }
                    }
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
