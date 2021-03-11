package action;

import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;	
import svc.*;
import vo.*;

public class FindPwdProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		String type = request.getParameter("chk");
		FindPwdProcSvc findPwdProcSvc = new FindPwdProcSvc();
		MemberInfo memberPwd = new MemberInfo();
		
		if (type.equals("e")) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			memberPwd = findPwdProcSvc.getMemberEPwd(id, name, email);
		} else {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String p1 = request.getParameter("p1");
			String p2 = request.getParameter("p2");
			String p3 = request.getParameter("p3");
			String phone = p1 + "-" + p2 + "-" + p3;
			memberPwd = findPwdProcSvc.getMemberPPwd(id ,name, phone);
		}
		
		if (memberPwd != null) {
			request.setAttribute("memberPwd", memberPwd);
			forward.setPath("find_pwd.jsp");
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('일치하는 정보가 없습니다.');");
			out.println("location.replace('find_pwd.find');");
			out.println("</script>");
			
		}
		
		return forward;
	}
}
