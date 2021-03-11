package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class QAProcSvc {
	public int qaInsert(QAInfo qaInfo) throws Exception {
		Connection conn = getConnection();
		QADao qaDao = QADao.getInstance();
		qaDao.setConnection(conn);
		int idx = qaDao.qaInsert(qaInfo);
		if (idx > 0) {
			commit(conn);	
		} else {
			rollback(conn);	
		}
		close(conn);
		return idx;
	}
	public boolean qaUpdate(QAInfo qaInfo) throws Exception {
		boolean isSuccess = false;
		Connection conn = getConnection();
		QADao qaDao = QADao.getInstance();
		qaDao.setConnection(conn);

		int result = qaDao.qaUpdate(qaInfo);
		if (result > 0) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}

		close(conn);
		return isSuccess;
	}
	public boolean qaDelete(QAInfo qaInfo) throws Exception {
		boolean isSuccess = false;
		Connection conn = getConnection();
		QADao qaDao = QADao.getInstance();
		qaDao.setConnection(conn);

		int result = qaDao.qaDelete(qaInfo);
		if (result > 0) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}

		close(conn);
		return isSuccess;
	}
}
