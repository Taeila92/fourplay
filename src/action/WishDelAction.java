package action;

import javax.servlet.http.*;
import java.io.*;
import svc.*;
import vo.*;

public class WishDelAction implements Action {
// 위시리스트에 선택한 상품정보를 저장하는 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");		// 위시리스트 인덱스

		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		String buyer = loginMember.getMlid();



		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		WishDelSvc wishDelSvc = new WishDelSvc();
		int result = wishDelSvc.wishDelete(id, buyer);
		out.println(result);
		out.close();
		return null; 
	}
}
