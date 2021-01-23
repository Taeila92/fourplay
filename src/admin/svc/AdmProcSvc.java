package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import dao.CartDao;
import vo.*;

public class AdmProcSvc {
	public boolean admInsert(AdminInfo adminMember) {
		System.out.println("AdmProcSvc admInsert");
		boolean isSuccess = false;
		Connection conn = getConnection();
		AdmDao admDao = AdmDao.getInstance();
		admDao.setConnection(conn);
		int result = admDao.admInsert(adminMember);
		if (result > 0) {
			isSuccess = true;
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return isSuccess;
	}
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
	public int admDelete(String aid) {
		int result = 0;
		Connection conn = getConnection();
		AdmDao admDao = AdmDao.getInstance();
		admDao.setConnection(conn);
		result = admDao.admDelete(aid);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public boolean chStatus(String idxs, String st){
		System.out.println("AdmProcSvc chStatus");
		boolean isSuccess = false; 
		int result = 0;
		Connection conn = getConnection();
		AdmDao admDao = AdmDao.getInstance();
		admDao.setConnection(conn);
		result = admDao.chStatus(idxs, st);
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
