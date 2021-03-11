package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AMemDetailAction implements action.Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		
		AMemDetailSvc aMemDetailSvc = new AMemDetailSvc();
		AddrInfo addr = aMemDetailSvc.getBasicAddr(id);
		MemberInfo member = aMemDetailSvc.getMember(id);
		request.setAttribute("member", member);
		request.setAttribute("addr", addr);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("member/a_member_detail.jsp");
		return forward;
	}
}
