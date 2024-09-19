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

/**
 *
 * @author user
 */
public class Xulydk extends HttpServlet {

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
                String user=request.getParameter("user");
                boolean check=false;
                PreparedStatement pt=conn.prepareStatement("select tk from taikhoan where tk=?");
                pt.setString(1, user);
                ResultSet rs=pt.executeQuery();
                while(rs.next()){
                    check=true;
                }
                if(check){
                     RequestDispatcher rd=request.getRequestDispatcher("/register.jsp");
                     rd.include(request, response);
                     out.print("<script>window.alert(\"Tên tài khoản đã tồn tại hãy chọn tên khác\")</script>");
                }
                else{
                    String ho=request.getParameter("ho");
                    String ten=request.getParameter("ten");
                    String mail=request.getParameter("mail");
                    Long sdt=Long.parseLong(request.getParameter("sdt"));
                    String pass=request.getParameter("pass");
                    String dc=request.getParameter("dc");
                    String sql="insert into taikhoan(tk,mk) values(?,?)";
                    pt=conn.prepareStatement(sql);
                    pt.setString(1, user);pt.setString(2, pass);
                    int i=pt.executeUpdate();
                    if(i>0){
                        HttpSession session=request.getSession();
                        sql="select id_tk from taikhoan where tk=?";
                        pt=conn.prepareStatement(sql);pt.setString(1, user);
                        rs=pt.executeQuery();
                        while (rs.next()) {                            
                            session.setAttribute("idtk", rs.getInt(1));
                        }
                        session.setAttribute("user", user);
                        sql="insert into khachhang(id_tk,ho,ten,email,sdt,diachi) values("+(int)session.getAttribute("idtk")+",?,?,?,?,?)";
                        pt=conn.prepareStatement(sql);
                        pt.setString(1, ho);pt.setString(2, ten);pt.setString(3, mail);pt.setString(5, dc);pt.setLong(4, sdt);
                        i=pt.executeUpdate();
                        if(i>0){
                            String back=request.getParameter("back");
                    if(back.equals("index")){
                        RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Đăng ký thành công\")</script>"); 
                    }
                    if(back.equals("list")){
                        RequestDispatcher rd=request.getRequestDispatcher("/product-list.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Đăng ký thành công\")</script>"); 
                    }  
                    if(back.equals("detail")){
                        RequestDispatcher rd=request.getRequestDispatcher("/product-detail.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Đăng ký thành công\")</script>"); 
                    } 
                    if(back.equals("cart")){
                        RequestDispatcher rd=request.getRequestDispatcher("/cart.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Đăng ký thành công\")</script>"); 
                    } 
                    if(back.equals("checkout")){
                        RequestDispatcher rd=request.getRequestDispatcher("/checkout.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Đăng ký thành công\")</script>"); 
                    }
                    if(back.equals("contact")){
                        RequestDispatcher rd=request.getRequestDispatcher("/contact.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Đăng ký thành công\")</script>"); 
                    } 
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
