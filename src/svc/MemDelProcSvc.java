package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemDelProcSvc {
	public boolean memDelete(String uid, String pwd) {
		boolean isSuccess = false;
		Connection conn = getConnection();
		MpgDao mpgDao = MpgDao.getInstance();
		mpgDao.setConnection(conn);
		int result = mpgDao.memDelete(uid, pwd);
		if (result > 0) {
			isSuccess = true;
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return isSuccess;
	}
}
