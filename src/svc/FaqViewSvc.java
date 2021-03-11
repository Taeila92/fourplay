package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class FaqViewSvc {
// 게시글 보기의 비즈니스 로직을 처리하는 클래스
	public FaqInfo getArticle(int idx) {
	// 인수로 받아온 idx에 해당하는 게시물 하나의 정보를 추출하여 FreeInfo형 인스턴스로 리턴하는 메소드
		FaqInfo article = null;	// 리턴할 게시물 정보를 담을 인스턴스 선언
		Connection conn = getConnection();
		FaqDao faqDao = FaqDao.getInstance();
		faqDao.setConnection(conn);

		article = faqDao.getArticle(idx);	// 보여줄 게시글 받기

		close(conn);
		return article;
	}
}
