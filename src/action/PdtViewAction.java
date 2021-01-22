package action;

import javax.servlet.http.*;
import java.io.PrintWriter;
import java.util.*;
import svc.*;
import vo.*;

public class PdtViewAction implements Action {
   public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      System.out.println("PdtViewAction");
      PdtViewSvc pdtViewSvc = new PdtViewSvc();
      String id = request.getParameter("id");
      PdtInfo pdtInfo = pdtViewSvc.getPdtInfo(id);
      // 지정한 아이디에 해당하는 상품의 정보들을 PdtInfo형 인스턴스로 받아 옴
      
      request.setCharacterEncoding("utf-8");
      int rCpage = 1, rPcnt, rSpage, rEpage, rCnt, rBsize = 10, rPsize = 5;
      if (request.getParameter("rCpage") != null)
         rCpage = Integer.parseInt(request.getParameter("rCpage"));
      
      ReviewListSvc reviewListSvc = new ReviewListSvc();
      ArrayList<ReviewInfo> articleList = new ArrayList<ReviewInfo>();
      rCnt = reviewListSvc.getArticleCount(id);
      articleList = reviewListSvc.getArticleList(id, rCpage, rPsize);

      rPcnt = rCnt / rPsize;
      if (rCnt % rPsize > 0)   rPcnt++;
      rSpage = (rCpage - 1) / rPsize * rPsize + 1;
      rEpage = rSpage + rPsize - 1;
      if (rEpage > rPcnt)   rSpage = rPcnt;

      ReviewPageInfo reviewPageInfo = new ReviewPageInfo();
      reviewPageInfo.setrCpage(rCpage);      // 현재 페이지 번호
      reviewPageInfo.setrCnt(rCnt);         // 전체 게시글 수
      reviewPageInfo.setrPcnt(rPcnt);         // 전체 페이지 수
      reviewPageInfo.setrSpage(rSpage);      // 블록 시작 페이지 번호
      reviewPageInfo.setrEpage(rEpage);      // 블록 종료 페이지 번호
      reviewPageInfo.setrBsize(rBsize);
      
      request.setAttribute("pdtInfo", pdtInfo);
      request.setAttribute("articleList", articleList);
      request.setAttribute("reviewPageInfo", reviewPageInfo);

      ActionForward forward = new ActionForward();
      forward.setPath("/product/product_detail.jsp");

      return forward;
   }
}