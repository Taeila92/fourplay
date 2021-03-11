package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.qna")
public class QACtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public QACtrl() {
        super();
    }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       		request.setCharacterEncoding("utf-8");
    		String requestUri = request.getRequestURI();
    		String contextPath = request.getContextPath();
    		String command = requestUri.substring(contextPath.length());

    		ActionForward forward = null;
    		Action action = null;

    		switch (command) {
    			case "/brd_list.qna" :		// 게시판 목록 보기
    				action = new QAListAction();
    				break;
    			case "/brd_form.qna" :		// 게시글 등록/수정 폼
    				action = new QAFormAction();
    				break;
    			case "/brd_view.qna" :		// 게시글 보기
    				action = new QAViewAction();
    				break;
    			case "/brd_proc.qna" :		// 게시글 처리(등록, 수정, 삭제)
    				action = new QAProcAction();
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
