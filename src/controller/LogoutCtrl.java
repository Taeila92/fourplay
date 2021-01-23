package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/logout")
public class LogoutCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LogoutCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		// 세션에 있는 모든 속성(attribute)을 삭제
		// 로그인/아웃과 상관없는 세션 속성이 있을 경우 
		// removeAttribute()로 특정 속성만 삭제하면 됨
		response.sendRedirect("index.jsp");
	}
}
