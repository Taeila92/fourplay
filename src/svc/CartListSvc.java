package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class CartListSvc {
	public ArrayList<CartInfo> getCartList(String where) {
		ArrayList<CartInfo> cartList = null;
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		cartList = cartDao.getCartList(where);
		close(conn);

		return cartList;
	}
}
