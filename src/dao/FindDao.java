package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import vo.*;

public class FindDao {
	private static FindDao findDao;
	private Connection conn;

	private FindDao() {}

	public static FindDao getInstance() {
		if (findDao == null) {
			findDao = new FindDao();
		}
		return findDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public MemberInfo getMemberEId(String name, String email) {
	// 이메일로 아이디 찾기
		MemberInfo memberId = null;	
		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_list where ml_status = 'a' and ml_name = '" + name 
					+ "' and ml_email = '" + email + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	
				memberId = new MemberInfo();
				memberId.setMlid(rs.getString("ml_id"));
				memberId.setMlname(rs.getString("ml_name"));
				
			} 
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(rs);		close(stmt);
			} catch(Exception e) {
				System.out.println("getMemberEId() 오류"); e.printStackTrace();
			}
		}

		return memberId;
	}
	
	public MemberInfo getMemberPId(String name, String phone) {
	// 핸드폰 번호로 아이디 찾기
		MemberInfo memberId = null;	
		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_list where ml_status = 'a' and ml_name = '" + name 
					+ "' and ml_phone = '" + phone + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	
				memberId = new MemberInfo();
				memberId.setMlid(rs.getString("ml_id"));
				memberId.setMlname(rs.getString("ml_name"));
				
			} 
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(rs);		close(stmt);
			} catch(Exception e) {
				System.out.println("getMemberPId() 오류"); e.printStackTrace();
			}
		}

		return memberId;
	}
	
	public MemberInfo getMemberEPwd(String id, String name, String email) {
	// 이메일로 비밀번호 찾기
		MemberInfo memberPwd = null;	
		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_list where ml_status = 'a' and ml_id ='" + id + "' and ml_name = '" + name 
					+ "' and ml_email = '" + email + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	
				memberPwd = new MemberInfo();
				memberPwd.setMlemail(rs.getString("ml_email"));
				
			} 
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(rs);		close(stmt);
			} catch(Exception e) {
				System.out.println("getMemberEPwd() 오류"); e.printStackTrace();
			}
		}

		return memberPwd;
	}

	public MemberInfo getMemberPPwd(String id, String name, String phone) {
	// 핸드폰 번호로 비밀번호 찾기
		MemberInfo memberPwd = null;	
		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_list where ml_status = 'a' and ml_id = '" + id + "' and ml_name = '" + name 
					+ "' and ml_phone = '" + phone + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	
				memberPwd = new MemberInfo();
				memberPwd.setMlemail(rs.getString("ml_email"));
				
			} 
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(rs);		close(stmt);
			} catch(Exception e) {
				System.out.println("getMemberPPwd() 오류"); e.printStackTrace();
			}
		}

		return memberPwd;
		}

}
