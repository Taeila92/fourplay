package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class A_QAViewAction implements A_Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));	// 글번호
		String mlid = request.getParameter("mlid");	// 작성자(회원id)
		int cpage = Integer.parseInt(request.getParameter("cpage"));// 현재 페이지번호

		String schtype = request.getParameter("schtype");	// 검색조건
		String keyword = request.getParameter("keyword");	// 검색어
		
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		
		if(loginMember != null) {	// 로그인하지 않았거나 해당 글을 작성한 회원이 아니면
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('권한이 없습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			A_QAViewSvc aqaViewSvc = new A_QAViewSvc();
			QAInfo article = aqaViewSvc.getArticle(idx);
			request.setAttribute("article", article);
			forward.setPath("/admin/bbs/a_aqa_view.jsp");
		}
		
		return forward;
	}
}
