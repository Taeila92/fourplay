package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class AdmProcSvc {
	public boolean admUpdate(AdminInfo adminMember) {
		System.out.println("AdmProcSvc admUpdate");
		boolean isSuccess = false;
		Connection conn = getConnection();
		AdmDao admDao = AdmDao.getInstance();
		admDao.setConnection(conn);
		int result = admDao.admUpdate(adminMember);
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
