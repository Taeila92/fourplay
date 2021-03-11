package dao;

import static db.JdbcUtil.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;

public class FaqDao {
	private static FaqDao faqDao;
	private Connection conn;
	private FaqDao() {}
	
	public static FaqDao getInstance() {
		if (faqDao == null) {
			faqDao = new FaqDao();	
		}
		return faqDao;
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
			sql = "select count(*) from t_faq_list " + where;
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
			sql ="select * from t_faq_list  " + 
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
			}
		} catch(Exception e) {
			System.out.println("getArticle() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return article;
	}
}
