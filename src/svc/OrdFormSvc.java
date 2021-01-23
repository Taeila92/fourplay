package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class OrdFormSvc {
	public ArrayList<CartInfo> getOrdFrmPdtList(String kind, String where) {
		ArrayList<CartInfo> pdtList = null;
		Connection conn = getConnection();
		OrdDao ordDao = OrdDao.getInstance();
		ordDao.setConnection(conn);
		pdtList = ordDao.getOrdFrmPdtList(kind, where);
		close(conn);

		return pdtList;
	}
	
	public AddrInfo getaddr(String uid) {
		
		AddrInfo addrInfo = new AddrInfo();
		
		Connection conn = getConnection();
		MpgDao mpgDao = MpgDao.getInstance();
		mpgDao.setConnection(conn);
		addrInfo = mpgDao.getBasicAddr(uid);
		close(conn);

		return addrInfo;
	}
}
