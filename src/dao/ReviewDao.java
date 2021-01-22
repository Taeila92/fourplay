package dao;

import static db.JdbcUtil.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;

public class ReviewDao {
   private static ReviewDao reviewDao;
   private Connection conn;
   private ReviewDao() {}
   public static ReviewDao getInstance() {
      if (reviewDao == null) {
         reviewDao = new ReviewDao();   
      }
      return reviewDao;
   }
   public void setConnection(Connection conn) {
      this.conn = conn;
   }
   
   public int getArticleCount(String plid) {
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;
      int result = 0;
      
      try {
         sql = "select count(*) from t_review_list where rl_status = 'a' and pl_id = '" + plid + "' ";
         System.out.println(sql);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         if (rs.next())   result = rs.getInt(1);
      } catch(Exception e) {
         System.out.println("getArticleCount() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }
      
      return result;
   }
   
   public ArrayList<ReviewInfo> getArticleList(String plid, int rCpage, int rPsize) {
   // 검색된 게시글 목록을 ArrayList형태로 리턴하는 메소드
      Statement stmt = null;
      ResultSet rs = null;
      String sql = null;
      ArrayList<ReviewInfo> articleList = new ArrayList<ReviewInfo>();
      ReviewInfo reviewInfo = null;

      int snum = (rCpage - 1) * rPsize;

      try {
         sql = "select * from t_review_list where rl_status = 'a' and pl_id = '" + plid + "' " +
         " order by rl_idx desc limit " + snum + ", " + rPsize;
         System.out.println(sql);
         stmt = conn.createStatement();
         rs = stmt.executeQuery(sql);
         while (rs.next()) {
            reviewInfo = new ReviewInfo();
            reviewInfo.setRl_idx(rs.getInt("rl_idx"));
            reviewInfo.setMl_id(rs.getString("ml_id"));
            reviewInfo.setPl_id(rs.getString("pl_id"));
            reviewInfo.setRl_title(rs.getString("rl_title"));
            reviewInfo.setRl_rate(rs.getInt("rl_rate"));
            reviewInfo.setRl_content(rs.getString("rl_content"));
            reviewInfo.setRl_img(rs.getString("rl_img"));
            reviewInfo.setRl_status(rs.getString("rl_status"));
            reviewInfo.setRl_date(rs.getString("rl_date"));

            articleList.add(reviewInfo);
         }
      } catch(Exception e) {
         System.out.println("getArticleList() 오류");
         e.printStackTrace();
      } finally {
         close(rs);   close(stmt);
      }

      return articleList;
   }
   
}