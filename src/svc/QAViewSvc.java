package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class QAViewSvc {
	
	public QAInfo getArticle(int idx) {
		
		QAInfo article = null;	// 리턴할 게시물 정보를 담을 인스턴스 선언
		Connection conn = getConnection();
		QADao qaDao = QADao.getInstance();
		qaDao.setConnection(conn);

		article = qaDao.getArticle(idx);	// 보여줄 게시글 받기

		close(conn);
		return article;
	}
}
