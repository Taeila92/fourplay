package admin.dao;

import static db.JdbcUtil.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;

public class AdmDao {
	private static AdmDao admDao;
	private Connection conn;
	private AdmDao() {}
	public static AdmDao getInstance() {
		if (admDao == null) {
			admDao = new AdmDao();
		}
		return admDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public boolean isSA(AdminInfo adminMember) {
		boolean isSA = false;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_admin_list where al_id = '" + adminMember.getAl_id() + "' and al_pwd = '" + adminMember.getAl_pwd() + "' and al_status = 'b' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {	// 현재 로그인한 계정이 SuperAdmin 계정이면
				isSA = true;
			}
		} catch(Exception e) {
			System.out.println("isSA() 오류");			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return isSA;
	}
	
	public int admInsert(AdminInfo adminMember) {
		int result = 0;
		Statement stmt = null;
		String sql = null;
		try {
			sql = "insert into t_admin_list (al_id, al_pwd, al_name, al_phone, al_email) values " +
					"('" + adminMember.getAl_id() + "', '" + adminMember.getAl_pwd() + "', '" + adminMember.getAl_name()
					+ "', '" + adminMember.getAl_phone()+ "', '" + adminMember.getAl_email()+ "' ) ";
			System.out.println(sql);	
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("admInsert() 오류");			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	public int admUpdate(AdminInfo adminMember) {
		int result = 0;
		Statement stmt = null;
		String sql = null;
		try {
			sql = "update t_admin_list set al_pwd = '" + adminMember.getAl_pwd() + "', al_phone = '"+ adminMember.getAl_phone()
				+ "', al_email = '"+ adminMember.getAl_email() +"' where al_id = '"+ adminMember.getAl_id() +"' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("admUpdate() 오류");			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
	public int admDelete(String aid) {	// 관리자 계정을 db에서 삭제하는 메소드
		System.out.println("dao admDelete");
		int result = 0;
        Statement stmt = null;
        try {
           String sql = "delete from t_admin_list where al_id ='" + aid + "' ";
           System.out.println(sql);
           stmt = conn.createStatement();
           result = stmt.executeUpdate(sql);
        } catch(Exception e) {
           System.out.println("admDelete() 오류");      e.printStackTrace();
        } finally {
           close(stmt);
        }
        return result;
	}
	
	public int getAdmCount(String where) {	
		System.out.println("dao getAdmCount");
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			String sql = "select count(*) from t_admin_list " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("getAdmCount() 오류");	e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return rcnt;
	}
	public ArrayList<AdminInfo> getAdmList(String where, String orderby, int cpage, int psize) {
		System.out.println("dao getAdmList");
		ArrayList<AdminInfo> admList = new ArrayList<AdminInfo>();
		AdminInfo adminfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		int snum = (cpage - 1) * psize;
		
		try {
			sql = "select * from t_admin_list " + where + orderby + " limit " + snum + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				adminfo = new AdminInfo();
				adminfo.setAl_date(rs.getString("al_date"));
				adminfo.setAl_email(rs.getString("al_email"));
				adminfo.setAl_name(rs.getString("al_name"));
				adminfo.setAl_phone(rs.getString("al_phone"));
				adminfo.setAl_pwd(rs.getString("al_pwd"));
				adminfo.setAl_id(rs.getString("al_id"));
				adminfo.setAl_idx(rs.getInt("al_idx"));
				adminfo.setAl_status(rs.getString("al_status"));
				adminfo.setHtryList(getHistory(rs.getInt("al_idx")));
				
				admList.add(adminfo);
			}
			
		} catch(Exception e) {
			System.out.println("getAdmList() 오류");			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return admList;
	}
	
	public ArrayList<HistoryInfo> getHistory(int alidx) {
		ArrayList<HistoryInfo> htryList = new ArrayList<HistoryInfo>();
		HistoryInfo historyInfo = new HistoryInfo();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			sql = "select * from t_admin_history where al_idx = " + alidx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				historyInfo.setAh_date(rs.getString("ah_date"));
				historyInfo.setAl_idx(alidx);
				historyInfo.setAm_idx(rs.getInt("am_idx"));
				historyInfo.setPl_id(rs.getString("pl_id"));
				historyInfo.setCs_idx(rs.getInt("cs_idx"));
				historyInfo.setNl_idx(rs.getInt("nl_idx"));
				historyInfo.setQl_idx(rs.getInt("ql_idx"));
				historyInfo.setOl_id(rs.getNString("ol_id"));
				
				htryList.add(historyInfo);
			}
		} catch(Exception e) {
			System.out.println("getHistory() 오류");			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return htryList;
	}
	
	public int chStatus(String idxs, String st){
		System.out.println("dao chStatus");
		Statement stmt = null;
		String sql = null;
		int result = 0;
		
		try {
			String[] arrIdx = idxs.split(",");
			String[] arrSt = st.split(",");
			System.out.println(arrIdx.length);
			for(int i = 0; i < arrIdx.length; i++ ) {
				sql = "update t_admin_list set al_status = '" + arrSt[i] + "' where al_idx = " + arrIdx[i];
				stmt = conn.createStatement();
				result = stmt.executeUpdate(sql);
			}
		} catch(Exception e) {
			System.out.println("chStatus() 오류");			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
}
