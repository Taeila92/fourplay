package db;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

// DB관련 연결 및 공용 메소드들을 위한 클래스
public class JdbcUtil {
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/MySQLDB");
			conn = ds.getConnection();
			conn.setAutoCommit(false);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	public static void close(Connection conn) {	// DB와의 연결을 끊어 주는 메소드
		try {
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(Statement stmt) {		// Statement를 닫는 메소드
		try {
			stmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs) {		// ResultSet을 닫는 메소드
		try {
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void commit(Connection conn) {	// transaction을 commit 시키는 메소드
		try {
			conn.commit();
			System.out.println("commit success");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void rollback(Connection conn) {	// transaction을 rollback 시키는 메소드
		try {
			conn.rollback();
			System.out.println("rollback success");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
