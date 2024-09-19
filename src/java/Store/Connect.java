/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Store;
import java.sql.*;
/**
 *
 * @author user
 */
public class Connect {
    private ConnectInfo conni=new ConnectInfo();
    private Connection conn;
    public Connect(){
        try {
            conn=DriverManager.getConnection(conni.getUrl(),conni.getUser(),conni.getPass());
        } catch (SQLException e) {System.out.println(e);
        }
    }
    public Connection getConn(){
        return conn;
    }
    public int max(String ten,String id){
        int max=0;
        try {
            String sql="select max("+id+") from "+ten;
            PreparedStatement pt=conn.prepareStatement(sql);
            ResultSet rs=pt.executeQuery();
            while (rs.next()) {                
                max=rs.getInt(1);
            }
        } catch (Exception e) {e.printStackTrace();
        }
        return max;
    }
}
