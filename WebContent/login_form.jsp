<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String ismember = request.getParameter("ismember");
if(ismember == null)   ismember = "";

String id = request.getParameter("id"); // plid
String wish = request.getParameter("wish"); // 위시리스트에서 왔는지 확인
String now = request.getParameter("now"); // 상품디테일에서 왔는지 확인
String cnt = request.getParameter("cnt"); // 상품 수량
String args = request.getParameter("args"); // 검색및 페이징 주소값
String price = request.getParameter("price"); // 상품 가격
String point = request.getParameter("point"); // 상품 마일리지
String optValue = "";   // 선택한 옵션들을 담을 변수
int optCnt = 0;         // 옵션의 개수를 담을 변수
if (request.getParameter("optCnt") != null) {   // 옵션이 있으면
   optCnt = Integer.parseInt(request.getParameter("optCnt"));
   for (int i = 0 ; i < optCnt ; i++) {
      optValue += "," + request.getParameter("opt" + i);
   }
   optValue = optValue.substring(1);
   // 선택한 옵션들을 쉼표를 구분자로 하여 문자열로 만듦
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#red{color:red; font-size:10px;}
.lginBox {width:50%; margin:10px auto; }

.btn { 
   width:100px; height:80px; background-color:black;  
   border:solid 1px black; color:white; font-size:20px; 
}
.btn2 {
   width:140px; height:30px; background-color:black;  
   border:solid 1px black; color:white; font-size:15px; 
}
.btn3 {
   width:140px; height:30px; background-color:gray;  
   border:solid 1px gray; color:white; font-size:15px; 
}
.text { width:250px; height:20px; }
#text2 { font-size:14px; color:gray; }
hr {
   width:530px;
}
</style>
<script>
function logSubmit() {		// 로그인버튼 클릭시 실행시키는 함수
   var frm = document.frmLogin;
<% if(id != null && !id.equals("")) { // 상품디테일에서 로그인폼으로 왔을때 실행되는 if문
		if (wish != null && wish.equals("y")){%>
		frm.action = "login";
		<%
		session.setAttribute("url", "wish_in.crt");
		}else{%>
			var now = document.getElementById("now");
			var buyNow = document.getElementById("buyNow");
			now.value = "go"
			buyNow.value = "y";
			frm.action = "login";
<%			session.setAttribute("url", "cart_in.crt");
		}
	}else {%>
		frm.action = "login";
<%}%>
   frm.submit();
}
function goJoin() {
// 회원 가입 폼으로 이동시키는 함수
   var frm = document.frmLogin;
   frm.action = "join_form.jsp";
   frm.submit();
}
function goChk() {
// 아이디/비밀번호 찾는 폼으로 이동시키는 함수
	var frm = document.frmLogin;
	frm.action = "find_id.find";
	frm.submit();
}

<% if (loginMember== null && id != null && cnt != null) { %>
function goDirect() {
// 로그인 없이 비회원인 상태로 구매할 때 구매폼으로 이동시키는 함수
   var frm = document.frmLogin;
   var now = document.getElementById("now");
   var buyNow = document.getElementById("buyNow");
   now.value = "go";
   buyNow.value = "y";
   frm.action = "cart_in.crt";
   frm.submit();
}
<% } %>
</script>
</head>
<body>
<div id="wrapper">
	<h2 align="center">LOGIN</h2>
	<div class="lginBox">
	<span id="red">관리자 계정(sa / 1234)으로 로그인시 어드민 메뉴로 이동합니다.</span>
	<form name="frmLogin" action="login" method="post">
	<table cellpadding="3" align="center"> 
	<input type="hidden" name="now" id="now" value=""/>
	<input type="hidden" name="buyNow" id="buyNow" value="" />
	<input type="hidden" name="id" value="<%=id %>" />
	<input type="hidden" name="cnt" value="<%=cnt %>" />
	<input type="hidden" name="wish" value="<%=wish %>" />
	<input type="hidden" name="args" value="<%=args %>" />
	<input type="hidden" name="price" value="<%=price %>" />
	<input type="hidden" name="point" value="<%=point %>" />
	<input type="hidden" name="optCnt" value="<%=optCnt %>" />
	<input type="hidden" name="optValue" value="<%=optValue %>" />
	<tr>
	   <td>아이디&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="uid" value="sungda123" class="text" /></td>
	   <td rowspan="2" align="right"><input type="button" value="LOGIN" class="btn" onclick="logSubmit()" /></td>
	</tr>
	<tr><td>비밀번호&nbsp;&nbsp;&nbsp;<input type="password" name="pwd"  value="1234" class="text"/></td></tr>
	</table>
	</form>
	<hr />
	<table cellpadding="3" align="center">
	<tr>
	   <td>회원가입 하시면 더 많은 혜택을 누리실 수 있습니다.</td><td><input type="button" value="회원가입" onclick="goJoin();" class="btn2" /></td>
	</tr>
	<tr>
	   <td>아이디/비밀번호를 잊으셨나요?</td><td><input type="button" value="아이디/비밀번호 찾기" onclick="goChk();" class="btn3" /></td>
	</tr>
	</table>
	<hr />
	<% if (loginMember== null && id != null && cnt != null) { %>
	<table cellpadding="3" align="center">
	<tr>
	   <td>비회원님도 상품구매가 가능합니다. 단 쇼핑몰에서<br />제공하는 다양한 회원 혜택에서 제외될 수 있습니다.</td>
	   <td><input type="button" value="비회원 구매하기" onclick="goDirect();" class="btn2" /></td>
	</tr>
	</table>
	<hr />
	<% } %>
	<%if(loginMember== null && ismember.equals("n")){ %>
	<h2 align="center">비회원 주문조회</h2>
	<form name="frm" action="non_order_list.mpg" method="post">
	<table cellpadding="3" align="center">
	<tr>
	   <td>주문자명&nbsp;&nbsp;&nbsp;<input type="text" name="bname" class="text" /></td>
	   <td rowspan="2" align="right"><input type="submit" name="확인" class="btn" value="확인"/></td>
	</tr>
	<tr><td>주문번호&nbsp;&nbsp;&nbsp;<input type="text" name="olid" placeholder="주문번호 12자 입력" class="text" /></td></tr>
	<tr><td id ="text2" colspan="2">주문번호를 잊으셨다면 고객센터(02-123-5678)로 문의하여 주시기 바랍니다.</td><tr>
	</table>
	</form>
	<%} %>
	</div>
</div>
</body>
</html>
