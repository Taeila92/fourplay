package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AddrtInProcSvc {
	public int addrInsert(AddrInfo addr, String uid) {
		Connection conn = getConnection();
		MpgDao mpgDao = MpgDao.getInstance();
		mpgDao.setConnection(conn);
		int result = mpgDao.addrInsert(addr, uid);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
}


