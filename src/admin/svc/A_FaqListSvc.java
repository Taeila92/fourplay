package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class A_FaqListSvc {
	public int getArticleCount(String where) {
		int rcnt = 0;	
		Connection conn = getConnection();
		A_FaqDao afaqDao = A_FaqDao.getInstance();
		afaqDao.setConnection(conn);
		rcnt = afaqDao.getArticleCount(where);
		close(conn);

		return rcnt;
	}
	
	public ArrayList<FaqInfo> getArticleList(String where, int cpage, int limit) {

		ArrayList<FaqInfo> articleList = null;
		Connection conn = getConnection();
		A_FaqDao afaqDao = A_FaqDao.getInstance();
		afaqDao.setConnection(conn);
		articleList = afaqDao.getArticleList(where, cpage, limit);
		close(conn);

		return articleList;
	}
}
