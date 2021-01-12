package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class WishDelSvc {
	public int wishDelete(String idx, String buyer) {
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		int result = cartDao.wishDelete(idx, buyer);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
}
