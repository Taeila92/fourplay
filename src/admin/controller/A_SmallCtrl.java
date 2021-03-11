package admin.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import admin.action.*;
import vo.*;

@WebServlet("*.asmall")
public class A_SmallCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public A_SmallCtrl() {
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
			case "/brd_list.asmall" :		// 게시판 목록 보기
//				action = new A_SamllListAction();
				break;
				
			case "/brd_form.anotice" :		// 게시판 목록 보기
				action = new A_NoticeFormAction();
				break;
				
			case "/brd_view.anotice" :		// 게시판 목록 보기
				action = new A_NoticeViewAction();
				break;	
				
			case "/brd_proc.anotice" :		// 게시판 목록 보기
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
