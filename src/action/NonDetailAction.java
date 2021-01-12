package action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import svc.*;
import vo.*;

public class NonDetailAction implements Action{	// 로그인 여부와 관계없이 비회원의 주문 상세내역을 가져와 연결하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		OrdListInfo detailInfo = new OrdListInfo();
		request.setCharacterEncoding("utf-8");
		String olid = request.getParameter("olid");
		String bname = request.getParameter("bname");
		String where = "";
		HttpSession session = request.getSession();
		System.out.println("nondetailaction");
		where += " and ol_ismember = 'n' and ol_bname ='" +bname+ "' ";
		OrdListSvc ordListSvc = new OrdListSvc();
		detailInfo = ordListSvc.getOrd(olid, where);
		request.setAttribute("detailInfo", detailInfo);
		forward.setPath("/member/order_detail.jsp");
			
		return forward;
	}
}
