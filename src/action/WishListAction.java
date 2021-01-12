package action;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import svc.*;
import vo.*;

public class WishListAction implements Action {
	// 장바구니에서 보여줄 해당 사용자의 장바구니 목록을 가져오는 클래스
			public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				request.setCharacterEncoding("utf-8");
				ArrayList<CartInfo> wishList = new ArrayList<CartInfo>();

				String where = "";
				HttpSession session = request.getSession();
				MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
				where = " and w.ml_id = '" + loginMember.getMlid();

				WishListSvc wishListSvc = new WishListSvc();
				wishList = wishListSvc.getWishList(where);
				request.setAttribute("wishList", wishList);
				
				ActionForward forward = new ActionForward();
				forward.setPath("/member/wish_list.jsp");	// 이동할 URL 지정
				return forward;
			}
	}