package admin.svc;

import static db.JdbcUtil.*;
import java.sql.*;
import admin.dao.*;
import vo.*;

public class A_NoticeProcSvc {
// 게시글에 대한 실제 작업을 처리하는 클래스
	public boolean anoticeInsert(NoticeInfo noticeInfo) throws Exception {
	// 게시글 등록을 위한 메소드
		boolean isSuccess = false;
		Connection conn = getConnection();
		A_NoticeDao anoticeDao = A_NoticeDao.getInstance();
		anoticeDao.setConnection(conn);

		int result = anoticeDao.anoticeInsert(noticeInfo);
		if (result > 0) {
		// 글등록하는 쿼리를 실행했을 때 등록된 레코드가 있으면
			commit(conn);	// 쿼리를 실제로 적용시킴
			isSuccess = true;
		} else {
		// 글등록하는 쿼리를 실행했을 때 등록된 레코드가 없으면
			rollback(conn);	// 실행했던 모든 쿼리를 무효화 시킴
		}

		close(conn);
		return isSuccess;
	}
	
	public boolean anoticeUpdate(NoticeInfo noticeInfo) throws Exception {
	// 게시글 수정을 위한 메소드
		boolean isSuccess = false;
		Connection conn = getConnection();
		A_NoticeDao anoticeDao = A_NoticeDao.getInstance();
		anoticeDao.setConnection(conn);

		int result = anoticeDao.anoticeUpdate(noticeInfo);
		if (result > 0) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}

		close(conn);
		return isSuccess;
	}
	public boolean anoticeDelete(int idx, NoticeInfo noticeInfo) throws Exception {
	// 게시글 삭제를 위한 메소드
		boolean isSuccess = false;
		Connection conn = getConnection();
		A_NoticeDao anoticeDao = A_NoticeDao.getInstance();
		anoticeDao.setConnection(conn);

		int result = anoticeDao.anoticeDelete(idx, noticeInfo);
		if (result > 0) {
			commit(conn);
			isSuccess = true;
		} else {
			rollback(conn);
		}

		close(conn);
		return isSuccess;
	}
}
