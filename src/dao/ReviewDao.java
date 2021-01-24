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
	// 해당 상품의 리뷰 개수를 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		int result = 0;
		
		try {
			sql = "select count(*) from t_review_list where rl_status = 'a' and pl_id = '" + plid + "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	result = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getArticleCount() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return result;
	}
	
	public ArrayList<ReviewInfo> getArticleList(String plid, int rCpage, int rPsize) {
	// 해당 상품의 리뷰 목록을 ArrayList형태로 리턴하는 메소드
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
			close(rs);	close(stmt);
		}

		return articleList;
	}
	
	public int reviewInsert(ReviewInfo review, String olid) {
		System.out.println("dao reviewInsert");
		int cResult = 0, sResult = 0, rResult = 0,last = 0, finalResult = 0;
		Statement stmt = null, stmt2 = null, stmt3 = null, stmt4 = null;
		CallableStatement cs = null;
		ResultSet rs = null, rs2 = null;
		String sql = null;
		
		try {
			sql ="{call sp_rl_insert(?, ?, ?, ?, ?, ?, ?)}";
			System.out.println(sql);
			cs = conn.prepareCall(sql);
			cs.setString(1, review.getMl_id());			cs.setString(2, review.getPl_id());
			cs.setInt(3, review.getOdidx());			cs.setString(4, review.getRl_title());
			cs.setInt(5, review.getRl_rate());			cs.setString(6, review.getRl_content());
			cs.setString(7, review.getRl_img());
			cResult = cs.executeUpdate();
			System.out.println(cResult);
			if(cResult > 0) {
				sql = "update t_order_detail set od_status = 'k' where od_idx = '" + review.getOdidx() + "' ";
				System.out.println(sql);
				stmt = conn.createStatement();
				sResult = stmt.executeUpdate(sql);
				sql = "update t_product_list set pl_review = pl_review + 1 where pl_id = '" + review.getPl_id() + "' ";
				System.out.println(sql);
				stmt = conn.createStatement();
				rResult = stmt.executeUpdate(sql);
			}
			if(sResult > 0 && rResult > 0) {
				int a = -1, b = -2;
				sql = "select count(od_idx) from t_order_detail where ol_id = '" + olid + "' ";
				System.out.println(sql);
				stmt2 = conn.createStatement();
				rs = stmt2.executeQuery(sql);
				rs.next();
					a = rs.getInt(1);	// 한 주문에 속한 디테일 개수
					System.out.println("a : " + a);
				
				sql = "select count(od_idx) from t_order_detail where ol_id = '" + olid + "' and od_status = 'k' ";
				System.out.println(sql);
				stmt3 = conn.createStatement();
				rs2 = stmt3.executeQuery(sql);
				rs2.next();
				b = rs2.getInt(1);	// 디테일 중 구매후기 작성된 개수
				
				System.out.println("b : " + b);
				
				if(a == b) {	// 모든 상품들에 대한 후기를 작성했으면
					sql = "update t_order_list set ol_status = 'k' where ol_id = '"+ olid + "' ";
					System.out.println(sql);
					stmt4 = conn.createStatement();
					last = stmt4.executeUpdate(sql);
					System.out.println("last: " +last);
					if(last > 0)	finalResult = 1;
				} else {	// 아직 후기를 작성하지 않은 상품이 있으면  
					finalResult = 2;
				}
				System.out.println(finalResult);
			}
			
		} catch(Exception e) {
			System.out.println("reviewInsert() 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(cs); close(stmt);  close(stmt2); close(stmt3); close(stmt4);
		}

		return finalResult;
	}
	
	public ReviewInfo getReview(int idx) { // 어느 한 리뷰글을 보여주는 메소드
		ReviewInfo review = new ReviewInfo(); 
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "select * from t_review_list where rl_status = 'a' and rl_idx =" +idx;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	{
				review.setMl_id(rs.getString("ml_id"));
				review.setPl_id(rs.getString("pl_id"));
				review.setOdidx(rs.getInt("od_idx"));
				review.setRl_title(rs.getString("rl_title"));
				review.setRl_rate(rs.getInt("rl_rate"));
				review.setRl_content(rs.getString("rl_content"));
				review.setRl_img(rs.getString("rl_img"));
				review.setRl_date(rs.getString("rl_date"));
				review.setRl_status(rs.getString("rl_status"));
			}
		} catch(Exception e) {
			System.out.println("getReview() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return review;
	}
	public int reviewUpdate(ReviewInfo review, int idx) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_review_list set rl_title = '"+ review.getRl_title()+"', rl_rate = "+ review.getRl_rate() 
				+", rl_content = '"+ review.getRl_content() +"', rl_img = '"+ review.getRl_img() +"'"
				+ " where rl_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			System.out.println("reviewUpdate 결과: "+result);
			
		}catch(Exception e) {
			System.out.println("reviewUpdate() 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
	public int reviewDel(int idx) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_review_list set rl_status = 'b' where rl_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			System.out.println("reviewDel 결과: "+result);
			
		}catch(Exception e) {
			System.out.println("reviewDel() 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
}
