package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AMemViewAction implements action.Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		
		AMemViewSvc aMemViewSvc = new AMemViewSvc();
		AddrInfo addr = aMemViewSvc.getBasicAddr(id);
		MemberInfo member = aMemViewSvc.getMember(id);
		request.setAttribute("member", member);
		request.setAttribute("addr", addr);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("member/a_member_view.jsp");
		return forward;
	}
}
