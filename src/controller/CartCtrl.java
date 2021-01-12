package controller;

import java.io.IOException;
import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import action.*;
import vo.*;

@WebServlet("*.crt")
public class CartCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CartCtrl() {
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
			case "/cart_in.crt" :			// 장바구니 등록 기능
				action = new CartInAction();		break;
			case "/cart_list.crt" :			// 장바구니 화면
				action = new CartListAction();		break;
			case "/wish_in.crt" :			// 위시리스트 등록기능
				action = new WishInAction();		break;
			case "/wish_del.crt" :			// 위시리스트 삭제기능
				action = new WishDelAction();		break;
			case "/wish_list.crt" :			// 위시리스트 화면
				action = new WishListAction();		break;
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
