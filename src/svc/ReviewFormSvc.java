package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ReviewFormSvc {
	public ReviewInfo getReview(int idx) {
		ReviewInfo review = new ReviewInfo(); 
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();
		reviewDao.setConnection(conn);
		review = reviewDao.getReview(idx);
		close(conn);
		return review;
	}
}
