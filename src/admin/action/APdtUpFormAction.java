package admin.action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import admin.svc.*;
import vo.*;

public class APdtUpFormAction implements action.Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		APdtInFormSvc aPdtInFormSvc = new APdtInFormSvc();
		// 대분류, 소분류, 브랜드 목록을 가져오기 위한 Svc클래스
		ArrayList<CataBigInfo> cataBigList = aPdtInFormSvc.getCataBigList();			// 대분류 목록
		ArrayList<CataSmallInfo> cataSmallList = aPdtInFormSvc.getCataSmallList();	// 소분류 목록
		// 분류와 브랜드 목록들은 상품등록의 PdtInFormSvc를 이용하여 가져옴
		APdtDetailSvc aPdtDetailSvc = new APdtDetailSvc();
		String id = request.getParameter("id");
		PdtInfo pdtInfo = aPdtDetailSvc.getPdtInfo(id);
		// 상품정보를 상품보기의 PdtViewSvc를 이용하여 받아 옴

		request.setAttribute("cataBigList", cataBigList);
		request.setAttribute("cataSmallList", cataSmallList);
		request.setAttribute("pdtInfo", pdtInfo);
		// 수정 폼에서 보여줄 분류들과 브랜드 목록, 상품정보를 request객체에 속성으로 담음

		ActionForward forward = new ActionForward();
		forward.setPath("/admin/product/product_up_form.jsp");	// 이동할 URL 지정
		return forward;
	}
}
