package action;

import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

public class PdtListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<PdtInfo> pdtList = new ArrayList<PdtInfo>();
		// 상품 목록을 저장할 ArrayList객체로 PdtInfo형 인스턴스만 저장함

		request.setCharacterEncoding("utf-8");
		int cpage = 1, pcnt, spage, epage, rcnt, bsize = 10, psize = 12;
		// 페이징에 필요한 값들을 저장할 변수 선언 및 초기화
		if (request.getParameter("cpage") != null)
			cpage = Integer.parseInt(request.getParameter("cpage"));
		if (request.getParameter("psize") != null)
			psize = Integer.parseInt(request.getParameter("psize"));

		// 검색조건 쿼리스트링을 받음
		String keyword, bcata, scata, brand, sprice, eprice;
		keyword = request.getParameter("keyword");	// 검색어
		bcata	= request.getParameter("bcata");	// 대분류
		scata	= request.getParameter("scata");	// 소분류
		sprice	= request.getParameter("sprice");	// 가격대 중 시작 가격대
		eprice	= request.getParameter("eprice");	// 가격대 중 종료 가격대
		
		// 정렬조건 : 가격price(오a내d), 상품명name(오a), 등록일date(내d), 인기salecnt(내d), 리뷰review(내d)
		String ord = request.getParameter("ord");
		String id = request.getParameter("id");
		String where = " and a.pl_view = 'y' ", orderby = "";
		if (bcata != null && !bcata.equals(""))		where += " and b.cb_idx = '" + bcata + "' ";
		if (scata != null && !scata.equals(""))		where += " and a.cs_idx = '" + scata + "' ";
		if (sprice != null && !sprice.equals(""))	where += " and a.pl_price >= '" + sprice + "' ";
		if (eprice != null && !eprice.equals(""))	where += " and a.pl_price <= '" + eprice + "' ";
		if (keyword != null && !keyword.equals(""))	where += " and a.pl_name like '%" + keyword + "%' ";
		// 검색조건용 where절 생성

		if (ord != null && !ord.equals(""))
			orderby = " order by a.pl_" + ord.substring(0, ord.length() - 1) + 
			(ord.substring(ord.length() - 1).equals("d") ? " desc" : " asc");
		// 정렬값 : pricea, priced, namea, datea, dated, salecntd, reviewd

		PdtListSvc pdtListSvc = new PdtListSvc();		
		rcnt = pdtListSvc.getPdtCount(where);	// 검색된 상품의 총 개수(페이지 개수를 구하기 위해 필요)
		pdtList = pdtListSvc.getPdtList(where, orderby, cpage, psize);
		// 현 페이지에서 보여줄 검색된 상품목록
		// 검색조건, 정렬조건, limit에서 사용할 값을 구하기 위해 현재페이지와 페이지크기를 인수로 가져감

		pcnt = rcnt / psize;
		if (rcnt % psize > 0)	pcnt++;				// 전체 페이지수 구함
		spage = (cpage - 1) / psize * psize + 1;	// 블록 시작페이지 번호
		epage = spage + psize - 1;
		if (epage > pcnt)	epage = pcnt;			// 블록 종료페이지 번호

		PdtPageInfo pageInfo = new PdtPageInfo();	// 페이징에 필요한 정보를 담을 인스턴스 생성
		pageInfo.setCpage(cpage);		// 현재 페이지 번호
		pageInfo.setPcnt(pcnt);			// 전체 페이지 개수
		pageInfo.setSpage(spage);		// 블록 시작페이지 번호
		pageInfo.setEpage(epage);		// 블록 종료페이지 번호
		pageInfo.setRcnt(rcnt);			// 전체 상품(레코드) 개수
		pageInfo.setBsize(bsize);		// 블록내 페이지 개수
		pageInfo.setPsize(psize);		// 페이지내 상품 개수

		pageInfo.setKeyword(keyword);	// 검색어
		pageInfo.setOrd(ord);			// 정렬조건
		// 대분류, 소분류, 브랜드 목록을 가져오기 위한 Svc클래스
		ArrayList<CataBigInfo> cataBigList = pdtListSvc.getCataBigList();		// 대분류 목록
		ArrayList<CataSmallInfo> cataSmallList = pdtListSvc.getCataSmallList();	// 소분류 목록
		ArrayList<PdtInfo> bestPdtList = pdtListSvc.getBestPdtList(scata);		// 베스트상품 목록

		request.setAttribute("pdtList", pdtList);
		request.setAttribute("bestPdtList", bestPdtList);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("cataBigList", cataBigList);
		request.setAttribute("cataSmallList", cataSmallList);
		// 상품목록 화면(pdt_list.jsp)으로 목록(pdtList)과 페이징 정보(pageInfo), 분류들을 request에 담아 가져감

		ActionForward forward = new ActionForward();
		forward.setPath("/product/product_list.jsp");
		return forward;
	}
}

