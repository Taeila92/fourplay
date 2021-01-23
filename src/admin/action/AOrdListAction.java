package admin.action;

import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import admin.svc.*;
import svc.OrdListSvc;
import vo.*;

public class AOrdListAction implements action.Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AOrdListAction");
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		ArrayList<OrdListInfo> ordList = new ArrayList<OrdListInfo>();
		
		int cpage = 1, pcnt, spage, epage, rcnt, bsize = 10, psize = 12;		// 페이징에 필요한 값들을 저장할 변수 선언 및 초기화
		if (request.getParameter("cpage") != null)			cpage = Integer.parseInt(request.getParameter("cpage"));
		if (request.getParameter("psize") != null)			psize = Integer.parseInt(request.getParameter("psize"));

		HttpSession session = request.getSession();
		AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
		String buyer = "";
		
		if(adminMember != null) {	// 로그인한 회원이면
			AOrdListSvc aOrdListSvc = new AOrdListSvc();
			
			rcnt = aOrdListSvc.getOrdCount();	// 페이징을 위해 전체 주문내역 수를 받아옴
			ordList = aOrdListSvc.getOrdList(cpage, psize);	// 전체 주문목록을 받아옴
			
			pcnt = rcnt / psize;
			if (rcnt % psize > 0)	pcnt++;				// 전체 페이지수
			spage = (cpage - 1) / psize * psize + 1;	// 블록 시작페이지 번호
			epage = spage + psize - 1;
			if (epage > pcnt)	epage = pcnt;			// 블록 종료페이지 번호
			
			OrdPageInfo pageInfo = new OrdPageInfo();	// 페이징에 필요한 정보를 담을 인스턴스 생성
			pageInfo.setCpage(cpage);		// 현재 페이지 번호
			pageInfo.setPcnt(pcnt);			// 전체 페이지 개수
			pageInfo.setSpage(spage);		// 블록 시작페이지 번호
			pageInfo.setEpage(epage);		// 블록 종료페이지 번호
			pageInfo.setRcnt(rcnt);			// 전체 상품(레코드) 개수
			pageInfo.setBsize(bsize);		// 블록내 페이지 개수
			pageInfo.setPsize(psize);		// 페이지내 상품 개수
			
			request.setAttribute("ordList", ordList);
			request.setAttribute("pageInfo", pageInfo);
			forward.setPath("order/a_order_list.jsp");
		} else {	// 로그인해야만 들어올 수 있으므로
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return forward;
	}
}
