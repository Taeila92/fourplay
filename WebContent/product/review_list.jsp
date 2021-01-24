<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<ReviewInfo> articleList = (ArrayList<ReviewInfo>)request.getAttribute("articleList");
ReviewPageInfo reviewPageInfo = (ReviewPageInfo)request.getAttribute("reviewPageInfo");

String plid = request.getParameter("plid");
String plname= request.getParameter("plname");
MemberInfo login = (MemberInfo)session.getAttribute("loginMember");
int rPsize = 5;
if(request.getParameter("rPsize") != null)  rPsize = Integer.parseInt(request.getParameter("rPsize"));
int rCpage	= reviewPageInfo.getrCpage();	// 리뷰 현재 페이지 번호
if(request.getParameter("rCpage") != null)  rCpage = Integer.parseInt(request.getParameter("rCpage"));
int rPcnt	= reviewPageInfo.getrPcnt();	// 리뷰 전체 페이지 수
int rBsize	= reviewPageInfo.getrBsize();	// 리뷰 블록 페이지 개수
int rSpage	= reviewPageInfo.getrSpage();	// 리뷰 블록 시작 페이지 번호
int rEpage	= reviewPageInfo.getrEpage();	// 리뷰 블록 종료 페이지 번호
int rCnt	= reviewPageInfo.getrCnt();		// 검색된 리뷰글 개수

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
/* reset - 태그들 스타일 기본값 초기화 */
*{ padding: 0; margin: 0; }
ul li, ol li{ list-style: none; text-decoration: none; }
a{ text-decoration: none; color: #222; }
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:none;  font-weight:bold;}
a:active { color:#f00; text-decoration:none; }   
a:focus { color:pink; text-decoration:none; }

.wrapper {width:95%; margin:40px auto;}
.rTitle {width:100%; height:30px; border:1px solid white;}
.rTitle li, .rContent li {float:left; border:1px solid white;}
.liTitle {width:39%; }
.rTitle .liTitle { text-align:center;}
.rContent .liTitle { text-align:left;}
.rContent {width:100%; height:50px; border:1px solid white;}
.nContent {
	width:100%; height:70px; 
	display:block; text-align:center; font-size:13px; margin:15px 0 40px 0;
}

.seq { width:10%; text-align:center;}
.writer { width:15%; text-align:center;}
.date { width:16%; text-align:center;}
.rate { width:18%; text-align:center;}

.review {width:80%; height:200px; margin:5px auto; border-bottom:1px solid lightgray;}
.liBtn {float:left; width:50px; height:50px; }
.rBtn {
	width:45px; height:30px; background-color:lightgray; 
	position:relative; left:570px; top:150px;
}
.rBtn:first-child {margin-right:15px;}

.rPaging {display:block; text-align:center; margin:40px 0; }

.pointer {cursor:pointer;}
</style>
<script src="pager.js"></script>
<script>
var flag = true;
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
	if (confirm("정말 삭제하시겠습니까?\n다시 등록할 수 없습니다.")) {
		location.href="review_proc.review?wtype=del&plid=<%=plid%>&idx=" + idx;
	}
}


</script>
</head>
<body>
<div class="wrapper">
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
		<li class="liTitle">
<%
		if(!articleList.get(i).getRl_img().equals("")){
%>
		<img src="/fourplay/images/review_pic.png"  width="30" align="absmiddle"/>&nbsp;&nbsp;&nbsp;
<%} %>
		<span class="pointer" onclick="showContent(<%=idx%>);"><%=articleList.get(i).getRl_title() %></span></li>
		<li class="writer"><%=articleList.get(i).getMl_id() %></li>
		<li class="date"><%=articleList.get(i).getRl_date().substring(0, 10) %></li>
		<li class="rate">
<%
		for(int j = 0; j < articleList.get(i).getRl_rate(); j++){
%>
			<img src="../images/star.png" width="12px"/>
<%
		} 
%>
		</li>
	</ul>
	<ul class="review" id="<%=idx %>" style="display:none;">
		<li><%=articleList.get(i).getRl_content() %></li>
<%
		if(!articleList.get(i).getRl_img().equals("")){
%>
		<li><img src="/fourplay/product/r_img/<%=articleList.get(i).getRl_img() %>"  width="150"/></li>
<%
		} if(login != null && login.getMlid().equals(articleList.get(i).getMl_id())){
%>
<!-- 
		<li class="liBtn">
			<input type="button" value="수정"  class="rBtn" onclick="location.href='review_form.review?wtype=up&idx=<%=idx %>&plid=<%=plid%>&plname=<%=plname%>';"/>
		</li>
 -->
		<li class="liBtn"><input type="button" value="삭제"  class="rBtn" onclick="notCool(<%=idx %>);"/></li>
<%
		}
%>
	</ul>
<%
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
System.out.println("rCnt: "+rCnt);
System.out.println("rPcnt: "+rPcnt);
System.out.println("rCpage: "+rCpage);
	if (rCpage == 1) {
		out.println("<<&nbsp;&nbsp;<&nbsp;&nbsp;");
	} else {
		out.print("<a href='review_list.review?rCpage=1"  + "&plid="+plid+"'>");
		out.println("<<</a>&nbsp;&nbsp;");
		out.print("<a href='review_list.review?rCpage=" + (rCpage - 1)  + "&plid="+plid+"'>");
		out.println("<</a>&nbsp;&nbsp;");
	}

	for (int i = 1, j = rSpage ; i <= 10 && j <= rPcnt ; i++, j++) {

System.out.println("rSpage: "+rSpage);
		if (rCpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='review_list.review?rCpage=" + j  + "&plid="+plid+"'>");
			out.println(j + "</a>&nbsp;");
		}
	}

	if (rCpage == rPcnt) {
		out.println("&nbsp;&nbsp;>&nbsp;&nbsp;>>");
	} else {
		out.print("&nbsp;&nbsp;<a href='review_list.review?rCpage=" + (rCpage + 1)  + "&plid="+plid+"'>");
		out.println("></a>");
		out.print("&nbsp;&nbsp;<a href='review_list.review?rCpage=" + rPcnt  + "&plid="+plid+"'>");
		out.println(">></a>");
	}
}
%>
	</div>
</div>
</body>
</html>