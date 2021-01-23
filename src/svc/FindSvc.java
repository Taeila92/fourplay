package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;


public class FindSvc {
	public MemberInfo getMemberId(String name, String email) {
		LoginDao loginDao = LoginDao.getInstance();
		Connection conn = getConnection();
		loginDao.setConnection(conn);
		MemberInfo memberId = loginDao.getMemberId(name, email);
		close(conn);

		return memberId;
	}
}
