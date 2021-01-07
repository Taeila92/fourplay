package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class OrdListSvc {
	public int getOrdCount(String buyer) {	//한 회원의 전체 주문 개수를 리턴
		int rcnt = 0;	
		Connection conn = getConnection();
		OrdDao ordDao = OrdDao.getInstance();
		ordDao.setConnection(conn);
		rcnt = ordDao.getOrdCount(buyer);
		close(conn);

		return rcnt;
	}
	
	public ArrayList<OrdListInfo> getOrdList(String buyer, int cpage, int psize){
		ArrayList<OrdListInfo> ordList = new ArrayList<OrdListInfo>();
		Connection conn = getConnection();
		OrdDao ordDao = OrdDao.getInstance();
		ordDao.setConnection(conn);
		ordList = ordDao.getOrdList(buyer, cpage, psize);
		close(conn);
		return ordList;
	}
	
	public boolean chkNonOrd(String olid, String bname) {
		boolean isSuccess = false;
		Connection conn = getConnection();
		OrdDao ordDao = OrdDao.getInstance();
		ordDao.setConnection(conn);
		isSuccess = ordDao.chkNonOrd(olid, bname);
		close(conn);		
		
		System.out.println("svc chkNonOrd");
		return isSuccess;
	}
	
	public OrdListInfo getOrd(String olid, String where) {		//하나의 주문내역 정보만 가져오는 메소드
		OrdListInfo ordInfo = new OrdListInfo();
		Connection conn = getConnection();
		OrdDao ordDao = OrdDao.getInstance();
		ordDao.setConnection(conn);
		ordInfo = ordDao.getOrd(olid, where);
		close(conn);			
		return ordInfo;
	}
}
