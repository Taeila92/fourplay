package admin.svc;

import static db.JdbcUtil.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class DupAIDSvc {
	public int chkDupAID(String aid) {
		DupAIDDao dupAIDDao = DupAIDDao.getInstance();
		Connection conn = getConnection();
		dupAIDDao.setConnection(conn);
		int chkPoint = dupAIDDao.chkDupAID(aid);
		close(conn);

		return chkPoint;
	}
}
