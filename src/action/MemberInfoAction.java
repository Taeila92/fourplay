package action;

import java.io.PrintWriter;
import javax.servlet.http.*;	
import java.util.*;
import svc.*;
import vo.*;

public class MemberInfoAction implements Action {
// 회원정보 화면으로 이동하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		if(loginMember != null) {	// 로그인된 상태면
			request.setAttribute("loginMember", loginMember);
			String uid = loginMember.getMlid();
			MemberViewSvc MemberViewSvc = new MemberViewSvc();
			AddrInfo addr = MemberViewSvc.getBasicAddr(uid);
			request.setAttribute("addr", addr);
			forward.setPath("member/member_info.jsp");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.replace('login_form.jsp');");
			out.println("</script>");
			out.close();
		}	
		
		return forward;
	}
}
