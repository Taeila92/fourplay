package admin.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class A_NoticeFormSvc {
	public NoticeInfo getArticleUp(int idx, String uid) {
	// 수정할 글에 대한 권한이 있을 경우 해당 데이터를 가져와 리턴할 메소드
		NoticeInfo article = null;
		Connection conn = getConnection();
		A_NoticeDao anoticeDao = A_NoticeDao.getInstance();
		anoticeDao.setConnection(conn);

		article = anoticeDao.getArticleUp(idx, uid);

		close(conn);
		return article;
	}
}
