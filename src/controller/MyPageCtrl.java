package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import action.*;
import vo.*;

@WebServlet("*.mpg")
public class MyPageCtrl extends HttpServlet {
   private static final long serialVersionUID = 1L;
    public MyPageCtrl() {
        super();
    }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       request.setCharacterEncoding("utf-8");
      String requestUri = request.getRequestURI();
      String contextPath = request.getContextPath();
      String command = requestUri.substring(contextPath.length());
      ActionForward forward = null;
      Action action = null;

      HttpSession session = request.getSession();
      MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
      
      switch (command) {
		case "/order_list.mpg" :      // 회원 주문내역 보기
		if(loginMember != null) {   // 로그인한 상태이면
		   action = new OrdListAction();
		}else {
		   response.sendRedirect("login_form.jsp?ismember=n");
		    }
		    break;
		case "/non_order_list.mpg" :   // 비회원 주문조회
		    action = new NonOrdAction();
		    break;
		case "/order_detail.mpg" :   // 회원 주문 상세내역 보기
		    action = new OrdDetailAction();
		    break;
		case "/non_order_detail.mpg" :   // 비회원 주문 상세내역 보기
		    action = new NonDetailAction();
		    break;
		case "/mypage.mpg" :	// 마이페이지 화면
			action = new MyPageAction();
		 	break;
		case "/member_info.mpg" :	// 회원 정보 수정 화면
			action = new MemberInfoAction();
			break;
		case "/member_proc.mpg" :	// 회원 정보 수정 기능(미완성)
			action = new MemberProcAction();
			break;
		case "/mypage_pwd.mpg" :	// 회원 정보 삭제 화면
			action = new MyPagePwdAction();
			break;
		case "/member_del_proc.mpg" :	// 회원 정보 삭제 처리 기능 
			action = new MemDelProcAction();
			break;
		case "/addr_view.mpg" :	// 주소록 화면
			action = new AddrViewAction();
			break;
		case "/addr_del.mpg" :	// 주소록 삭제 기능
			action = new AddrDelAction();
			break;
		case "/addr_form.mpg" :	// 주소록 추가 화면
			action = new AddrFormAction();
			break;
		case "/addr_in_proc.mpg" :	// 주소록 추가 기능
			action = new AddrInProcAction();
			break;
		case "/point_list.mpg" :	// 포인트 내역 화면
			action = new PointListAction();
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