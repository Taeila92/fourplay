package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import admin.svc.*;
import svc.QAViewSvc;
import vo.*;

public class A_QAFormAction implements A_Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");	// 등록(in) / 수정(up) 여부
		ActionForward forward = new ActionForward();

		if (wtype.equals("up")) {//수정이면
			HttpSession session = request.getSession();
			MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
			String uid = null;
			if (loginMember != null)	uid = loginMember.getMlid();
			int idx = Integer.parseInt(request.getParameter("idx"));

			A_QAViewSvc aqaViewSvc = new A_QAViewSvc();
			QAInfo article = aqaViewSvc.getArticle(idx);
			request.setAttribute("article", article);
			forward.setPath("/admin/bbs/a_aqa_form.jsp?idx="+idx);
			
		} else {	//등록이면
			forward.setPath("/admin/bbs/a_aqa_form.jsp");	
		}
		
		return forward;
	}
}