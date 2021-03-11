package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;


public class FindSvc {
	public MemberInfo getMemberId(String name, String email) {
		FindDao findDao = FindDao.getInstance();
		Connection conn = getConnection();
		findDao.setConnection(conn);
		MemberInfo memberId = findDao.getMemberEId(name, email);
		close(conn);

		return memberId;
	}
}
