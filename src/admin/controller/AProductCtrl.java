package admin.controller;

import java.io.IOException;
import javax.servlet.http.*;

import action.Action;
import action.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import admin.action.*;
import vo.*;

@WebServlet("*.pdta")
public class AProductCtrl extends HttpServlet {
// 어드민 상품관련 기능에 대한 요청을 처리하는 컨트롤러 서블릿 클래스
	private static final long serialVersionUID = 1L;

    public AProductCtrl() {
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
		// 사용자의 요청 종류에 따라 각각 다른 action을 취함
		switch (command) {
			case "/admin/pdt_in_form.pdta" :		// 상품 등록 폼
				action = new APdtInFormAction();	break;
			case "/admin/pdt_in_proc.pdta" :		// 상품 등록 처리
				action = new APdtInProcAction();	break;
			case "/admin/pdt_list.pdta" :			// 상품 목록 화면
				action = new APdtListAction();		break;
			case "/admin/pdt_detail.pdta" :			// 상품 보기 화면
				action = new APdtDetailAction();	break;
			case "/admin/pdt_up_form.pdta" :		// 상품 수정 폼
				action = new APdtUpFormAction();	break;
			case "/admin/pdt_up_proc.pdta" :		// 상품 수정 처리
				action = new APdtUpProcAction();	break;
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