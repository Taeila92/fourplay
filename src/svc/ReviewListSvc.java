package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ReviewListSvc {
	public int getArticleCount(String plid) {
		System.out.println("svc getArticleCount");
		int rCnt = 0;	
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();
		reviewDao.setConnection(conn);
		rCnt = reviewDao.getArticleCount(plid);
		close(conn);

		return rCnt;
	}
	
	public ArrayList<ReviewInfo> getArticleList(String plid, int rCpage, int rPsize) {
		System.out.println("svc getArticleList");
		ArrayList<ReviewInfo> articleList = null;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();
		reviewDao.setConnection(conn);
		articleList = reviewDao.getArticleList(plid, rCpage, rPsize);
		close(conn);

		return articleList;
	}
}
