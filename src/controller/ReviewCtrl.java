package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.review")
public class ReviewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReviewCtrl() {
        super();
    }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestUri.substring(contextPath.length());
		ActionForward forward = null;
		Action action = null;
		System.out.println(command);
		switch (command) {
			case "/product/review_list.review" : case "/review_list.review" :
				action = new ReviewListAction();
				break;
			case "/product/review_form.review" : case "/review_form.review" :
				action = new ReviewFormAction();
				break;
			case "/product/review_proc.review" : case "/review_proc.review" :
				action = new ReviewProcAction();
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
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
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
