package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class APdtDetailSvc {
	public PdtInfo getPdtInfo(String id) {
		PdtInfo pdtInfo = null;	// 리턴할 상품정보를 담을 인스턴스 선언
		Connection conn = getConnection();
		APdtDao aPdtDao = APdtDao.getInstance();
		aPdtDao.setConnection(conn);

		pdtInfo = aPdtDao.getPdtInfo(id);	// 보여줄 상품정보 받기

		close(conn);
		return pdtInfo;
	}
	public ArrayList<PdtSizeInfo> getPdtSizeList(String id) {
		ArrayList<PdtSizeInfo> pdtSizelist = new ArrayList<PdtSizeInfo>();	// 리턴할 상품정보를 담을 인스턴스 선언
		Connection conn = getConnection();
		APdtDao aPdtDao = APdtDao.getInstance();
		aPdtDao.setConnection(conn);

		pdtSizelist = aPdtDao.getPdtSizeList(id);	// 보여줄 상품디테일정보 받기

		close(conn);
		return pdtSizelist;
	}
}
