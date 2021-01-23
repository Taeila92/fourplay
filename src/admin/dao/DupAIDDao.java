package admin.dao;

import static db.JdbcUtil.*;
import java.sql.*;

public class DupAIDDao {
	private static DupAIDDao dupAIDDao;
	private Connection conn;

	private DupAIDDao() {}

	public static DupAIDDao getInstance() {
		if (dupAIDDao == null) {
			dupAIDDao = new DupAIDDao();
		}
		return dupAIDDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int chkDupAID(String aid) {
		Statement stmt = null;
		ResultSet rs = null;
		int chkPoint = 0;

		try {
			stmt = conn.createStatement();
			String sql = "select count(*) from t_admin_list where al_id = '" + aid + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next())	chkPoint = rs.getInt(1);
			System.out.println(chkPoint);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(rs);		close(stmt);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return chkPoint;
	}
}
