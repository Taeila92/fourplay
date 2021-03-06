package admin.action;

import java.io.PrintWriter;	// 등록 실패시 자바스크립트 사용을 위한 import
import javax.servlet.*;
import javax.servlet.http.*;

import java.net.*;
import admin.svc.*;
import vo.*;

public class A_FaqProcAction implements A_Action {
// 게시글 등록 처리 클래스
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("A_FaqProcAction");
		ActionForward forward = null;
		HttpSession session = request.getSession();
		AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
		// 등록시 작성자, 수정/삭제 시 권한 체크용으로 로그인 정보를 담음
		request.setCharacterEncoding("utf-8");
		String wtype = request.getParameter("wtype");
		FaqInfo faqInfo = new FaqInfo();
		// 사용자가 입력한 데이터(게시글)들을 저장할 인스턴스
		int idx = Integer.parseInt(request.getParameter("idx"));

		if (wtype.equals("in") || wtype.equals("up")) {
		// 글등록이나 수정일 경우 게시글 데이터들을 받아옴
			faqInfo.setFq_writer(adminMember.getAl_id());
			faqInfo.setFq_title(request.getParameter("title"));
			faqInfo.setFq_content(request.getParameter("content"));
			// 받아 온 데이터들을 하나의 게시물을 저장하는 freeInfo 인스턴스에 setter를 이용하여 담음
		}
		
		if (wtype.equals("del") || wtype.equals("up")) {
		// 글삭제나 수정일 경우 게시글 번호를 받아옴
			faqInfo.setFq_idx(idx);
		}

		A_FaqProcSvc afaqProcSvc = new A_FaqProcSvc();
		// 비즈니스 로직을 처리할 서비스 클래스의 인스턴스 생성
		boolean isSuccess = false;	// 쿼리(등록, 수정, 삭제) 성공여부를 저장할 변수
		String link = null;			// 작업(등록, 수정, 삭제) 후 이동할 URL을 저장할 변수

		if (wtype.equals("in")) {
			faqInfo.setFq_status("a");
			
			//faqInfo.setFq_ip(request.getRemoteAddr());	// 등록자 IP주소 지정
			isSuccess = afaqProcSvc.afaqInsert(faqInfo);
			link = "bbs_list.afaq";

		} else if (wtype.equals("up")) {
			isSuccess = afaqProcSvc.afaqUpdate(faqInfo);
			int cpage = Integer.parseInt(request.getParameter("cpage"));
			String args = "?cpage=" + cpage;
			String schtype = request.getParameter("schtype");
			String keyword = request.getParameter("keyword");
			if (keyword != null && !keyword.equals("")) {
				args += "&schtype=" + schtype + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
			}
			link = "bbs_view.afaq" + args + "&idx=" + faqInfo.getFq_idx();

		} else {
			if (adminMember != null ) {
				faqInfo.setFq_writer(adminMember.getAl_id());
			}
			isSuccess = afaqProcSvc.afaqDelete(idx, faqInfo);
			if (!isSuccess) {	// 삭제 실패시
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('잘못된 접근입니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			}
			link = "bbs_list.afaq";
		}

		if (isSuccess) {	// 성공시
			forward = new ActionForward();
			forward.setRedirect(true);	// 이동방식을 redirect로 하겠다는 의미
			forward.setPath(link);
		}

		return forward;
	}
}
