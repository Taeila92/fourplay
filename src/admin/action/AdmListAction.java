package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AdmListAction implements action.Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AdmListAction");
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		ArrayList<AdminInfo> admList = new ArrayList<AdminInfo>();
		HttpSession session = request.getSession();
		AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
		
		String kind = "";
		if(request.getParameter("kind") != null) 	kind = request.getParameter("kind");
		
		if(adminMember != null && adminMember.getAl_id().equals("sa")) {
			int cpage = 1, pcnt, spage, epage, rcnt, bsize = 10, psize = 3;
			// 페이징에 필요한 값들을 저장할 변수 선언 및 초기화
			if (request.getParameter("cpage") != null)			cpage = Integer.parseInt(request.getParameter("cpage"));
			if (request.getParameter("psize") != null)			psize = Integer.parseInt(request.getParameter("psize"));
			
			String status, schtype, keyword;
			status	= request.getParameter("status");	// 사용여부(a: 미사용 b: 사용중)
			schtype = request.getParameter("schtype");	// 검색조건으로 아이디(id)와 이름(name)
			keyword = request.getParameter("keyword");	// 검색어
			String ord = request.getParameter("ord");	// 정렬조건으로 관리자 아이디(오a내d), 관리자이름name(오a), 등록일date(오a내d), 계정사용여부status(오a내d)
			
			String where = " where al_id != 'sa' ", orderby = "";
			if (keyword != null && !keyword.equals(""))	{
				where += " and al_" + schtype + " like '%" + keyword + "%' ";
			}
			if(status != null && !status.equals(""))	{
				if(where.equals(""))	where = " where al_status ='" + status + "' ";
				else 					where += " and al_status ='" + status + "' ";
			}
			if (ord != null && !ord.equals("")) {
				orderby = " order by al_" + ord.substring(0, ord.length() - 1) + 
				(ord.substring(ord.length() - 1).equals("d") ? " desc" : " asc");
			}	// 정렬값 : aida, aidd, namea, named, datea, dated, statusa, statusd
	
			AdmListSvc admListSvc = new AdmListSvc();
			admList = admListSvc.getAdmList(where, orderby, cpage, psize);
			rcnt = admListSvc.getAdmCount(where);	// 검색된 관리자 계정의 총 개수(페이지 개수를 구하기 위해 필요)

			System.out.println("admListAction finished");
			
			pcnt = rcnt / psize;
			if (rcnt % psize > 0)	pcnt++;				// 전체 페이지수 구함
			spage = (cpage - 1) / psize * psize + 1;	// 블록 시작페이지 번호
			epage = spage + psize - 1;
			if (epage > pcnt)	epage = pcnt;			// 블록 종료페이지 번호
	
			AdmPageInfo pageInfo = new AdmPageInfo();	// 페이징에 필요한 정보를 담을 인스턴스 생성
			pageInfo.setCpage(cpage);		// 현재 페이지 번호
			pageInfo.setPcnt(pcnt);			// 전체 페이지 개수
			pageInfo.setSpage(spage);		// 블록 시작페이지 번호
			pageInfo.setEpage(epage);		// 블록 종료페이지 번호
			pageInfo.setRcnt(rcnt);			// 전체 관리자 계정 개수
			pageInfo.setBsize(bsize);		// 블록내 페이지 개수
			pageInfo.setPsize(psize);		// 페이지내 관리자 계정 개수
			pageInfo.setSchtype(schtype);
			pageInfo.setKeyword(keyword);
			pageInfo.setStatus(status);
			pageInfo.setOrd(ord);			// 정렬조건
			
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("admList", admList);
			forward.setPath("admin/admin_list.jsp");
			if(kind.equals("join"))	{
				forward.setPath("/admin/admin_list.jsp");
			}
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('접근 권한이 없습니다.');");
			out.println("location.replace('../index.jsp');");
			out.println("</script>");
			out.close();
		}
		
		return forward;
	}
}
