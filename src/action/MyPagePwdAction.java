package action;

import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;	
import svc.*;
import vo.*;

public class MyPagePwdAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		
		if(loginMember != null) {	
			request.setAttribute("loginMember", loginMember);
			forward.setPath("member/mypage_pwd.jsp");
		} else {	
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
