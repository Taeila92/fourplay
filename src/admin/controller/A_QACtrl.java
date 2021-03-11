package admin.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import admin.action.*;
import vo.*;

@WebServlet("*.aqna")
public class A_QACtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public A_QACtrl() {
        super();
    }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestUri.substring(contextPath.length());

		ActionForward forward = null;
		A_Action action = null;
System.out.println(command);
		switch (command) {
			case "/admin/brd_list.aqna" : case "/admin/admin/brd_list.aqna"	 : 		// qna 게시판 목록 보기
				action = new A_QAListAction();
				break;
				
			case "/admin/brd_form.aqna" : case "/admin/admin/brd_form.aqna"	 :		// qna 글작성 폼
				action = new A_QAFormAction();
				break;
				
			case "/admin/brd_view.aqna" : case "/admin/admin/brd_view.aqna"	 :		// qna 보기
				action = new A_QAViewAction();
				break;	
				
			case "/admin/brd_proc.aqna" : case "/admin/admin/brd_proc.aqna"	 :		// qna 등록/수정/삭제 기능
				action = new A_QAProcAction();
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
