package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MembeViewSvc {
	public AddrInfo getBasicAddr(String uid) {
		MpgDao mpgDao = MpgDao.getInstance();
		Connection conn = getConnection();
		mpgDao.setConnection(conn);
		AddrInfo addr = mpgDao.getBasicAddr(uid);
		close(conn);
		
		return addr;
	}
	public ArrayList<AddrInfo> getAddrList(String uid) {
		MpgDao mpgDao = MpgDao.getInstance();
		Connection conn = getConnection();
		mpgDao.setConnection(conn);
		ArrayList<AddrInfo> addrList = mpgDao.getAddrList(uid);
		close(conn);
		
		return addrList;
	}
}
