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
// ���� ��ǰ���� ��ɿ� ���� ��û�� ó���ϴ� ��Ʈ�ѷ� ������ Ŭ����
	private static final long serialVersionUID = 1L;

    public AProductCtrl() {
        super();
    }

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// ������� ��û�� get�̵� post�̵� ��� ó���ϴ� �޼ҵ�
		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestUri.substring(contextPath.length());

		ActionForward forward = null;
		Action action = null;

		// ������� ��û ������ ���� ���� �ٸ� action�� ����
		switch (command) {
			case "/pdt_in_form.pdta" :		// ��ǰ ��� ��
//				action = new APdtInFormAction();	break;
			case "/pdt_in_proc.pdta" :		// ��ǰ ��� ó��
	//			action = new APdtInProcAction();	break;
			case "/pdt_list.pdta" :			// ��ǰ ��� ȭ��
		//		action = new APdtListAction();		break;
			case "/pdt_view.pdta" :			// ��ǰ ���� ȭ��
//				action = new APdtViewAction();		break;
			case "/pdt_up_form.pdta" :		// ��ǰ ���� ��
//				action = new APdtUpFormAction();	break;
			case "/pdt_up_proc.pdta" :		// ��ǰ ���� ó��
//				action = new APdtUpProcAction();	break;
			case "/pdt_del_proc.pdta" :		// ��ǰ ���� ó��
//				action = new APdtDelProcAction();	break;
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