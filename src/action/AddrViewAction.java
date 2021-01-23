package action;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import svc.*;
import vo.*;

public class AddrViewAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ArrayList<AddrInfo> addrList = new ArrayList<AddrInfo>();
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		AddrViewSvc addrViewSvc = new AddrViewSvc();
		
		String uid = loginMember.getMlid();
		addrList = addrViewSvc.getAddrList(uid);
		
		request.setAttribute("addrList", addrList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/addr_view.jsp");
		return forward;
	}
}
