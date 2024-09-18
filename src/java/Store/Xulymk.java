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
public class Xulymk extends HttpServlet {

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
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connect connect=new Connect();
                Connection conn=connect.getConn();
                boolean check=false;
                String cpass=request.getParameter("cpass");
                String sql="select mk from taikhoan where id_tk=?";
                PreparedStatement pt=conn.prepareStatement(sql);pt.setInt(1, (int)session.getAttribute("idtk"));
                ResultSet rs=pt.executeQuery();
                while (rs.next()) {                    
                    if(cpass.equals(rs.getString(1))){
                        check=true;
                    }
                }
                if(check){
                    String pass=request.getParameter("pass");
                    sql="update taikhoan set mk=? where id_tk=?";
                    pt=conn.prepareStatement(sql);pt.setString(1, pass);pt.setInt(2, (int)session.getAttribute("idtk"));
                    int i=pt.executeUpdate();
                    if(i>0){
                        RequestDispatcher rd=request.getRequestDispatcher("/my-account.jsp");
                        rd.include(request, response);
                        out.print("<script>window.alert(\"Đổi mật khẩu thành công\")</script>");
                    }
                }
                else{
                    RequestDispatcher rd=request.getRequestDispatcher("/my-account.jsp");
                    rd.include(request, response);
                    out.print("<script>window.alert(\"Sai mật khẩu\")</script>");
                }
                conn.close();
            } catch (Exception e) {
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
