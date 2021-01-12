package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AdmFormAction implements action.Action {	
// 관리자 로그인 상태를 검사하고 관리자 정보 수정화면으로 이동시키는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		
		System.out.println("AdmFormAction");
		
		HttpSession session = request.getSession();
		AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
		
		if(adminMember != null) {	// 관리자 계정으로 로그인된 상태면
			request.setAttribute("adminMember", adminMember);
			forward.setPath("admin/admin_form.jsp");
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
