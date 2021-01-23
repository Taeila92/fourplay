package admin.action;

import javax.servlet.http.*;	// 받아 온 request와 response를 위해 import
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class APdtInFormAction implements action.Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		APdtInFormSvc pdtInFormSvc = new APdtInFormSvc();
		// 대분류, 소분류, 브랜드 목록을 가져오기 위한 Svc클래스
		ArrayList<CataBigInfo> cataBigList = pdtInFormSvc.getCataBigList();			// 대분류 목록
		ArrayList<CataSmallInfo> cataSmallList = pdtInFormSvc.getCataSmallList();	// 소분류 목록

		if (cataBigList != null && cataSmallList != null) {
			request.setAttribute("cataBigList", cataBigList);
			request.setAttribute("cataSmallList", cataSmallList);
			// 등록 폼에서 보여줄 분류들과 브랜드 목록을 request객체에 속성으로 담음
		} else {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('잘못된 경로로 들어오셨습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		forward.setPath("/admin/product/product_in_form.jsp");	// 이동할 URL 지정
		return forward;
	}
}