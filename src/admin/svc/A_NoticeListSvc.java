package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class A_NoticeListSvc {
	public int getArticleCount(String where) {
		int rcnt = 0;	
		Connection conn = getConnection();
		A_NoticeDao anoticeDao = A_NoticeDao.getInstance();
		anoticeDao.setConnection(conn);
		rcnt = anoticeDao.getArticleCount(where);
		close(conn);

		return rcnt;
	}
	
	public ArrayList<NoticeInfo> getArticleList(String where, int cpage, int limit) {

		ArrayList<NoticeInfo> articleList = null;
		Connection conn = getConnection();
		A_NoticeDao anoticeDao = A_NoticeDao.getInstance();
		anoticeDao.setConnection(conn);
		articleList = anoticeDao.getArticleList(where, cpage, limit);
		close(conn);

		return articleList;
	}
}
