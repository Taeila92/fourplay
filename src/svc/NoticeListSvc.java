package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class NoticeListSvc {
	public int getArticleCount(String where) {
		int rcnt = 0;	
		Connection conn = getConnection();
		NoticeDao noticeDao = NoticeDao.getInstance();
		noticeDao.setConnection(conn);
		rcnt = noticeDao.getArticleCount(where);
		close(conn);

		return rcnt;
	}
	
	public ArrayList<NoticeInfo> getArticleList(String where, int cpage, int limit) {

		ArrayList<NoticeInfo> articleList = null;
		Connection conn = getConnection();
		NoticeDao noticeDao = NoticeDao.getInstance();
		noticeDao.setConnection(conn);
		articleList = noticeDao.getArticleList(where, cpage, limit);
		close(conn);

		return articleList;
	}
}
