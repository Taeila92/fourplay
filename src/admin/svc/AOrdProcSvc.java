package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import dao.CartDao;
import vo.*;

public class AOrdProcSvc {
	public boolean chStatus(String idxs, String st){
		System.out.println("AOrdProcSvc chStatus");
		boolean isSuccess = false; 
		int result = 0;
		Connection conn = getConnection();
		AOrdDao aOrdDao = AOrdDao.getInstance();
		aOrdDao.setConnection(conn);
		result = aOrdDao.chStatus(idxs, st);
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
