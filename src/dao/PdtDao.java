package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import vo.CataBigInfo;
import vo.CataSmallInfo;
import vo.PdtInfo;

public class PdtDao {
   private static PdtDao pdtDao;
   private Connection conn;

   private PdtDao() {}
   
   public static PdtDao getInstance() {
      if (pdtDao == null) {
         pdtDao = new PdtDao();
      }
      return pdtDao;
   }   
   public void setConnection(Connection conn) {
      this.conn = conn;
   }
   
   public ArrayList<CataBigInfo> getCataBigList() {
   // DB에서 대분류 목록을 받아 리턴하는 메소드
      ArrayList<CataBigInfo> cataBigList = new ArrayList<CataBigInfo>();
      CataBigInfo bigInfo = null;
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;
      
      try {
         sql = "select * from t_cata_big";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         while (rs.next()) {
            bigInfo = new CataBigInfo();
            // cataBigList에 담을 CataBigInfo형 인스턴스 생성

            bigInfo.setCb_idx(rs.getInt("cb_idx"));
            bigInfo.setCb_name(rs.getString("cb_name"));
            bigInfo.setCb_date(rs.getString("cb_date"));

            cataBigList.add(bigInfo);
            // 리턴할 ArrayList에 생성한 CataBigInfo형 인스턴스 저장
         }
      } catch(Exception e) {
         System.out.println("getCataBigList() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return cataBigList;
   }

   public ArrayList<CataSmallInfo> getCataSmallList() {
   // DB에서 소분류 목록을 받아 리턴하는 메소드
      ArrayList<CataSmallInfo> cataSmallList = new ArrayList<CataSmallInfo>();
      CataSmallInfo smallInfo = null;
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;
      
      try {
         sql = "select * from t_cata_small order by cb_idx, cs_idx";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         while (rs.next()) {
            smallInfo = new CataSmallInfo();
            // cataBigList에 담을 CataBigInfo형 인스턴스 생성

            smallInfo.setCs_idx(rs.getInt("cs_idx"));
            smallInfo.setCb_idx(rs.getInt("cb_idx"));
            smallInfo.setCs_name(rs.getString("cs_name"));
            smallInfo.setCs_date(rs.getString("cs_date"));

            cataSmallList.add(smallInfo);
            // 리턴할 ArrayList에 생성한 CataSmallInfo형 인스턴스 저장
         }
      } catch(Exception e) {
         System.out.println("getCataSmallList() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return cataSmallList;
   }

   public int getPdtCount(String where) {
   // 조건을 받아와 조건에 맞는 상품들의 총 개수를 리턴하는 메소드
      int rcnt = 0;
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;

      try {
         sql = "select count(*) from t_product_list a, t_cata_big b, t_cata_small c " + 
            " where a.cs_idx = c.cs_idx and b.cb_idx = c.cb_idx " + where;
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         if (rs.next())   rcnt = rs.getInt(1);
      } catch(Exception e) {
         System.out.println("getPdtCount() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return rcnt;
   }


   public ArrayList<PdtInfo> getPdtList(String where, String orderby, int cpage, int psize) {
   // 검색조건과 정렬조건을 받아와 조건에 맞는 상품들을 정렬하여 그 목록을 ArrayList<PdtInfo>형으로 리턴하는 메소드
      ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
      // 상품 목록을 저장할 ArrayList객체로 PdtInfo형 인스턴스만 저장함
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;
      PdtInfo pdtInfo = null;      // 하나의 상품정보를 저장한 후 pdtList에 저장될 인스턴스
      int snum = (cpage - 1) * psize;      // 쿼리의 limit 명령에서 데이터를 가져올 시작 인덱스 번호

      try {
         sql = "select  a.*, b.cb_name, c.cs_name, d.ps_salecnt, d.ps_stock " + 
               " from t_product_list a,  t_cata_big b, t_cata_small c, t_product_size d " + 
               " where a.cs_idx = c.cs_idx and b.cb_idx = c.cb_idx and d.pl_id = a.pl_id " +
               where + " group by a.pl_id " + orderby +" limit " + snum + ", " + psize;

         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         while (rs.next()) {
            pdtInfo = new PdtInfo();
            pdtInfo.setPl_id(rs.getString("pl_id"));
            pdtInfo.setCs_idx(rs.getInt("cs_idx"));
            pdtInfo.setPl_name(rs.getString("pl_name"));
            pdtInfo.setPl_price(rs.getInt("pl_price"));
            pdtInfo.setPl_cost(rs.getInt("pl_cost"));
            pdtInfo.setPl_discount(rs.getInt("pl_discount"));
            pdtInfo.setPl_opt(rs.getString("pl_opt"));
            pdtInfo.setPl_img1(rs.getString("pl_img1"));
            pdtInfo.setPl_img2(rs.getString("pl_img2"));
            pdtInfo.setPl_img3(rs.getString("pl_img3"));
            pdtInfo.setPl_desc(rs.getString("pl_desc"));
            pdtInfo.setPl_review(rs.getInt("pl_review"));
            pdtInfo.setPl_view(rs.getString("pl_view"));
            pdtInfo.setPl_date(rs.getString("pl_date"));
            pdtInfo.setPs_stock(rs.getInt("ps_stock"));
            pdtInfo.setAl_idx(rs.getInt("al_idx"));
            pdtList.add(pdtInfo);
         }
      } catch(Exception e) {
         System.out.println("getPdtList() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return pdtList;
   }
   public ArrayList<PdtInfo> getBestPdtList(String scata) {
   // 검색조건과 정렬조건을 받아와 조건에 맞는 상품들을 정렬하여 그 목록을 ArrayList<PdtInfo>형으로 리턴하는 메소드
      ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
      // 상품 목록을 저장할 ArrayList객체로 PdtInfo형 인스턴스만 저장함
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;
      PdtInfo pdtInfo = null;      // 하나의 상품정보를 저장한 후 pdtList에 저장될 인스턴스

      try {
         sql = "select a.*, b.cb_name, c.cs_name , d.ps_salecnt, d.ps_stock " + 
               " from t_product_list a, t_cata_big b, t_cata_small c, t_product_size d " + 
               " where a.cs_idx = c.cs_idx and b.cb_idx = c.cb_idx and a.pl_view = 'y' and a.cs_idx = '" +
               scata +"' order by d.ps_salecnt desc limit 0,3";
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         while (rs.next()) {
            pdtInfo = new PdtInfo();
            pdtInfo.setPl_id(rs.getString("pl_id"));
            pdtInfo.setCs_idx(rs.getInt("cs_idx"));
            pdtInfo.setPl_name(rs.getString("pl_name"));
            pdtInfo.setPl_price(rs.getInt("pl_price"));
            pdtInfo.setPl_cost(rs.getInt("pl_cost"));
            pdtInfo.setPl_discount(rs.getInt("pl_discount"));
            pdtInfo.setPl_opt(rs.getString("pl_opt"));
            pdtInfo.setPl_img1(rs.getString("pl_img1"));
            pdtInfo.setPl_img2(rs.getString("pl_img2"));
            pdtInfo.setPl_img3(rs.getString("pl_img3"));
            pdtInfo.setPl_desc(rs.getString("pl_desc"));
            pdtInfo.setPs_stock(rs.getInt("ps_stock"));
            pdtInfo.setPs_salecnt(rs.getInt("ps_salecnt"));
            pdtInfo.setPl_review(rs.getInt("pl_review"));
            pdtInfo.setPl_view(rs.getString("pl_view"));
            pdtInfo.setPl_date(rs.getString("pl_date"));
            pdtInfo.setAl_idx(rs.getInt("al_idx"));
            pdtList.add(pdtInfo);
         }
      } catch(Exception e) {
         System.out.println("getPdtList() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return pdtList;
   }
   
   public ArrayList<PdtInfo> getSearchPdtList(String keyword) {
      // 검색조건과 정렬조건을 받아와 조건에 맞는 상품들을 정렬하여 그 목록을 ArrayList<PdtInfo>형으로 리턴하는 메소드
         ArrayList<PdtInfo> searchList = new ArrayList<PdtInfo>();
         // 상품 목록을 저장할 ArrayList객체로 PdtInfo형 인스턴스만 저장함
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         String sql = null;
         PdtInfo pdtInfo = null;      // 하나의 상품정보를 저장한 후 pdtList에 저장될 인스턴스

         try {
            if (keyword != null) {
            sql = "select a.*, b.cb_name, c.cs_name , d.ps_salecnt, d.ps_stock " + 
                  " from t_product_list a, t_cata_big b, t_cata_small c, t_product_size d " + 
                  " where a.pl_name like ? or b.cb_name like ? or c.cs_name ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
                pstmt.setString(2, "%" + keyword + "%");
                pstmt.setString(3, "%" + keyword + "%");
            }
            rs = pstmt.executeQuery(sql);
            while (rs.next()) {
               pdtInfo = new PdtInfo();
               pdtInfo.setPl_id(rs.getString("pl_id"));
               pdtInfo.setCs_idx(rs.getInt("cs_idx"));
               pdtInfo.setPl_name(rs.getString("pl_name"));
               pdtInfo.setPl_price(rs.getInt("pl_price"));
               pdtInfo.setPl_cost(rs.getInt("pl_cost"));
               pdtInfo.setPl_discount(rs.getInt("pl_discount"));
               pdtInfo.setPl_opt(rs.getString("pl_opt"));
               pdtInfo.setPl_img1(rs.getString("pl_img1"));
               pdtInfo.setPl_img2(rs.getString("pl_img2"));
               pdtInfo.setPl_img3(rs.getString("pl_img3"));
               pdtInfo.setPl_desc(rs.getString("pl_desc"));
               pdtInfo.setPs_stock(rs.getInt("ps_stock"));
               pdtInfo.setPs_salecnt(rs.getInt("ps_salecnt"));
               pdtInfo.setPl_review(rs.getInt("pl_review"));
               pdtInfo.setPl_view(rs.getString("pl_view"));
               pdtInfo.setPl_date(rs.getString("pl_date"));
               pdtInfo.setAl_idx(rs.getInt("al_idx"));
               
               searchList.add(pdtInfo);
            }
         } catch(Exception e) {
            System.out.println("getPdtList() 오류");
            e.printStackTrace();
         } finally {
            close(rs);   close(pstmt);
         }

         return searchList;   
   }
   
   public PdtInfo getPdtInfo(String id) {
   // 지정된 id에 해당하는 하나의 상품정보를 PdtInfo형 인스턴스로 리턴하는 메소드
      PdtInfo pdtInfo = null;
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;

      try {
         int saleCnt = 0;
         stmt = conn.createStatement();
         sql = "select count(*) from t_order_detail where pl_id = '" + id + "'";
         // 지정된 상품의 판매량을 구하기 위한 쿼리
         rs = stmt.executeQuery(sql);
         if (rs.next())   saleCnt = rs.getInt(1);

         sql = "select a.*, b.cb_name, c.cs_name, d.ps_stock, d.ps_salecnt" +
               " from t_product_list a, t_cata_big b, t_cata_small c, t_product_size d " +
               " where a.cs_idx = c.cs_idx and b.cb_idx = c.cb_idx and a.pl_id = d.pl_id and a.pl_id = '" + id +
               "' group by a.pl_id ";
         rs = stmt.executeQuery(sql);
         if (rs.next()) {
            pdtInfo = new PdtInfo();
            pdtInfo.setPl_id(rs.getString("pl_id"));
            pdtInfo.setCs_idx(rs.getInt("cs_idx"));
            pdtInfo.setPl_name(rs.getString("pl_name"));
            pdtInfo.setPl_price(rs.getInt("pl_price"));
            pdtInfo.setPl_cost(rs.getInt("pl_cost"));
            pdtInfo.setPl_discount(rs.getInt("pl_discount"));
            pdtInfo.setPl_opt(rs.getString("pl_opt"));
            pdtInfo.setPl_img1(rs.getString("pl_img1"));
            pdtInfo.setPl_img2(rs.getString("pl_img2"));
            pdtInfo.setPl_img3(rs.getString("pl_img3"));
            pdtInfo.setPl_desc(rs.getString("pl_desc"));
            pdtInfo.setPs_stock(rs.getInt("ps_stock"));
            pdtInfo.setPs_salecnt(rs.getInt("ps_salecnt"));
            pdtInfo.setPl_review(rs.getInt("pl_review"));
            pdtInfo.setPl_view(rs.getString("pl_view"));
            pdtInfo.setPl_date(rs.getString("pl_date"));
            pdtInfo.setAl_idx(rs.getInt("al_idx"));
         }
      } catch(Exception e) {
         System.out.println("getPdtInfo() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return pdtInfo;
   }
}