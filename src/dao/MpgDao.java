package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.ArrayList;

import vo.*;

public class MpgDao {
   private static MpgDao mpgDao;
   private Connection conn;

   private MpgDao() {}

   public static MpgDao getInstance() {
      if (mpgDao == null) {
         mpgDao = new MpgDao();
      }
      return mpgDao;
   }
   
   public void setConnection(Connection conn) {
      this.conn = conn;
   }
   
   public AddrInfo getBasicAddr(String uid) {
   // 회원 정보 수정시 주소를 뽑아오는 메소드
      AddrInfo addr = new AddrInfo();
      Statement stmt = null;
      ResultSet rs = null;
      try {
         String sql = "select * from t_member_addr where ma_basic = 'y' and ml_id = '" + uid + "' " ;
         
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         while (rs.next()) {
            addr.setMa_idx(rs.getInt("ma_idx"));
            addr.setMl_id(rs.getString("ml_id"));
            addr.setMa_zip(rs.getString("ma_zip"));
            addr.setMa_addr1(rs.getString("ma_addr1"));
            addr.setMa_addr2(rs.getString("ma_addr2"));
            addr.setMa_basic(rs.getString("ma_basic"));
         }
      } catch(Exception e) {
         System.out.println("getBasicAddr() 오류");      e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }
      return addr;
   }
   
   public ArrayList<AddrInfo> getAddrList(String uid) {
   // 회원 주소록 주소를 뽑아오는 메소드
      ArrayList<AddrInfo> addrList = new ArrayList<AddrInfo>();
      Statement stmt = null;
      ResultSet rs = null;
      
      try {
         String sql = "select * from t_member_addr where ml_id = '" + uid + "' " ;
         System.out.println(sql);
         
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         while (rs.next()) {
            AddrInfo addr = new AddrInfo();
            addr.setMa_idx(rs.getInt("ma_idx"));
            addr.setMl_id(rs.getString("ml_id"));
            addr.setMa_zip(rs.getString("ma_zip"));
            addr.setMa_addr1(rs.getString("ma_addr1"));
            addr.setMa_addr2(rs.getString("ma_addr2"));
            addr.setMa_basic(rs.getString("ma_basic"));

            addrList.add(addr);
         }
      } catch(Exception e) {
         System.out.println("getAddrList() 오류");      e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return addrList;
   }
   
   public int addrDelete(String idx, String uid) {
   // 회원이 선택한 주소(들)을 주소록에서 삭제하는 메소드
      int result = 0;
      Statement stmt = null;

      try {
         String[] arrIdx = idx.split(",");
         String where = "";
         for (int i = 0 ; i < arrIdx.length ; i++) {
            where += " or ma_idx = " + arrIdx[i];
         }
         where = " and (" + where.substring(4) + ")";
         String sql = "delete from t_member_addr where ml_id = '" + uid + "' " + where;
         stmt = conn.createStatement();
         result = stmt.executeUpdate(sql);
      } catch(Exception e) {
         System.out.println("addrDelete() 오류");      e.printStackTrace();
      } finally {
         close(stmt);
      }

      return result;
   }
   
   public int memberUpdate(MemberInfo loginMember) {
   // 회원 수정을 위한 메소드
      int result = 0;
      Statement stmt = null;
      String sql = null;
      
      try {
         sql = "update t_member_list set ml_pwd = '" + loginMember.getMlpwd() + "', ml_phone = '"+ loginMember.getMlphone()
            + "', ml_email = '"+ loginMember.getMlemail() +"' where ml_id = '"+ loginMember.getMlid() +"' ";
         stmt = conn.createStatement();
         result = stmt.executeUpdate(sql);
      } catch(Exception e) {
         System.out.println("memberUpdate() 오류");         e.printStackTrace();
      } finally {
         close(stmt);
      }
      return result;
   }
   
   public int memDelete(String uid, String pwd) {
   // 회원 삭제 처리를 위한 메소드
      int result = 0;
      Statement stmt = null;
      String sql = null;

      try {
         sql = "update t_member_list set ml_status = 'c' where ml_id = '" + uid + "' and ml_pwd = '" + pwd + "'";
         System.out.println(sql);
         stmt = conn.createStatement();
         result = stmt.executeUpdate(sql);
      } catch(Exception e) {
         System.out.println("pdtDelete() 오류");
         e.printStackTrace();
      } finally {
         close(stmt);
      }
      
      return result;
   }
   
   
   public ArrayList<MemberInfo> getPointList(String uid) {
   // 회원 포인트 내역을 뽑아오는 메소드
      ArrayList<MemberInfo> pointList = new ArrayList<MemberInfo>();
      Statement stmt = null;
      ResultSet rs = null;
      
      try {
         String sql = "select mp_date, mp_detail, mp_point, ml_id, if(mp_use = 'a', '+', '-') stat " + 
               " from t_member_point where ml_id = '" + uid + "'" ;
         System.out.println(sql);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         
         while (rs.next()) {
            MemberInfo point = new MemberInfo();
            point.setMpdate(rs.getString("mp_date"));
            point.setMpdetail(rs.getString("mp_detail"));
            point.setMpuse(rs.getString("stat"));
            point.setMppoint(rs.getInt("mp_point"));
            pointList.add(point);
         }
      } catch(Exception e) {
         System.out.println("getPointList() 오류");      e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return pointList;
   }
   public OrdListInfo getPayTotal(String uid) {
   // 총 구매내역을 뽑아오는 메소드
      OrdListInfo total = new OrdListInfo();
      Statement stmt = null;
      ResultSet rs = null;
      try {
         String sql = "select sum(ol_pay) total from t_order_list where ol_buyer = '" + uid + "' ";
         System.out.println(sql);
         
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         if (rs.next()) {
            total.setOl_pay(rs.getInt("total"));
            
         }
      } catch(Exception e) {
         System.out.println("getPayTotal() 오류");      e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }
      return total;
   }
}



   