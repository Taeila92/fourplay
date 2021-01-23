package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class AdmListSvc {
	public ArrayList<AdminInfo> getAdmList(String where, String orderby, int cpage, int psize) {
		ArrayList<AdminInfo> admList = new ArrayList<AdminInfo>();
		Connection conn = getConnection();
		AdmDao admDao = AdmDao.getInstance();
		admDao.setConnection(conn);
		admList = admDao.getAdmList(where, orderby, cpage, psize);
		System.out.println("dao getAdmList finished");
		close(conn);
		return admList;
	}
	public int getAdmCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		AdmDao admDao = AdmDao.getInstance();
		admDao.setConnection(conn);
		rcnt = admDao.getAdmCount(where);
		System.out.println("dao getAdmCount finished");
		close(conn);
		return rcnt;
	}
}
