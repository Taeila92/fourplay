package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FindPwdProcSvc {
	public MemberInfo getMemberEPwd(String id, String name, String email) {
		FindDao findDao = FindDao.getInstance();
		Connection conn = getConnection();
		findDao.setConnection(conn);
		MemberInfo memberPwd = findDao.getMemberEPwd(id, name, email);
		close(conn);

		return memberPwd;
	}
	
	public MemberInfo getMemberPPwd(String id, String name, String phone) {
		FindDao findDao = FindDao.getInstance();
		Connection conn = getConnection();
		findDao.setConnection(conn);
		MemberInfo memberPwd = findDao.getMemberPPwd(id, name, phone);
		close(conn);

		return memberPwd;
	}

}
