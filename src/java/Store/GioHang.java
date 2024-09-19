/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Store;
import java.util.ArrayList;
import java.sql.*;
/**
 *
 * @author user
 */
public class GioHang {
    private String anh;
    private String ten;
    private float gia;
    private int sl;
    private int kc;
    private int idsp;
    private int iddm;
    private String tenkc;
    private ArrayList<KichCo> kcl=new ArrayList<KichCo>();

    public GioHang() {
    }

    public String getAnh() {
        return anh;
    }

    public String getTen() {
        return ten;
    }

    public float getGia() {
        return gia;
    }

    public int getSl() {
        return sl;
    }

    public int getKc() {
        return kc;
    }

    public int getIddm() {
        return iddm;
    }

    public void setAnh(String anh) {
        this.anh = anh;
    }

    public void setTen(String ten) {
        this.ten = ten;
    }

    public void setGia(float gia) {
        this.gia = gia;
    }

    public void setSl(int sl) {
        if(sl==0){
            sl=1;
        }
        this.sl = sl;
    }

    public void setKc(int kc) {
        this.kc = kc;
    }

    public int getIdsp() {
        return idsp;
    }

    public void setIdsp(int idsp) {
        this.idsp = idsp;
    }

    public void setIddm(int iddm) {
        this.iddm = iddm;
    }
    
    public void setKcl(){
        try {
            Connect connect=new Connect();
            Connection conn=connect.getConn();
            String sql;
            if(this.iddm==1){
                sql="select * from kichco where id_kc between 8 and 13";
            }
            else if((this.iddm==2)||(this.iddm==3)){
                sql="select * from kichco where id_kc between 14 and 18";
            }
            else{
                sql="select * from kichco where id_kc between 1 and 7";
            }
            PreparedStatement pt=conn.prepareStatement(sql);
            ResultSet rs=pt.executeQuery();
            while(rs.next()){
                KichCo kichco=new KichCo(rs.getInt(1), rs.getString(2));
                if(rs.getInt(1)==this.kc){
                    tenkc=rs.getString(2);
                }
                this.kcl.add(kichco);
            }
            conn.close();
        } catch (Exception e) {
        }
    }

    public String getTenkc() {
        return tenkc;
    }

    public void setTenkc(String tenkc) {
        this.tenkc = tenkc;
    }

    public ArrayList<KichCo> getKcl() {
        return kcl;
    }
    
}
