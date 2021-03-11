package action;

import javax.servlet.http.*;
import vo.ActionForward;

public class QAPwdAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		forward.setPath("/customer/qna_pwd.jsp");
		return forward;
	}
}
