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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
/**
 *
 * @author user
 */
public class Xulybl extends HttpServlet {

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
             LocalDate dt = LocalDate.now();
             DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd");
             String s=dt.format(myFormatObj);
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connect connect=new Connect();
                Connection conn=connect.getConn();
                int idsp=Integer.parseInt(request.getParameter("idsp"));
                String hoten="";
                String mail="";
                String noidung=request.getParameter("noidung");
                String sql;
                PreparedStatement pt;
                int i;
                if(session.getAttribute("idtk")==null){
                    hoten=request.getParameter("hoten");
                    mail=request.getParameter("mail");
                    sql="insert into binhluan(hoten,email,noidung,ngaybl,id_sp) values(?,?,?,?,?)";
                    pt=conn.prepareStatement(sql);pt.setString(1, hoten);pt.setString(2, mail);pt.setString(3, noidung);pt.setString(4, s);pt.setInt(5, idsp);
                    i=pt.executeUpdate(); 
                }
                else{
                    ResultSet rs;
                    sql="select ho,ten,email from khachhang where id_tk=?";
                    pt=conn.prepareStatement(sql);pt.setInt(1, (int)session.getAttribute("idtk"));
                    rs=pt.executeQuery();
                    while (rs.next()) {                        
                        hoten=rs.getString(1)+" "+rs.getString(2);
                        mail=rs.getString(3);
                    }
                    sql="insert into binhluan(id_tk,hoten,email,noidung,ngaybl,id_sp) values("+(int)session.getAttribute("idtk")+",?,?,?,?,?)";
                    pt=conn.prepareStatement(sql);pt.setString(1, hoten);pt.setString(2, mail);pt.setString(3, noidung);pt.setString(4, s);pt.setInt(5, idsp);
                    i=pt.executeUpdate();   
                }
               if(i>0){
                    RequestDispatcher rd=request.getRequestDispatcher("/product-detail.jsp");
                    rd.forward(request, response);
                }
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
