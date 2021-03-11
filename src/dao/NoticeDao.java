package dao;

import static db.JdbcUtil.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;

public class NoticeDao {
	private static NoticeDao noticeDao;
	private Connection conn;
	private NoticeDao() {}
	
	public static NoticeDao getInstance() {
		if (noticeDao == null) {
			noticeDao = new NoticeDao();	
		}
		return noticeDao;
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
			sql = "select count(*) from t_notice_list " +
				" where nl_status = 'a' " + where;
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

	public ArrayList<NoticeInfo> getArticleList(String where, int cpage, int limit) {
	// 검색된 게시글 목록을 ArrayList형태로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<NoticeInfo> articleList = new ArrayList<NoticeInfo>();
		NoticeInfo noticeInfo = null;

		int snum = (cpage - 1) * limit;

		try {
			sql = "select * from t_notice_list where nl_status = 'a' " + 
			where + " order by nl_idx desc limit " + snum + ", " + limit;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				noticeInfo = new NoticeInfo();
				noticeInfo.setNl_idx(rs.getInt("nl_idx"));
				noticeInfo.setNl_read(rs.getInt("nl_read"));
				noticeInfo.setNl_writer(rs.getString("nl_writer"));
				noticeInfo.setNl_title(rs.getString("nl_title"));
				noticeInfo.setNl_content(rs.getString("nl_content"));
				noticeInfo.setNl_date(rs.getString("nl_date"));

				articleList.add(noticeInfo);
			}
		} catch(Exception e) {
			System.out.println("getArticleList() 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return articleList;
	}
	
	
	public NoticeInfo getArticle(int idx) {
	// 지정된 게시물의 데이터를 FreeInfo형 인스턴스로 리턴하는 메소드
		NoticeInfo article = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "select * from t_notice_list where nl_idx = " + idx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				article = new NoticeInfo();
				article.setNl_idx(rs.getInt("nl_idx"));
				article.setNl_read(rs.getInt("nl_read"));
				article.setNl_writer(rs.getString("nl_writer"));
				article.setNl_title(rs.getString("nl_title"));
				article.setNl_content(rs.getString("nl_content"));
				article.setNl_date(rs.getString("nl_date"));
				article.setNl_status(rs.getString("nl_status"));
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
