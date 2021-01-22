<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<ReviewInfo> articleList = (ArrayList<ReviewInfo>)request.getAttribute("articleList");
ReviewPageInfo reviewPageInfo = (ReviewPageInfo)request.getAttribute("reviewPageInfo");

MemberInfo login = (MemberInfo)session.getAttribute("loginMember");
int rPsize = 5;
if(request.getParameter("rPsize") != null)  rPsize = Integer.parseInt(request.getParameter("rPsize"));
int rCpage   = reviewPageInfo.getrCpage();   // 현재 페이지 번호
if(request.getParameter("rCpage") != null)  rCpage = Integer.parseInt(request.getParameter("rCpage"));
int rPcnt   = reviewPageInfo.getrPcnt();   // 전체 페이지 수
int rBsize   = reviewPageInfo.getrBsize();   // 블록 페이지 개수
int rSpage   = reviewPageInfo.getrSpage();   // 블록 시작 페이지 번호
int rEpage   = reviewPageInfo.getrEpage();   // 블록 종료 페이지 번호
int rCnt   = reviewPageInfo.getrCnt();   // 검색된 게시물 개수

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.wrapper {width:100%; margin:40px 0; }
.rTitle {width:100%; height:30px;width:42%;}
.rTitle li, .rContent li {float:left; }
.rTitle .liTitle { text-align:center;}
.rContent .liTitle { text-align:left;}
.rContent {width:100%; height:50px;}
.nContent {
   width:100%; height:70px; 
   display:block; text-align:center; font-size:13px; margin:15px 0 40px 0;
}

.seq { width:10%; text-align:center;}
.writer { width:12%; text-align:center;}
.date { width:16%; text-align:center;}
.rate { width:18%; text-align:center;}

.liBtn {float:left; width:50px; height:50px; }
.rBtn {width:45px; height:30px; background-color:lightgray; }
.rBtn:first-child {margin-right:15px;}

.rPaging {display:block; text-align:center; margin:40px 0; }

.pointer {cursor:pointer;}

</style>
<script>
var flag = false;
function showContent(idx){
   flag = !flag;
   var idx = document.getElementById(idx);
   if(flag) {
      idx.style.display="none";
   } else {
      idx.style.display="block";
   }
}
function notCool(idx) {
   if (confirm("정말 삭제하시겠습니까?")) {
      location.href="review_proc.review?wtype=del&idx=" + idx;
   }
}
</script>
</head>
<body>
<div class="wrapper" >
   <div class="reviewList">
   <ul class="rTitle">
      <li class="seq">번호</li>
      <li class="liTitle">제목</li>
      <li class="writer">작성자</li>
      <li class="date">작성일</li>
      <li class="rate">평점</li>
   </ul>
<%
int seq = rCnt;
if(articleList.size() > 0 && rCnt > 0){ 
   for(int i = 0; i < articleList.size(); i++){
      int idx = articleList.get(i).getRl_idx();
%>
   <ul class="rContent">
      <li class="seq"><%=seq-- %></li>
      <li class="liTitle"><span class="pointer" onclick="showContent(<%=idx%>);"><%=articleList.get(i).getRl_title() %></span></li>
      <li class="writer"><%=articleList.get(i).getMl_id() %></li>
      <li class="date"><%=articleList.get(i).getRl_date().substring(0, 10) %></li>
      <li class="rate">
<%
      for(int j = 0; j < articleList.get(i).getRl_rate(); j++){
%>
         <img src="images/star.png" width="12px"/>
<%
      } 
%>
      </li>
   </ul>
   <ul class="review" id="<%=idx %>">
      <li><%=articleList.get(i).getRl_content() %></li>
<%
      if(login != null && login.getMlid().equals(articleList.get(i).getMl_id())){
%>
      <li class="liBtn"><input type="button" value="수정"  class="rBtn" onclick="location.href='review_form.review?idx=<%=idx %>';"/></li>
      <li class="liBtn"><input type="button" value="삭제"  class="rBtn" onclick="notCool(<%=idx %>);"/></li>
   </ul>
<%
      }
   }
} else {%>
   <ul class="nContent">
      <li>리뷰가 없습니다.</li>
   </ul>
<%} %>
   </div>
   <div class="rPaging">
<%
if (rCnt > 0) {
   rPcnt = rCnt / 10;
   if (rCnt % 10 > 0)   rPcnt++;

   if (rCpage == 1) {
      out.println("<<&nbsp;&nbsp;<&nbsp;&nbsp;");
   } else {
      out.print("<a href='bbs_list.notice?cpage=1"  + "'>");
      out.println("<<</a>&nbsp;&nbsp;");
      out.print("<a href='bbs_list.notice?cpage=" + (rCpage - 1)  + "'>");
      out.println("<</a>&nbsp;&nbsp;");
   }

   for (int i = 1, j = rSpage ; i <= 10 && j <= rPcnt ; i++, j++) {
      if (rCpage == j) {
         out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
      } else {
         out.print("&nbsp;<a href='bbs_list.notice?cpage=" + j  + "'>");
         out.println(j + "</a>&nbsp;");
      }
   }

   if (rCpage == rPcnt) {
      out.println("&nbsp;&nbsp;>&nbsp;&nbsp;>>");
   } else {
      out.print("&nbsp;&nbsp;<a href='bbs_list.notice?cpage=" + (rCpage + 1)  + "'>");
      out.println("></a>");
      out.print("&nbsp;&nbsp;<a href='bbs_list.notice?cpage=" + rPcnt  + "'>");
      out.println(">></a>");
   }
}
%>
   </div>
</div>
</body>
</html>