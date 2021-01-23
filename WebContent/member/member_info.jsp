<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
<%

AddrInfo addr = (AddrInfo)request.getAttribute("addr");
String b1 = null; String b2 = null; String b3 = null;
String p1 = null, p2 = null, p3 = null, e1 = null, e2 = null;

String[] birth = loginMember.getMlbirth().split("-");
b1 = birth[0];	b2 = birth[1];	b3 = birth[2];
String[] phone = loginMember.getMlphone().split("-");
p1 = phone[0];	p2 = phone[1];	p3 = phone[2];
String[] email = loginMember.getMlemail().split("@");
e1 = email[0];	e2 = email[1];
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<style>
.msg { font-size:12px; }
th { background:#eee; }
</style>
<script>
function openPop1() {
// 팝업창 뛰우는 메소드
	var w = (screen.width - 500) / 2;	// 수평 중심점
	var h = (screen.height - 400) / 2;	// 수직 중심점
	var win = window.open("/fourplay/addr_form.mpg", "", "width=500,height=400,left=" + w + ",top=" + h);
}

function openPop2() {
// 팝업창 뛰우는 메소드
	var w = (screen.width - 500) / 2;	// 수평 중심점
	var h = (screen.height - 400) / 2;	// 수직 중심점
	var win = window.open("/fourplay/addr_view.mpg", "", "width=500,height=400,left=" + w + ",top=" + h);
}
function selectEmail(obj) {
// 이메일 선택시 변경되는 메소드
	document.frm.e2.value = document.frm.e3.value;
}
</script>
</head>
<body>
<div id="wrapper">
<h2 align=center>MEMBER INFORMATION</h2>
<h3 class="msg">HOME > MYPAGE > 회원정보 수정</h3>
<form name="frm" action="member_proc.mpg">
<input type="hidden" name="id"  value="<%=loginMember.getMlname() %>" />
<input type="hidden" name="name" value="<%=loginMember.getMlid() %>" />
<table cellpadding="5" cellspacing="0" align="center" border="1px solid #eee">
<tr>
<th>이름</th><td><%=loginMember.getMlname() %></td></tr>
<tr>
<th>생년월일</th>
<td>
	<%=b1 %> 년 <%=b2 %> 월 <%=b3 %> 일 
	<input type="radio" name="gender" value="M" <% if (loginMember.getMlgender().equals("M")) { %>checked="checked" <% } %> disabled="disabled" />남
	<input type="radio" name="gender" value="F" <% if (loginMember.getMlgender().equals("F")) { %>checked="checked" <% } %> disabled="disabled"/>여
</td>
</tr>
<tr><th>아이디</th><td><%=loginMember.getMlid() %></td></tr>
<tr><th>비밀번호</th><td><input type="password" name="pwd" /></td></tr>
<tr><th>비밀번호 확인</th><td><input type="password" name="pwd2" /><span class="msg"> * 비밀번호 확인을 위해 한번 더 입력해주세요.</span></td></tr>
<tr>
<th>이메일</th>
<td>
	<input type="text" name="e1" size="20" value="<%=e1%>" /> @
	<input type="text" name="e2" size="20" value="<%=e2%>" />
	<select name="e3"  onchange="selectEmail(this);">
		<option value="">도메인 선택</option>
		<option value="naver.com" <% if (e2.equals("naver.com")) { %>selected="selected"<% } %>>naver.com</option>
		<option value="gmail.com" <% if (e2.equals("gmail.com")) { %>selected="selected"<% } %>>gmail.com</option>
		<option value="nate.com"  <% if (e2.equals("nate.com")) { %>selected="selected"<% } %>>gmail.com</option>
		<option value="direct"></option>
	</select>
	<br /><span class="msg">* ID, 비밀번호 찾기 시 입력된 이메일로 전달되므로 정확한 메일 주소를 입력해 주세요.</span>
</td>
</tr>
<tr><th>이메일 수신여부</th><td><input type="radio" checked="checked" /> 동의합니다. <input type="radio" name="" /> 동의하지 않습니다.</td></tr>
<tr>
<th>휴대폰</th>
<td>
	<select name="p1">
		<option value="010" <% if (p1.equals("010")) { %>selected="selected"<% } %>>010</option>
		<option value="011" <% if (p1.equals("011")) { %>selected="selected"<% } %>>011</option>
		<option value="016" <% if (p1.equals("016")) { %>selected="selected"<% } %>>016</option>
		<option value="019" <% if (p1.equals("019")) { %>selected="selected"<% } %>>019</option>
	</select> -
	<input type="text" name="p2" size="4" maxlength="4" value="<%=p2%> "/> -
	<input type="text" name="p3" size="4" maxlength="4" value="<%=p3%>" />
	<span class="msg"> * 휴대폰 번호는 마이페이지에서 수정하실 수 있습니다.</span>
</td>
</tr>
<tr><th>sms 수신여부</th><td><input type="radio" checked="checked" /> 동의합니다. <input type="radio" name="" /> 동의하지 않습니다.</td></tr>
<tr>
<th>주소</th>
<td><input type="text" name="zip" value="<%=addr.getMa_zip() %>" />
	<input type="button" value="우편번호 검색" onclick="openPop1();" /> 
	<input type="button" value="배송지 목록" onclick="openPop2();" /><br />
	<input type="text" size="48" name="addr1" value="<%=addr.getMa_addr1() %>" /><br />
	<input type="text" size="48"name="addr2" value="<%=addr.getMa_addr2() %>" />
</td>
</tr>
<tr>
<td colspan="2" align="center">
	<input type="submit" value="회원정보 수정" /> 
	<input type="reset" value="취소" />
</td>
</tr>
</table>
</form>
</div>
</body>
</html>
