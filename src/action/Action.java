package action;

import javax.servlet.http.*;
import vo.ActionForward;

public interface Action {
	ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
