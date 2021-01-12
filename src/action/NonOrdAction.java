package action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import svc.*;
import vo.*;

public class NonOrdAction implements Action {	// 로그인 여부와 관계없이 비회원 주문내역을 받아와 연결하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		ArrayList<OrdListInfo> ordList = new ArrayList<OrdListInfo>();
		OrdListInfo ordInfo = new OrdListInfo();
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String where = "";
		String bname = request.getParameter("bname");
		String olid = request.getParameter("olid");
		boolean isSuccess = false;
		
		if(bname != null && olid != null) {	// 비회원 주문조회 정보가 모두 입력되었으면
			OrdListSvc ordListSvc = new OrdListSvc();
			isSuccess = ordListSvc.chkNonOrd(olid, bname);
			System.out.println(isSuccess);
			if(isSuccess) {		// 입력한 값에 해당하는 비회원 주문이 있으면
				where += " and ol_bname = '" + bname + "' and ol_ismember = 'n' ";
				ordInfo = ordListSvc.getOrd(olid, where);
				request.setAttribute("ordInfo", ordInfo);
				forward.setPath("/member/non_order_list.jsp");
			}else {
				out.println("<script>");
				out.println("alert('입력한 정보에 해당하는 주문이 없습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
		} else {	// 비회원 주문조회 정보를 입력하지 않았을 경우
			out.println("<script>");
			out.println("alert('정보를 입력하세요.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		return forward;
	}
}
