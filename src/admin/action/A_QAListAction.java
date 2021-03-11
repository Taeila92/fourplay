package admin.action;

import javax.servlet.http.*;
import java.util.*;
import admin.svc.*;
import svc.QAListSvc;
import vo.*;

public class A_QAListAction implements A_Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<QAInfo> articleList = new ArrayList<QAInfo>();
		
		request.setCharacterEncoding("utf-8");
		int cpage = 1, limit = 10;
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");	// 검색어

		String where = "";	// 쿼리 작업시 사용할 조건을 저장할 변수
		if (keyword != null && !keyword.equals("")) {
			if (schtype.equals("tc")) {	// 검색 조건이 '제목+내용' 이면
				where = " and (ql_title like '%" + keyword + "%' " + " or ql_content like '%" + keyword + "%') ";
			} else {	// 검색조건이 제목 또는 내용 또는 작성자 이면
				where = " and ql_" + schtype + " like '%" + keyword + "%' ";
			}
		}

		A_QAListSvc aqaListSvc = new A_QAListSvc();

		int rcnt = aqaListSvc.getArticleCount(where);
		articleList = aqaListSvc.getArticleList(where, cpage, limit);

		int pcnt = rcnt / limit;
		if (rcnt % limit > 0)	pcnt++;
		int spage = (cpage - 1) / limit * limit + 1;
		int epage = spage + limit - 1;
		if (epage > pcnt)	epage = pcnt;

		QAPageInfo pageInfo = new QAPageInfo();
		pageInfo.setCpage(cpage);		// 현재 페이지 번호
		pageInfo.setRcnt(rcnt);			// 전체 게시글 수
		pageInfo.setPcnt(pcnt);			// 전체 페이지 수
		pageInfo.setSpage(spage);		// 블록 시작 페이지 번호
		pageInfo.setEpage(epage);		// 블록 종료 페이지 번호
		pageInfo.setSchtype(schtype);	// 검색조건
		pageInfo.setKeyword(keyword);	// 검색어
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("articleList", articleList);

		ActionForward forward = new ActionForward();
		forward.setPath("/admin/bbs/a_aqa_list.jsp");
		return forward;
	}
}
