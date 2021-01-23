package action;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import svc.*;
import vo.*;

public class AddrInProcAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid");
		String zip = request.getParameter("zip");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		
		
		AddrInfo addr = new AddrInfo();
		addr.setMa_zip(zip);
		addr.setMa_addr1(addr1);
		addr.setMa_addr2(addr2);

		response.setContentType("text/html; charset=utf-8");

		AddrtInProcSvc addrtInProcSvc = new AddrtInProcSvc();
		int result = addrtInProcSvc.addrInsert(addr, uid);
		if (result == 0) {	
			PrintWriter out = response.getWriter();
			response.setContentType("text/html; charset=utf-8");
			out.println("<script>");
			out.println("alert('주소등록에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		ActionForward forward = new ActionForward();
		forward.setPath("/mypage.mpg");	
		forward.setRedirect(true);
		return forward;
	}
}
