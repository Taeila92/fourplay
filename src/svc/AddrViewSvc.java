package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AddrViewSvc {
	public ArrayList<AddrInfo> getAddrList(String uid) {
		ArrayList<AddrInfo> addrList = null;
		Connection conn = getConnection();
		MpgDao mpgDao = MpgDao.getInstance();
		mpgDao.setConnection(conn);
		addrList = mpgDao.getAddrList(uid);
		close(conn);

		return addrList;
	}
}
