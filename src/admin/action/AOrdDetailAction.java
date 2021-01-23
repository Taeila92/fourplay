package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AOrdDetailAction implements action.Action {	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		System.out.println("AOrdDetailAction");
		ActionForward forward = new ActionForward();
		OrdListInfo detailInfo = new OrdListInfo();
		String olid = request.getParameter("olid");
		
		AOrdListSvc aOrdListSvc = new AOrdListSvc();
		detailInfo = aOrdListSvc.getOrd(olid);
		
		request.setAttribute("detailInfo", detailInfo);
		forward.setPath("order/a_order_detail.jsp");
		
		System.out.println("AOrdDetailAction");
		
		return forward;
	}
}
