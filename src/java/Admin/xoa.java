/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
/**
 *
 * @author user
 */
public class xoa extends HttpServlet {

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
            int id=Integer.parseInt(request.getParameter("id"));
            String tenbang=request.getParameter("tenbang");
            String tencot=request.getParameter("tencot");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connect connect=new Connect();
                Connection conn=connect.getConn();
                int i=0;
                if(tenbang.equals("chitietdh")){
                    int idsp=Integer.parseInt(request.getParameter("idsp"));
                     int idkc=Integer.parseInt(request.getParameter("idkc"));
                    i+=connect.deletect(tenbang, id, tencot,idsp,idkc);
                }
                else{
                    i+=connect.getR(tencot,tenbang,id);
                }
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
                        case "binhluan":
                            ten="bình luận";
                            break;
                        case "chitietdh":
                            ten="chi tiết đơn hàng";
                            break;
                        case "banner":
                            ten="banner";
                            break;
                       }
                       out.print("<script>window.alert(\"Xóa "+ten+" thành công\");location='admin/bang.jsp?trang=1&tenbang="+tenbang+"';</script>");
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
