package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PointListSvc {
	public ArrayList<MemberInfo> getPointList (String uid) {
		ArrayList<MemberInfo> pointList = null;
		Connection conn = getConnection();
		MpgDao mpgDao = MpgDao.getInstance();
		mpgDao.setConnection(conn);
		pointList = mpgDao.getPointList(uid);
		close(conn);
		
		return pointList;
	}
}
