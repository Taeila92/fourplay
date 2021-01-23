package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberViewSvc {
	public AddrInfo getBasicAddr(String uid) {
		MpgDao mpgDao = MpgDao.getInstance();
		Connection conn = getConnection();
		mpgDao.setConnection(conn);
		AddrInfo addr = mpgDao.getBasicAddr(uid);
		close(conn);
		
		return addr;
	}
}
