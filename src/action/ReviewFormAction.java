package action;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import svc.*;
import vo.*;

public class ReviewFormAction implements Action {
// 리뷰 등록/수정 폼으로 연결하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		String wtype = request.getParameter("wtype");
		
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		
		if(loginMember != null) {
			ReviewInfo review = new ReviewInfo(); 
			ReviewFormSvc reviewFormSvc = new ReviewFormSvc();
			String uid = loginMember.getMlid();
			String plid = request.getParameter("plid");
			String plname = request.getParameter("plname");
			if(wtype.equals("up")) {	//수정이면
				int idx = Integer.parseInt(request.getParameter("idx"));
				review = reviewFormSvc.getReview(idx);
				request.setAttribute("review", review);
				forward.setPath("review_form.jsp?wtype=up&idx="+idx);
			} else {	// 등록이면
				String olid = request.getParameter("olid");
				String odidx = request.getParameter("odidx");
				forward.setPath("product/review_form.jsp?wtype=in&plid="+plid+"&plname="+plname+"&olid="+olid+"&odidx="+odidx);
			}
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('회원 전용 기능입니다.\n로그인 해주세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return forward;
	}
}
