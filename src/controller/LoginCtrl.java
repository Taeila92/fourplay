package controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;	
import vo.*;	

@WebServlet("/login")
public class LoginCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public LoginCtrl() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String uid = request.getParameter("uid");
		String pwd = request.getParameter("pwd");
		
		LoginSvc loginSvc = new LoginSvc();
		MemberInfo loginMember = loginSvc.getLoginMember(uid, pwd);
		
		if (loginMember != null) {	
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			response.sendRedirect("index.jsp");
		} else {	
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			out.println("alert('로그인에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
