package action;

import javax.servlet.http.*;
import java.util.*;	
import java.io.*;
import svc.*;
import vo.*;

public class PointListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ArrayList<MemberInfo> pointList = new ArrayList<MemberInfo>();
		HttpSession session = request.getSession();
		MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
		String uid = loginMember.getMlid();
		
		
		PointListSvc pointListSvc = new PointListSvc();
		pointList = pointListSvc.getPointList(uid);
		request.setAttribute("pointList", pointList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("member/point_list.jsp");
		return forward;
	}
}
