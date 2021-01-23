package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AdmJoinAction implements action.Action {	
// 로그인한 계정이 super admin임을 검사하고 관리자 계정 생성 화면으로 이동시키는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
		AdmJoinSvc admJoinSvc = new AdmJoinSvc();
		boolean isSA = admJoinSvc.isSA(adminMember);
		System.out.println(isSA);
		ActionForward forward = new ActionForward();
		
		if(isSA) {
			forward.setPath("admin/admin_join.jsp");	// 이동할 URL 지정
		}
		return forward;
	}
}
