package action;

import javax.servlet.http.*;
import java.io.*;
import svc.*;
import vo.*;

public class AddrFormAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/addr_form.jsp");
		return forward;
	}
}
