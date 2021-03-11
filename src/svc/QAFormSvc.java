package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class QAFormSvc {
	public QAInfo getArticleUp(int idx, String uid, String pwd) {
		QAInfo article = null;
		Connection conn = getConnection();
		QADao qaDao = QADao.getInstance();
		qaDao.setConnection(conn);

		article = qaDao.getArticleUp(idx, uid);

		close(conn);
		return article;
	}

}
