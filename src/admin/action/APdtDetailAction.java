package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class APdtDetailAction implements action.Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		APdtDetailSvc pdtViewSvc = new APdtDetailSvc();
		String id = request.getParameter("id");
		PdtInfo pdtInfo = pdtViewSvc.getPdtInfo(id);
		ArrayList<PdtSizeInfo> pdtSizeList = new ArrayList<PdtSizeInfo>();
		pdtSizeList = pdtViewSvc.getPdtSizeList(id);
		// 지정한 아이디에 해당하는 상품의 정보들을 PdtInfo형 인스턴스로 받아 옴
		request.setAttribute("pdtInfo", pdtInfo);
		request.setAttribute("pdtSizeList", pdtSizeList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/admin/product/product_detail.jsp");

		return forward;
	}
}
