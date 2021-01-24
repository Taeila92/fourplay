package action;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import svc.*;
import vo.*;

public class OrdFormAction implements Action {
// 회원정보와 상품정보를 받아와 주문서 페이지로 연결하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kind = request.getParameter("kind");		// 장바구니 또는 바로 구매를 구분하는 구분자(cart : 장바구니를 통해 구매, direct : 바로 구매)
		String idxs = request.getParameter("idxs");		// 장바구니로 구매시 구매할 상품(들)의 카트인덱스(cl_idx) 번호(들)로 쉼표로 구분됨
		String ismember = request.getParameter("ismember");		
		if(request.getParameter("ismember") == null)	ismember = "n";
		ArrayList<CartInfo> pdtList = new ArrayList<CartInfo>();		// 구매하려는 상품(들)을 담을 ArrayList
		System.out.println("OrdFormAction");
		String where = "";
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		
		if (kind.equals("cart")) {	// 장바구니를 통한 구매일 경우
			String[] arrIdxs = idxs.split(",");
			for (int i = 0 ; i < arrIdxs.length ; i++) {
				where += " or c.cl_idx = " + arrIdxs[i];
			}
			where = " and (" + where.substring(4) + ") ";
			
			if (loginMember == null) {	// 비회원이면
				where += " and c.cl_buyer = '" + session.getId() + "' and c.cl_ismember = 'n' ";
			} else {	// 회원이면
				where += " and c.cl_buyer = '" + loginMember.getMlid() + "' and c.cl_ismember = 'y' ";
			}
			
		}
		OrdFormSvc ordFormSvc = new OrdFormSvc();
		
		if(loginMember != null) {
			MembeViewSvc membeViewSvc = new MembeViewSvc();
			AddrInfo addrInfo = membeViewSvc.getBasicAddr(loginMember.getMlid());

			request.setAttribute("addrInfo", addrInfo);
			
		}
		pdtList = ordFormSvc.getOrdFrmPdtList(kind, where);
		if(pdtList != null) {
			System.out.println("OrdFormAction a");
		}
		request.setAttribute("pdtList", pdtList);
		ActionForward forward = new ActionForward();
		forward.setPath("/order/order_form.jsp?ismember="+ismember);	
		return forward;
	}
}
