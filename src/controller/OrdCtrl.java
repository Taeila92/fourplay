package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.CartInAction;
import action.CartListAction;
import action.PdtListAction;
import action.PdtViewAction;
import vo.ActionForward;

@WebServlet("*.ord")
public class OrdCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public OrdCtrl() {
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
