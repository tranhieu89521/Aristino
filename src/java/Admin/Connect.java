/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Admin;
import java.sql.*;
import Store.ConnectInfo;
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
        } catch (SQLException e) {e.printStackTrace();
        }
        return max;
    }
    
    public String getName(String tencot){
        String name="";
        switch(tencot){
            case "tk":
                name="Tài khoản";
                break;
            case "mk":
                name="Mật khẩu";
                break;
            case "id_sp":
                name="Sản phẩm";
                break;
            case "anhct1":
                name="Ảnh chi tiết 1";
                break;
            case "anhct2":
                name="Ảnh chi tiết 2";
                break;
            case "anhct3":
                name="Ảnh chi tiết 3";
                break;
            case "anhct4":
                name="Ảnh chi tiết 4";
                break;
            case "anhct5":
                name="Ảnh chi tiết 5";
                break;
            case "id_tk":
                name="Tài khoản";
                break;
            case "hoten":
                name="Họ tên";
                break;
            case "email":
                name="Email";
                break;
            case "noidung":
                name="Nội dung";
                break;
            case "ngaybl":
                name="Ngày bình luận";
                break;
            case "id_kc":
                name="Kích cỡ";
                break;
            case "soluong":
                name="Số lượng";
                break;
            case "tonggia":
                name="Tổng giá";
                break;
            case "tendm":
                name="Tên danh mục";
                break;
            case "id_kh":
                name="Khách hàng";
                break;
            case "id_tr":
                name="Tình trạng";
                break;
            case "tongtien":
                name="Tổng tiền";
                break;
            case "ngaydat":
                name="Ngày đặt";
                break;
            case "ho":
                name="Họ";
                break;
            case "ten":
                name="Tên";
                break;
            case "sdt":
                name="Số điện thoại";
                break;
            case "diachi":
                name="Địa chỉ";
                break;
            case "kichco":
                name="kích cỡ";
                break;
            case "id_dm":
                name="Danh mục";
                break;
            case "tensp":
                name="Tên sản phẩm";
                break;
            case "anhmh":
                name="Ảnh minh họa";
                break;
            case "gia":
                name="Giá";
                break;
            case "sale":
                name="Sale";
                break;
            case "giasale":
                name="Giá sale";
                break;
            case "daban":
                name="Đã bán";
                break;
            case "mausac":
                name="Màu sắc";
                break;
            case "chitiet":
                name="Chi tiết";
                break;
            case "chatlieu":
                name="Chất liệu";
                break;
            case "ngaynhap":
                name="Ngày nhập";
                break;
            case "tentr":
                name="Tên tình trạng";
                break;
            case "id_dh":
                name="ID đơn hàng";
                break;
            case "banner":
                name="banner";
                break;
        }
        return name;
    }
    
    public ResultSet getF(String tencot){
        ResultSet rs=null;
        String sql="";
        switch (tencot) {
            case "id_dm":
               sql="select * from danhmuc";
               break;
            case "id_sp":
               sql="select id_sp,tensp from sanpham";
               break;
            case "id_tk":
               sql="select id_tk,tk from taikhoan";
               break;
            case "id_kc":
               sql="select id_kc,kichco from kichco";
               break;
            case "id_tr":
               sql="select id_tr,tentr from tinhtrangdh";
               break;
        }
        try {
         PreparedStatement pt=conn.prepareStatement(sql);
         rs=pt.executeQuery();
        } catch (Exception e) {e.printStackTrace();
        }
        return rs;
    }
    
    public int getR(String tencot,String tenbang,int id){
        String bang[][]={{"admin","id_ad",null,null},{"anhchitiet","id_ct","id_sp",null},{"banner","id_bn",null,null},{"binhluan","id_bl","id_tk","id_sp"},{"chitietdh","id_dh","id_sp","id_kc"}
        ,{"danhmuc","id_dm",null,null},{"donhang","id_dh","id_kh","id_tr"},{"khachhang","id_kh","id_tk",null},{"kichco","id_kc",null,null},{"sanpham","id_sp","id_dm",null}
        ,{"soluong","id_sl","id_sp","id_kc"},{"taikhoan","id_tk",null,null},{"tinhtrangdh","id_tr",null,null}};
        int k=0;
        try {
            for(int i=0;i<13;i++){
                int j1=2;
                if(i==4){
                    j1=1;
                }
                for(int j=j1;j<4;j++){
                    if(tencot.equals(bang[i][j])&&!tenbang.equals(bang[i][0])){
                        String sql;
                        if(i==4){
                            sql="select "+bang[i][1]+","+bang[i][2]+","+bang[i][3]+" from "+bang[i][0]+" where "+tencot+"="+id;
                        }
                        else{
                            sql="select "+bang[i][1]+" from "+bang[i][0]+" where "+tencot+"="+id;
                        } 
                        PreparedStatement pt=conn.prepareStatement(sql);
                        ResultSet rs=pt.executeQuery();
                        while (rs.next()) {  
                            if(i==4){
                                k+=deletect(bang[i][0], rs.getInt(1), bang[i][1],rs.getInt(2), rs.getInt(3));
                            }
                            else{
                                k+=getR(bang[i][1], bang[i][0], rs.getInt(1));
                            }      
                        }
                    }
                }
            }
            String sql="delete from "+tenbang+" where "+tencot+"="+id;
            PreparedStatement pt=conn.prepareStatement(sql);
            k+=pt.executeUpdate();
        } catch (SQLException e) {e.printStackTrace();
        }   
        return  k;
    }
    
    
    public int deletect(String tenbang,int id,String tencot,int idsp,int idkc){
        try {
            int tongtien=0;
            int tonggia=0;
            int sl=0;
            String sql="select tongtien from donhang where id_dh="+id;
            PreparedStatement pt=conn.prepareStatement(sql);
            ResultSet rs=pt.executeQuery();
            while (rs.next()) {                
                tongtien=rs.getInt(1);
            }
            String sql1="select tonggia from chitietdh where id_dh="+id+" and id_sp="+idsp+" and id_kc="+idkc;
            PreparedStatement pt1=conn.prepareStatement(sql1);
            ResultSet rs1=pt1.executeQuery();
            while (rs1.next()) {                
                tonggia=rs1.getInt(1);
            }
            String sql3="select soluong from chitietdh where id_dh="+id+" and id_sp="+idsp+" and id_kc="+idkc;
            PreparedStatement pt3=conn.prepareStatement(sql3);
            ResultSet rs3=pt3.executeQuery();
            while (rs3.next()) {                
                sl=rs3.getInt(1);
            }
            String sql2="delete from "+tenbang+" where "+tencot+"="+id+" and id_sp="+idsp+" and id_kc="+idkc;
            PreparedStatement pt2=conn.prepareStatement(sql2);
            int i=pt2.executeUpdate();
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
                pt=conn.prepareStatement(sql);pt.setInt(1, id);
                i=pt.executeUpdate();
                }
                else{
                sql="update donhang set tongtien=? where id_dh=?";
                pt=conn.prepareStatement(sql);pt.setInt(1, (tongtien-tonggia));pt.setInt(2, id);
                i=pt.executeUpdate();
                }
             }
            return i;
        } catch (Exception e) {e.printStackTrace();return 0;
        }     
    }
    
    public String[] search(String tenbang){
        String sql[]=new String[2];
        switch (tenbang) {
            case "anhchitiet":
               sql[0]="select a.id_ct,s.tensp,a.anhct1,a.anhct2,a.anhct3,a.anhct4,a.anhct5 from anhchitiet a inner join sanpham s on a.id_sp=s.id_sp";
               sql[1]="select count(a.id_ct) from anhchitiet a inner join sanpham s on a.id_sp=s.id_sp";
               break;
            case "binhluan":
               sql[0]="select b.id_bl,t.tk,s.tensp,b.hoten,b.email,b.noidung,b.ngaybl from ((binhluan b left join taikhoan t on b.id_tk=t.id_tk) inner join sanpham s on s.id_sp=b.id_sp)";
               sql[1]="select count(b.id_bl) from ((binhluan b left join taikhoan t on b.id_tk=t.id_tk) inner join sanpham s on s.id_sp=b.id_sp)";
               break;
            case "chitietdh":
               sql[0]="select c.id_dh,s.tensp,k.kichco,c.soluong,c.tonggia,c.id_sp,c.id_kc from ((chitietdh c inner join sanpham s on s.id_sp=c.id_sp) inner join kichco k on k.id_kc=c.id_kc)";
               sql[1]="select count(c.id_dh) from ((chitietdh c inner join sanpham s on s.id_sp=c.id_sp) inner join kichco k on k.id_kc=c.id_kc)";
               break;
            case "donhang":
               sql[0]="select d.id_dh,k.ho,k.ten,t.tentr,d.tongtien,d.ngaydat from((donhang d inner join khachhang k on d.id_kh=k.id_kh) inner join tinhtrangdh t on t.id_tr=d.id_tr)";
               sql[1]="select count(d.id_dh) from((donhang d inner join khachhang k on d.id_kh=k.id_kh) inner join tinhtrangdh t on t.id_tr=d.id_tr)";
               break;
            case "khachhang":
               sql[0]="select k.id_kh,t.tk,k.ho,k.ten,k.email,k.sdt,k.diachi from khachhang k left join taikhoan t on t.id_tk=k.id_tk";
               sql[1]="select count(k.id_kh) from khachhang k left join taikhoan t on t.id_tk=k.id_tk";
               break;
            case "sanpham":
               sql[0]="select s.id_sp,d.tendm,s.tensp,s.anhmh,s.gia,s.sale,s.giasale,s.daban,s.mausac,s.chitiet,s.chatlieu,s.ngaynhap from sanpham s inner join danhmuc d on s.id_dm=d.id_dm";
               sql[1]="select count(s.id_sp) from sanpham s inner join danhmuc d on s.id_dm=d.id_dm";
               break;
            case "soluong":
               sql[0]="select s.id_sl,sp.tensp,k.kichco,s.soluong from((soluong s inner join sanpham sp on sp.id_sp=s.id_sp) inner join kichco k on k.id_kc=s.id_kc)";
               sql[1]="select count(s.id_sl) from((soluong s inner join sanpham sp on sp.id_sp=s.id_sp) inner join kichco k on k.id_kc=s.id_kc)";
               break;
        }
        return sql;
    }
}
