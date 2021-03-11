package admin.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import admin.action.*;
import vo.*;

@WebServlet("*.anotice")
public class A_NoticeCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public A_NoticeCtrl() {
        super();
    }

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestUri.substring(contextPath.length());
		System.out.println(command);
		ActionForward forward = null;
		A_Action action = null;

		switch (command) {
			case "/admin/bbs_list.anotice" : case "/admin/admin/bbs_list.anotice"	 :		// 공지사항 목록 보기
				action = new A_NoticeListAction();
				break;
				
			case "/admin/bbs_form.anotice" : case "/admin/admin/bbs_form.anotice"	 :		// 공지사항 글 작성/수정 폼
				action = new A_NoticeFormAction();
				break;
				
			case "/admin/bbs_view.anotice" : case "/admin/admin/bbs_view.anotice"	 :		// 공지사항 글 화면
				action = new A_NoticeViewAction();
				break;	
				
			case "/admin/bbs_proc.anotice" : case "/admin/admin/bbs_proc.anotice"	 :		// 공지사항 글 작성/수정/삭제 기능
				action = new A_NoticeProcAction();
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
