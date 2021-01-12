package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class WishListSvc {
	public ArrayList<CartInfo> getWishList(String where) {
		ArrayList<CartInfo> wishList = null;
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		wishList = cartDao.getWishList(where);
		close(conn);

		return wishList;
	}
}