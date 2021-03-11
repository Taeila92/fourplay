package admin.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import admin.action.*;
import vo.*;

@WebServlet("*.afaq")
public class A_FaqCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public A_FaqCtrl() {
        super();
    }

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestUri.substring(contextPath.length());

		ActionForward forward = null;
		A_Action action = null;

		switch (command) {
			case "/admin/bbs_list.afaq" : case "/admin/admin/bbs_list.afaq"	 :	// 게시판 목록 보기
				action = new A_FaqListAction();
				break;
				
			case "/admin/bbs_form.afaq" : case "/admin/admin/bbs_form.afaq"	 :		// 게시판 목록 보기
				action = new A_FaqFormAction();
				break;
				
			case "/admin/bbs_view.afaq" : case "/admin/admin/bbs_view.afaq"	 :		// 게시판 목록 보기
				action = new A_FaqViewAction();
				break;	
				
			case "/admin/bbs_proc.afaq" : case "/admin/admin/bbs_proc.afaq"	 :		// 게시판 목록 보기
				action = new A_FaqProcAction();
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
