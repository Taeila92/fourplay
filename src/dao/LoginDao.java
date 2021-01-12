package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import vo.*;

public class LoginDao {
	private static LoginDao loginDao;
	private Connection conn;

	private LoginDao() {}

	public static LoginDao getInstance() {
		if (loginDao == null) {
			loginDao = new LoginDao();
		}
		return loginDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public MemberInfo getLoginMember(String uid, String pwd) {
		MemberInfo loginMember = null;	
		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_list " + 
				" where ml_status = 'a' and ml_id = '" + uid + 
				"' and ml_pwd = '" + pwd + "'";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 로그인 성공시
				loginMember = new MemberInfo();
				loginMember.setMlid(uid);
				loginMember.setMlpwd(pwd);
				loginMember.setMlname(rs.getString("ml_name"));
				loginMember.setMlgender(rs.getString("ml_gender"));
				loginMember.setMlbirth(rs.getString("ml_birth"));
				loginMember.setMlphone(rs.getString("ml_phone"));
				loginMember.setMlemail(rs.getString("ml_email"));
				loginMember.setMldate(rs.getString("ml_date"));
				loginMember.setMllast(rs.getString("ml_last"));
				loginMember.setMlstatus("a");
				loginMember.setMlpoint(rs.getInt("ml_point"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(rs);		close(stmt);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		return loginMember;
	}
}
