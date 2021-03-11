package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FaqListSvc {
	public int getArticleCount(String where) {
		int rcnt = 0;	
		Connection conn = getConnection();
		FaqDao faqDao = FaqDao.getInstance();
		faqDao.setConnection(conn);
		rcnt = faqDao.getArticleCount(where);
		close(conn);

		return rcnt;
	}
	
	public ArrayList<FaqInfo> getArticleList(String where, int cpage, int limit) {

		ArrayList<FaqInfo> articleList = null;
		Connection conn = getConnection();
		FaqDao faqDao = FaqDao.getInstance();
		faqDao.setConnection(conn);
		articleList = faqDao.getArticleList(where, cpage, limit);
		close(conn);

		return articleList;
	}
}
