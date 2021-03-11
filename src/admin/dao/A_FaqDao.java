package admin.dao;

import static db.JdbcUtil.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;

public class A_FaqDao {
	private static A_FaqDao afaqDao;
	private Connection conn;
	private A_FaqDao() {}
	
	public static A_FaqDao getInstance() {
		if (afaqDao == null) {
			afaqDao = new A_FaqDao();	
		}
		return afaqDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int getArticleCount(String where) {
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		int result = 0;
		
		try {
			sql = "select count(*) from t_faq_list " +
					" where fq_status = 'a' " + where;
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

	public ArrayList<FaqInfo> getArticleList(String where, int cpage, int limit) {
	// 검색된 게시글 목록을 ArrayList형태로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<FaqInfo> articleList = new ArrayList<FaqInfo>();
		FaqInfo faqInfo = null;

		int snum = (cpage - 1) * limit;

		try {
			sql ="select * from t_faq_list where fq_status = 'a' " + 
					where + " order by fq_idx desc limit " + snum + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				faqInfo = new FaqInfo();
				faqInfo.setFq_idx(rs.getInt("fq_idx"));
				faqInfo.setFq_read(rs.getInt("fq_read"));
				faqInfo.setFq_writer(rs.getString("fq_writer"));
				faqInfo.setFq_title(rs.getString("fq_title"));
				faqInfo.setFq_content(rs.getString("fq_content"));
				faqInfo.setFq_date(rs.getString("fq_date"));

				articleList.add(faqInfo);
			}
		} catch(Exception e) {
			System.out.println("getArticleList() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return articleList;
	}
	
	
	public FaqInfo getArticle(int idx) {
	// 지정된 게시물의 데이터를 FreeInfo형 인스턴스로 리턴하는 메소드
		FaqInfo article = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "select * from t_faq_list where fq_idx = " + idx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				article = new FaqInfo();
				article.setFq_idx(rs.getInt("fq_idx"));
				article.setFq_read(rs.getInt("fq_read"));
				article.setFq_writer(rs.getString("fq_writer"));
				article.setFq_title(rs.getString("fq_title"));
				article.setFq_content(rs.getString("fq_content"));
				article.setFq_date(rs.getString("fq_date"));
				article.setFq_status(rs.getString("fq_status"));
			}
		} catch(Exception e) {
			System.out.println("getArticle() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return article;
	}

	public int afaqInsert(FaqInfo faqInfo) {
	// 게시글 등록 메소드
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		int idx = 1, result = 0;	
		String sql = null;

		try {
			System.out.println("dao");
			sql = "select max(fq_idx) + 1 from t_faq_list";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())	idx = rs.getInt(1);

			sql = "insert into t_faq_list (fq_idx, fq_writer, fq_title, fq_content, al_idx) values (?, ?, ?, ?, ?)";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, faqInfo.getFq_writer());
			pstmt.setString(3, faqInfo.getFq_title());
			pstmt.setString(4, faqInfo.getFq_content());
			pstmt.setInt(5, 1);

			result = pstmt.executeUpdate();

		} catch(Exception e) {
			System.out.println("afaqInsert() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(pstmt);
		}

		return result;
	}

	public int afaqUpdate(FaqInfo faqInfo) {
	 // 게시글 수정을 위한 메소드
	    PreparedStatement pstmt = null;
	    String sql = null;
	    int result = 0;      // 쿼리 실행 결과 개수를 저장할 변수

     try {
	       sql = "update t_faq_list set fq_title = ?, fq_content = ? where fq_idx = ?";
	       pstmt = conn.prepareStatement(sql);
	       pstmt.setString(1, faqInfo.getFq_title());
		   pstmt.setString(2, faqInfo.getFq_content());
		   pstmt.setInt(3, faqInfo.getFq_idx());
		   result = pstmt.executeUpdate();   // 게시글 수정
		  } catch(Exception e) {
		      System.out.println("afaqUpdate() 오류");
		      e.printStackTrace();
		   } finally {
		      close(pstmt);
		   }

		   return result;
	 }

	public int afaqDelete(int idx, FaqInfo faqInfo) {
	// 게시글 삭제를 위한 메소드
		Statement stmt = null;
		String sql = null;
		int result = 0;		

		try {
			sql = "delete from t_faq_list where fq_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);;

		} catch(Exception e) {
			System.out.println("afaqDelete() 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}

		return result;
	}

	public FaqInfo getArticleUp(int idx, String uid) {
	// 수정할 글에 대한 권한이 있을 경우 해당 데이터를 가져와 리턴할 메소드
		FaqInfo article = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			String where = " and fq_writer = '" + uid + "'";
			sql = "select * from t_faq_list where fq_idx = " + idx ;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				article = new FaqInfo();
				// 검색된 게시물의 정보를 저장할 FreeInfo형 인스턴스 article 생성
				article.setFq_idx(rs.getInt("fq_idx"));
				article.setFq_read(rs.getInt("fq_read"));
				article.setFq_writer(rs.getString("fq_writer"));
				article.setFq_title(rs.getString("fq_title"));
				article.setFq_content(rs.getString("fq_content"));
				article.setFq_date(rs.getString("fq_date"));
				// 받아온 레코드들로 article 인스턴스의 멤버 변수에 값을 넣음
			}
		} catch(Exception e) {
			System.out.println("getArticleUp() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return article;
	}
}
