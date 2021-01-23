package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ReviewProcSvc {
	public boolean reviewInsert(ReviewInfo review, String olid) {
		System.out.println("ReviewProcSvc reviewInsert");
		boolean isSuccess = false;
		int finalResult = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();
		reviewDao.setConnection(conn);
		finalResult = reviewDao.reviewInsert(review, olid);
		System.out.println(finalResult);
		if (finalResult == 1 || finalResult == 2) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);
		return isSuccess;
	}
	
	public boolean reviewUpdate(ReviewInfo review, int idx) {
		System.out.println("ReviewProcSvc reviewUpdate");
		boolean isSuccess = false;
		int result = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();
		reviewDao.setConnection(conn);
		result = reviewDao.reviewUpdate(review, idx);
		System.out.println(result);
		if (result >0) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);
		return isSuccess;
	}
	
	public boolean reviewDel(int idx) {
		System.out.println("ReviewProcSvc reviewDel");
		boolean isSuccess = false;
		int result = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();
		reviewDao.setConnection(conn);
		result = reviewDao.reviewDel(idx);
		System.out.println(result);
		if (result >0) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}
		close(conn);
		return isSuccess;
	}
}
