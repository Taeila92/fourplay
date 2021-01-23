package admin.action;

import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import admin.svc.*;
import vo.*;

public class AOrdPdtAction implements action.Action {	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AOrdPdtAction");
		request.setCharacterEncoding("utf-8");
		AOrdPdtSvc aOrdPdtSvc = new AOrdPdtSvc();
		String id = request.getParameter("id");
		PdtInfo pdtInfo = aOrdPdtSvc.getPdtInfo(id);
		request.setAttribute("pdtInfo", pdtInfo);
		ActionForward forward = new ActionForward();
		forward.setPath("/admin/order/a_product_detail.jsp");

		return forward;
	}
}
