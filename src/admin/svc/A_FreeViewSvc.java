package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class A_FreeViewSvc {
	public FreeInfo getArticle(int idx) {
		FreeInfo article = null;
		Connection conn = getConnection();
		A_FreeDao afreeDao = A_FreeDao.getInstance();
		afreeDao.setConnection(conn);

		int result = afreeDao.setCountUp(idx);
		if (result > 0)	commit(conn);
		else			rollback(conn);
		article = afreeDao.getArticle(idx);	

		close(conn);
		return article;
	}
}
