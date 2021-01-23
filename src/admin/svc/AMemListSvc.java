package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class AMemListSvc {
	public ArrayList<MemberInfo> getMemberList(String where, String orderby, int cpage, int psize) {
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		Connection conn = getConnection();
		AMemDao aMemDao = AMemDao.getInstance();
		aMemDao.setConnection(conn);
		memberList = aMemDao.getMemberList(where, orderby, cpage, psize);
		close(conn);
		return memberList;
	}
	public int getMemCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		AMemDao aMemDao = AMemDao.getInstance();
		aMemDao.setConnection(conn);
		rcnt = aMemDao.getMemCount(where);
		close(conn);
		return rcnt;
	}
}

