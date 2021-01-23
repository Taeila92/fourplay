<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
ReviewInfo review = (ReviewInfo)request.getAttribute("review");
String uid = "";

int idx = 0;
if(request.getParameter("idx") != null) 			idx = Integer.parseInt(request.getParameter("idx"));

String wtype= request.getParameter("wtype");
String plid = request.getParameter("plid");
String plname = request.getParameter("plname");
String odidx = request.getParameter("odidx");
String olid = request.getParameter("olid");
String msg = "등록";
if(wtype.equals("in")){
%>
<%@ include file="../menu.jsp" %>
<%
	uid = loginMember.getMlid();
} else{
	msg = "수정";
	MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
	uid = loginMember.getMlid();
} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
*{ padding: 0; margin: 0; }
ul li, ol li{ list-style: none; text-decoration: none; }
a{ text-decoration: none; color: #222; }
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:none;  font-weight:bold;}
a:active { color:#f00; text-decoration:none; }   
a:focus { color:pink; text-decoration:none; }

#wrapper { width:100%; }
.reviewUp {width:95%; margin:5px auto;border:1px solid white;}
.reviewIn {width:55%; margin:5px auto; border:1px solid white;}
.reviewUp ol li, .reviewIn ol li {float:left;}
.rTitle {float:left; border:1px solid white;}
.rTitle li { margin-right:15px;}
.rTitle:first-child {width:20%;border:1px solid white;}
.rContent {width:95%; display:block; border:1px solid white;}

.file {font-size:12px;}
.Btn { width:100%;  border:1px solid white; text-align:right; margin-top:15px;}
.btn { 
	width:40px; height:30px; background:black; color:white; font-size:15px;
}
</style>
<script>
//이미지 파일만 업로드 가능하도록
function fileCheck(obj){
	var imgName = obj.value;
	var idx = imgName.lastIndexOf('.');
	var ext = imgName.substring(idx + 1, obj.length);
	var type = ext.toLowerCase();
	
	if(!(type == "jpa" || type == "gif" || type == "png" || type == "jpeg")){
		alert("이미지 파일(jpg, gif, png, jpeg)만 업로드 가능합니다.");
		obj.value="";
	}
}
</script>
</head>
<body>
<div id="wrapper">
<form name="reviewFrm" action="review_proc.review" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="plid" value="<%=plid %>" />
	<input type="hidden" name="plname" value="<%=plname %>" />
	<input type="hidden" name="uid" value="<%=uid %>" />
	<input type="hidden" name="olid" value="<%=olid %>" />
	<input type="hidden" name="wtype" value="<%=wtype %>" />
	<input type="hidden" name="odidx" value="<%=odidx %>" />
	<h2>리뷰 <%=msg %></h2>
<%if(wtype.equals("in")){ //등록이면%>
<div class="reviewIn">
	<ul class="rTitle">
		<li>작성자</li>
		<li>제목</li>
		<li>평점</li>
		<li>상품명</li>
	</ul>
	<ul class="rTitle">
		<li><%=uid %></li>
		<li><input type="text" name="title" /></li>
		<li>
			<ol>
				<li><input type="radio" name="rRate" value="1"/><img src='images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="2" /><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="3"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="4"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="5" checked="checked"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/><img src='images/star.png' width="12px"/></li>
			</ol>
		</li>
		<li><%=plname %></li>
	</ul>
	<ul class="rContent">
		<li><textarea rows="20" cols="105" name="content"></textarea></li>
	</ul>
	<ul class="Btn">
		<li class="file"><input type="file" name="reviewImg" onchange="fileCheck(this);"/></li>
		<div class="Btn">
		<li><input type="submit" value="등록" class="btn" /></li>
		</div>
	</ul>
</div>
<%} else { 	// 수정이면%>
<div class="reviewUp">
<%=idx %>
	<input type="hidden" name="oldImg" value="<%=review.getRl_img() %>" />
	<input type="hidden" name="idx" value="<%=idx %>" />
	<ul class="rTitle">
		<li>작성자</li>
		<li>제목</li>
		<li>평점</li>
		<li>상품명</li>
	</ul>
	<ul class="rTitle">
		<li><%=uid %></li>
		<li><input type="text" name="title" value="<%=review.getRl_title() %>"/></li>
		<li>
			<ol>
				<li><input type="radio" name="rRate" value="1" <%if(review.getRl_rate() == 1){ %> checked="checked" <%} %>/><img src='../images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="2" <%if(review.getRl_rate() == 2){ %> checked="checked" <%} %> /><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="3" <%if(review.getRl_rate() == 3){ %> checked="checked" <%} %>  /><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="4" <%if(review.getRl_rate() == 4){ %> checked="checked" <%} %>  /><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/></li>
				<li><input type="radio" name="rRate" value="5"  <%if(review.getRl_rate() == 5){ %> checked="checked" <%} %> /><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/><img src='../images/star.png' width="12px"/></li>
			</ol>
		</li>
		<li><%=plname %></li>
	</ul>
	<ul class="rContent">
		<li><textarea rows="15" cols="105" name="content" style="overflow-x:hidden; overflow-y:auto;"><%=review.getRl_content() %></textarea></li>
	</ul>
	<ul >
		<li><input type="file" name="reviewImg" onchange="fileCheck(this);"/><%=(review.getRl_img().equals("")) ? "이미지 없음" : review.getRl_img() %></li>
		<div class="Btn">
			<li><input type="submit" value="<%=msg %>" class="btn" /></li>
		</div>
	</ul>
<%} %>
</form>
</div>
</div>
</body>
</html>