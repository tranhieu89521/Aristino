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
public class Xulydn extends HttpServlet {

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
                boolean check=false;
                String user=request.getParameter("user");
                String pass=request.getParameter("pass");
                String sql="select id_tk,tk,mk from taikhoan where tk=? and mk=?";
                PreparedStatement pt=conn.prepareStatement(sql);
                pt.setString(1, user);pt.setString(2, pass);
                ResultSet rs=pt.executeQuery();
                while (rs.next()) {        
                    HttpSession session=request.getSession();
                    session.setAttribute("idtk", rs.getInt(1));
                    session.setAttribute("user", rs.getString(2));
                    check=true;
                }
                if(check){
                    String back=request.getParameter("back");
                    if(back.equals("index")){
                        RequestDispatcher rd=request.getRequestDispatcher("/index.jsp");
                        rd.forward(request, response);
                    }
                    if(back.equals("list")){
                        RequestDispatcher rd=request.getRequestDispatcher("/product-list.jsp");
                        rd.forward(request, response);
                    }  
                    if(back.equals("detail")){
                        RequestDispatcher rd=request.getRequestDispatcher("/product-detail.jsp");
                        rd.forward(request, response);
                    } 
                    if(back.equals("cart")){
                        RequestDispatcher rd=request.getRequestDispatcher("/cart.jsp");
                        rd.forward(request, response);
                    } 
                    if(back.equals("checkout")){
                        RequestDispatcher rd=request.getRequestDispatcher("/checkout.jsp");
                        rd.forward(request, response);
                    }
                    if(back.equals("contact")){
                        RequestDispatcher rd=request.getRequestDispatcher("/contact.jsp");
                        rd.forward(request, response);
                    }
                }
                else{
                    RequestDispatcher rd=request.getRequestDispatcher("/login.jsp");
                    rd.include(request, response);
                    out.print("<script>window.alert(\"Sai tên tài khoản hoặc mật khẩu\")</script>");
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
