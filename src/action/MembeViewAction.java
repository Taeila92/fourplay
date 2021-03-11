package action;

import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;	
import svc.*;
import vo.*;

public class MembeViewAction implements Action {
// 회원정보 화면으로 이동하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		
		if(loginMember != null) {	// 로그인된 상태면
			String uid = loginMember.getMlid();
			MembeViewSvc membeViewSvc = new MembeViewSvc();
			AddrInfo addr = membeViewSvc.getBasicAddr(uid);
			System.out.println("MembeViewAction finished");
			
			request.setAttribute("loginMember", loginMember);
			request.setAttribute("addr", addr);
			forward.setPath("member/member_info.jsp");
		} else {	// 로그인이 풀렸으면
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('접근 권한이 없습니다.\n다시 로그인하세요.');");
			out.println("location.replace('login_form.jsp');");
			out.println("</script>");
			out.close();
		}
		return forward;
	}
}
