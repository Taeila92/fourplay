package admin.dao;

import static db.JdbcUtil.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;

public class AMemDao {
	private static AMemDao aMemDao;
	private Connection conn;
	private AMemDao() {}
	public static AMemDao getInstance() {
		if (aMemDao == null) {
			aMemDao = new AMemDao();
		}
		return aMemDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getMemCount(String where) {	
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			String sql = "select count(*) from t_member_list ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getMemCount() ¿À·ù");	e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return rcnt;
	}
	
	public ArrayList<MemberInfo> getMemberList(String where, String orderby, int cpage, int psize) {
		System.out.println("dao getMemberList");
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		MemberInfo memberInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		int snum = (cpage - 1) * psize;
		
		try {
			sql = "select ml_id, ml_pwd, ml_name, ml_birth, ml_phone, ml_email, ml_point, ml_date, ml_last, " +
			" if(ml_status = 'a', 'ÀÏ¹Ý', if(ml_status = 'b', 'ÈÞ¸Õ', 'Å»Åð')) stat, " +
			" if(ml_gender = 'F', '¿©', '³²') gender from t_member_list " + where + orderby + " limit " + snum + ", " + psize;
			System.out.println(sql);
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				memberInfo = new MemberInfo();
				memberInfo.setMlid(rs.getString("ml_id"));
				memberInfo.setMlpwd(rs.getString("ml_pwd"));
				memberInfo.setMlname(rs.getString("ml_name"));
				memberInfo.setMlgender(rs.getString("gender"));
				memberInfo.setMlbirth(rs.getString("ml_birth"));
				memberInfo.setMlphone(rs.getString("ml_phone"));
				memberInfo.setMlemail(rs.getString("ml_email"));
				memberInfo.setMldate(rs.getString("ml_date"));
				memberInfo.setMllast(rs.getString("ml_last"));
				memberInfo.setMlstatus(rs.getString("stat"));
				memberInfo.setMlpoint(rs.getInt("ml_point"));
				memberList.add(memberInfo);
			}
			
		} catch(Exception e) {
			System.out.println("getMemberList() ¿À·ù");			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return memberList;
	}
	
	public MemberInfo getMember(String id) {
		MemberInfo member = null;
		Statement stmt = null;
		ResultSet rs = null;
			
		try {
			String sql = "select * from t_member_list where ml_id = '" + id + "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				member = new MemberInfo();
				member.setMlid(id);
				member.setMlpwd(rs.getString("ml_pwd"));
				member.setMlname(rs.getString("ml_name"));
				member.setMlgender(rs.getString("ml_gender"));
				member.setMlbirth(rs.getString("ml_birth"));
				member.setMlphone(rs.getString("ml_phone"));
				member.setMlemail(rs.getString("ml_email"));
				member.setMldate(rs.getString("ml_date"));
				member.setMllast(rs.getString("ml_last"));
				member.setMlstatus("a");
				member.setMlpoint(rs.getInt("ml_point"));
			}
		} catch(Exception e) {
			System.out.println("getMember() ¿À·ù");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return member;
	}
	
	public AddrInfo getBasicAddr(String id) {
		AddrInfo addr = new AddrInfo();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_member_addr where ma_basic = 'y' and ml_id = '" + id + "' " ;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				addr.setMa_idx(rs.getInt("ma_idx"));
				addr.setMl_id(rs.getString("ml_id"));
				addr.setMa_zip(rs.getString("ma_zip"));
				addr.setMa_addr1(rs.getString("ma_addr1"));
				addr.setMa_addr2(rs.getString("ma_addr2"));
				addr.setMa_basic(rs.getString("ma_basic"));
			}
		} catch(Exception e) {
			System.out.println("getBasicAddr() ¿À·ù");		e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return addr;
	}
}

