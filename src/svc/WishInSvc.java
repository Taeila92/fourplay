package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class WishInSvc {
	public int wishInsert(CartInfo cart) {
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		int result = cartDao.wishInsert(cart);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
}
