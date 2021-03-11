package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.find")
public class FindCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FindCtrl() {
        super();
    }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 사용자의 요청이 get이든 post이든 모두 처리하는 메소드
		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestUri.substring(contextPath.length());
		
		ActionForward forward = null;
		Action action = null;
		
		switch (command) {
			 case "/find_id.find" :	// 아이디 찾는 화면
				action = new FindIdAction();
				break;
			 case "/find_id_proc.find" :	// 아이디 찾는 기능
				action = new FindIdProcAction();
					break;
			 case "/find_pwd.find" :	// 비밀번호 찾는 폼
				action = new FindPwdAction();
				break;
			 case "/find_pwd_proc.find" :	// 비밀번호 찾는 기능
				action = new FindPwdProcAction();

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
