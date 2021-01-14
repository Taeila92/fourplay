package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class CartUpCntSvc {
	public int cartCntUpdate(String idx, String cnt, String buyer, String isMember) {
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		int result = cartDao.cartCntUpdate(idx, cnt, buyer, isMember);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
}
