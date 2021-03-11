package admin.svc;

import static db.JdbcUtil.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class A_QAProcSvc {
	public int aqaInsert(QAInfo qaInfo) throws Exception {
		Connection conn = getConnection();
		A_QADao aqaDao = A_QADao.getInstance();
		aqaDao.setConnection(conn);
		int idx = aqaDao.aqaInsert(qaInfo);
		if (idx > 0) {
			commit(conn);	
		} else {
			rollback(conn);	
		}
		close(conn);
		return idx;
	}
	public boolean aqaUpdate(QAInfo qaInfo) throws Exception {
		boolean isSuccess = false;
		Connection conn = getConnection();
		A_QADao aqaDao = A_QADao.getInstance();
		aqaDao.setConnection(conn);

		int result = aqaDao.aqaUpdate(qaInfo);
		if (result > 0) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}

		close(conn);
		return isSuccess;
	}
	public boolean aqaDelete(QAInfo qaInfo) throws Exception {
		boolean isSuccess = false;
		Connection conn = getConnection();
		A_QADao aqaDao = A_QADao.getInstance();
		aqaDao.setConnection(conn);

		int result = aqaDao.aqaDelete(qaInfo);
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
