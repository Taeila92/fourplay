package action;

import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;	
import svc.*;
import vo.*;

public class FindIdAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		FindSvc findSvc = new FindSvc();
		
		MemberInfo memberId = findSvc.getMemberId(name, email);
		request.setAttribute("memberId", memberId);
		forward.setPath("member/member_info.jsp");
		return forward;
	}
}
