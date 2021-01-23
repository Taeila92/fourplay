package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class AddrtDelSvc {
	public int addrDelete(String idx, String uid) {
		Connection conn = getConnection();
		MpgDao mpgDao = MpgDao.getInstance();
		mpgDao.setConnection(conn);
		int result = mpgDao.addrDelete(idx, uid);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
}
