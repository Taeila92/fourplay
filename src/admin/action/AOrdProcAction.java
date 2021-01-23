package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AOrdProcAction implements action.Action {	
// 주문상태 수정을 처리하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ActionForward");
		request.setCharacterEncoding("utf-8");
		ActionForward forward = new ActionForward();
		AOrdProcSvc aOrdProcSvc = new AOrdProcSvc();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		boolean isSuccess = false;
		
		String idxs = request.getParameter("idxs");	// 주문아이디들
		String st = request.getParameter("st");	// 주문 상태값들
		isSuccess = aOrdProcSvc.chStatus(idxs, st);
		
		if(isSuccess) {		// 상태변경에 성공했다면
			forward.setRedirect(true);
			forward.setPath("ord_list.orda");
		} else {	//상태변경에 실패했다면
			out.println("<script>");
			out.println("alert('주문상태 변경에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return forward;
	}
		
}
