package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class AOrdPdtSvc {
	public PdtInfo getPdtInfo(String id) {
		PdtInfo pdtInfo = null;	
		Connection conn = getConnection();
		AOrdDao aOrdDao = AOrdDao.getInstance();
		aOrdDao.setConnection(conn);
		pdtInfo = aOrdDao.getPdtInfo(id);	
		close(conn);
		return pdtInfo;
	}
}
