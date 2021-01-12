package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class LoginSvc {
	public MemberInfo getLoginMember(String uid, String pwd) {
		LoginDao loginDao = LoginDao.getInstance();
		Connection conn = getConnection();
		loginDao.setConnection(conn);
		MemberInfo loginMember = loginDao.getLoginMember(uid, pwd);
		close(conn);

		return loginMember;
	}
	public AdminInfo getAdminMember(String uid, String pwd) {
		System.out.println("svc getAdminMember");
		LoginDao loginDao = LoginDao.getInstance();
		Connection conn = getConnection();
		loginDao.setConnection(conn);
		AdminInfo adminMember = loginDao.getAdminMember(uid, pwd);
		close(conn);

		return adminMember;
	}
}
