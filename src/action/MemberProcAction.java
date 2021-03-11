package action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import svc.*;
import vo.*;

public class MemberProcAction implements Action {
// 회원정보 수정을 처리하는 클래스
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			request.setCharacterEncoding("utf-8");
			ActionForward forward = new ActionForward();
			MemberProcSvc memberProcSvc = new MemberProcSvc();

			String uid 		= request.getParameter("uid");
			String pwd		= request.getParameter("pwd");
			String e1		= request.getParameter("e1");
			String e2		= request.getParameter("e2");
			String p1		= request.getParameter("p1");
			String p2		= request.getParameter("p2");
			String p3		= request.getParameter("p3");
			String phone = p1 + "-" + p2 + "-" + p3;
			String email = e1 + "@" + e2;
			
//			String zip		= request.getParameter("zip");
//			String addr1	= request.getParameter("addr1");
//			String addr2	= request.getParameter("addr2");
			
			MemberInfo loginMember = new MemberInfo();
			loginMember.setMlpwd(request.getParameter("pwd"));
			loginMember.setMlemail(request.getParameter("email"));
			loginMember.setMlphone(request.getParameter("phone"));
			
//			AddrInfo addr = new AddrInfo();
//			addr.setMa_zip(request.getParameter("zip"));
//			addr.setMa_addr1(request.getParameter("addr1"));
//			addr.setMa_addr2(request.getParameter("addr2"));
			
			
			
			boolean isSuccess = false;
			isSuccess = memberProcSvc.memberUpdate(loginMember, uid);
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			if (isSuccess) {	// 성공시
				HttpSession session = request.getSession();
				session.setAttribute("loginMember", loginMember);
				out.println("<script>");
				out.println("alert('정보를 수정했습니다.');");
				out.println("location.href('mypage.mpg');");
				out.println("</script>");
				out.close();
			} else {	
				out.println("<script>");
				out.println("alert('정보 수정에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
		return forward;
	}
}
