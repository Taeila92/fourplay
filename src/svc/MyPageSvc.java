package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MyPageSvc {
	public OrdListInfo getPayTotal(String uid) {
		MpgDao mpgDao = MpgDao.getInstance();
		Connection conn = getConnection();
		mpgDao.setConnection(conn);
		OrdListInfo total = mpgDao.getPayTotal(uid);
		close(conn);
		
		return total;
	}
}
