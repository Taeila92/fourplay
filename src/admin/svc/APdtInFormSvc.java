package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class APdtInFormSvc {
	public ArrayList<CataBigInfo> getCataBigList() {
	// 대분류 목록을 ArrayList 형 인스턴스로 리턴하는 메소드
		ArrayList<CataBigInfo> cataBigList = null;
		Connection conn = getConnection();
		APdtDao pdtDao = APdtDao.getInstance();
		pdtDao.setConnection(conn);
		cataBigList = pdtDao.getCataBigList();
		close(conn);
		return cataBigList;
	}
	public ArrayList<CataSmallInfo> getCataSmallList() {
	// 소분류 목록을 ArrayList 형 인스턴스로 리턴하는 메소드
		ArrayList<CataSmallInfo> cataSmallList = null;
		Connection conn = getConnection();
		APdtDao pdtDao = APdtDao.getInstance();
		pdtDao.setConnection(conn);
		cataSmallList = pdtDao.getCataSmallList();
		close(conn);
		return cataSmallList;
	}

}
