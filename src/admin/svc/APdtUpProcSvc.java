package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class APdtUpProcSvc {
	public boolean pdtUpdate(PdtInfo pdt, String sizeOpt) {
		boolean isSuccess = false;
		Connection conn = getConnection();
		APdtDao aPdtDao = APdtDao.getInstance();
		aPdtDao.setConnection(conn);
		int result = aPdtDao.pdtUpdate(pdt, sizeOpt);
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
