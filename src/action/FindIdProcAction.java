package action;

import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;	
import svc.*;
import vo.*;

public class FindIdProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		String type = request.getParameter("chk");
		FindIdProcSvc findIdProcSvc = new FindIdProcSvc();
		MemberInfo memberId = new MemberInfo();
		
		if (type.equals("e")) {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			memberId = findIdProcSvc.getMemberEId(name, email);
		} else {
			String name = request.getParameter("name");
			String p1 = request.getParameter("p1");
			String p2 = request.getParameter("p2");
			String p3 = request.getParameter("p3");
			String phone = p1 + "-" + p2 + "-" + p3;
			memberId = findIdProcSvc.getMemberPId(name, phone);
		}
		
		if (memberId != null) {
			request.setAttribute("memberId", memberId);
			forward.setPath("find_id.jsp");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('일치하는 정보가 없습니다.');");
			out.println("location.replace('find_id.find');");
			out.println("</script>");
			
		}
		
		return forward;
	}
}
