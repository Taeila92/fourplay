package action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import svc.*;
import vo.*;

public class OrdDetailAction implements Action {	// 회원의 특정 주문 상세내역을 가져와 연결하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		OrdListInfo detailInfo = new OrdListInfo();
		request.setCharacterEncoding("utf-8");
		String olid = request.getParameter("olid");
		String where = "";
		HttpSession session = request.getSession();
		
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		if(loginMember != null) {	// 로그인한 상태면
			where += " and ol_buyer = '" + loginMember.getMlid() + "' and ol_ismember = 'y' ";
			OrdListSvc ordListSvc = new OrdListSvc();
			detailInfo = ordListSvc.getOrd(olid, where);
			request.setAttribute("detailInfo", detailInfo);
			forward.setPath("/member/order_detail.jsp");
		} else {
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
