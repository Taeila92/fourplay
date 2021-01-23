package admin.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.Action;
import admin.action.*;
import vo.*;

@WebServlet("*.adm")
public class AdmCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public AdmCtrl() {
        super();
    }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestUri.substring(contextPath.length());
		System.out.println(command);
		
		ActionForward forward = null;
		Action action = null;
//		HttpSession session = request.getSession();
//		AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
		
		switch (command) {
			case "/admin/admin_list.adm" :	case "/admin/admin/admin_list.adm" :	// 관리자 목록 화면
				action = new AdmListAction();
				break;
			case "/admin/admin_join.adm" :	case "/admin/admin/admin_join.adm" : 	// 관리자 계정 생성 화면
				action = new AdmJoinAction();
				break;
			case "/admin/admin_form.adm" :	case "/admin/admin/admin_form.adm" :	// 관리자 계정 수정 화면
				action = new AdmFormAction();
				break;
			case "/admin_del.adm" : 	case "/admin/admin_del.adm" :	case "/admin/admin/admin_del.adm" :		// 관리자 계정 수정 화면
				action = new AdmDelAction();
				break;
			case "/admin/admin_proc.adm" :	case "/admin/admin/admin_proc.adm" :	// 관리자 계정 수정/삭제, 상태변경 처리 기능 
				action = new AdmProcAction();
				break;
		}
		try {
			forward = action.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = 
					request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}

