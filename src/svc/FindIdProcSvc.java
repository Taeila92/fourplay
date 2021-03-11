package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;


public class FindIdProcSvc {
	public MemberInfo getMemberEId(String name, String email) {
		FindDao findDao = FindDao.getInstance();
		Connection conn = getConnection();
		findDao.setConnection(conn);
		MemberInfo memberId = findDao.getMemberEId(name, email);
		close(conn);

		return memberId;
	}
	
	public MemberInfo getMemberPId(String name, String phone) {
		FindDao findDao = FindDao.getInstance();
		Connection conn = getConnection();
		findDao.setConnection(conn);
		MemberInfo memberId = findDao.getMemberPId(name, phone);
		close(conn);

		return memberId;
	}

}
