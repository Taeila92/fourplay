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
		String plid = request.getParameter("id");
		String now = request.getParameter("now");
		String wish = request.getParameter("wish");
		String cnt = request.getParameter("cnt");
		String price = request.getParameter("price");	// 실구매가
		String buyNow = request.getParameter("buyNow"); // 바로구매로 들어왔는지 확인
		String optCnt = request.getParameter("optCnt");
		String optValue = request.getParameter("optValue");
		String args = "?cpage=";
		if(now != null && !now.equals("")) args += "&now=" + now;
		if(cnt != null && !cnt.equals("")) args += "&cnt=" + cnt;
		if(plid != null && !plid.equals("")) args += "&id=" + plid;
		if(price != null && !price.equals("")) args += "&price=" + price;
		if(buyNow != null && !buyNow.equals("")) args += "&buyNow=" + buyNow;
		if(optCnt != null && !optCnt.equals("0")) args += "&optCnt=" + optCnt;
		if(optValue != null && !optValue.equals("")) args += "&optValue=" + optValue;
		
		LoginSvc loginSvc = new LoginSvc();
		MemberInfo loginMember = loginSvc.getLoginMember(uid, pwd);
		if (loginMember != null) {	
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			if(now != null && now.equals("go")) {
				response.sendRedirect("cart_in.crt" + args);
			}else if(wish != null && wish.equals("y")) {
				response.sendRedirect("wish_in.crt" + args);
			}
			else {
				response.sendRedirect("index.jsp");
			}
		} else {	// 일반 회원이 아니면
			AdminInfo adminMember = loginSvc.getAdminMember(uid, pwd);
			if (adminMember != null) {
				HttpSession session = request.getSession();
				session.setAttribute("adminMember", adminMember);
				response.sendRedirect("admin/a_index.jsp");
			} else {	// 일반회원도, 관리자계정도 아니면
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('로그인에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
		}
	}
}
