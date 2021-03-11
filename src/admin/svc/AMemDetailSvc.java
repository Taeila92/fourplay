package admin.svc;

import static db.JdbcUtil.*;
import java.sql.*;
import admin.dao.*;
import dao.MpgDao;
import vo.*;

public class AMemDetailSvc {
	public MemberInfo getMember(String id) {
		AMemDao aMemDao = AMemDao.getInstance();
		Connection conn = getConnection();
		aMemDao.setConnection(conn);
		MemberInfo member = aMemDao.getMember(id);
		close(conn);
		
		return member;
	}
	
	public AddrInfo getBasicAddr(String id) {
		AMemDao aMemDao = AMemDao.getInstance();
		Connection conn = getConnection();
		aMemDao.setConnection(conn);
		AddrInfo addr = aMemDao.getBasicAddr(id);
		close(conn);
		
		return addr;
	}
}
