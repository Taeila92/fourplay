package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class A_QAListSvc {
	public int getArticleCount(String where) {
		int rcnt = 0;	
		Connection conn = getConnection();
		A_QADao aqaDao = A_QADao.getInstance();
		aqaDao.setConnection(conn);
		rcnt = aqaDao.getArticleCount(where);
		close(conn);

		return rcnt;
	}
	
	public ArrayList<QAInfo> getArticleList(String where, int cpage, int limit) {
		ArrayList<QAInfo> articleList = null;
		Connection conn = getConnection();
		A_QADao aqaDao = A_QADao.getInstance();
		aqaDao.setConnection(conn);
		articleList = aqaDao.getArticleList(where, cpage, limit);
		close(conn);

		return articleList;
	}
}
