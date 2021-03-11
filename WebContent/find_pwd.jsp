<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
<%
MemberInfo memberPwd = (MemberInfo)request.getAttribute("memberPwd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<style>
.find { width:250px; height:100px; border:1px solid black; }
#find2 { display:none;}
#find4 { display:none;}


h3{text-align:center; padding-bottom:30px; font-size:25px; font-weight:bold;}
.title{padding-bottom:10px;}
.box{border:1px solid #000; padding:10px; margin:auto; width:350px;}
.find-table{width:100%;}
.find-table tr{line-height:40px;}
.find-table th{width:80px;}
.find-table input{width:100%; height:25px; box-sizing:border-box;}
.phone{display:flex; align-items:center;}
.phone select{width:100%; height:25px;}

.btn{padding-top:15px; display:flex;}
.btn input{width:100%; height:40px; margin:0 5px; background:#000; color:#fff; font-size:14px; border:none;}
.btn .gray{background:gray; color:#fff;}

.find-text{text-align:center; font-size:14px; line-height:25px;}
</style>
<script>
function showChk(find) {
	find1.style.display = "none";
	find2.style.display = "none";
	var obj = document.getElementById(find);
	obj.style.display = "table";
}

function showChk2(find) {
	find3.style.display = "none";
	find4.style.display = "block";
}
</script>
</head>
<body>
<div id="wrapper">
<% 
if (memberPwd == null) {
%>
<form name="frmFind" action="find_pwd_proc.find" method="post">
<h3>Find password</h3>
<div class="box">
	<div class="title">
		<input type="radio" name="chk" value="e" onclick="showChk('find1')" checked="checked"/>이메일로 찾기&nbsp;&nbsp;
		<input type="radio" name="chk" value="p" onclick="showChk('find2')">휴대폰 번호로 찾기
	</div>
	<table class="find-table" id="find1">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" /></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" /></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email" /></td>
		</tr>
	</table>
	<table class="find-table" id="find2">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id" /></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" /></td>
		</tr>
		<tr>
			<th>휴대폰번호</th>
			<td class="phone">
				<select name="p1">
					<option value="010" selected="selected">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
				</select>-
				<input type="text" name="p2" size="4" /> - <input type="text" name="p3" size="4" />
			</td>
		</tr>
	</table>
	<div class="btn">
		<input type="submit" value="전송" />
		<input type="button" value="아이디 찾기" onClick="location.href='find_id.find'" class="gray"/>
	</div>
</div>
</form>
<%
} else {
%>
<div class="box" id="find3">
	<p class="find-text">이메일 &nbsp;&nbsp;<%=memberPwd.getMlemail() %></p>
	<div class="btn">
		<input type="button" value="임시비밀번호 전송"  onclick="showChk2('find3')" />
		<input type="button" value="취소"  onclick="location.href='login_form.jsp'" class="gray"/>
	</div>
</div>

<div class="box" id="find4">
	<p class="find-text"><%=memberPwd.getMlemail() %> 로<br>임시 비밀번호를 전송하였습니다.</p>
	<div class="btn">
		<input type="button" value="로그인하기"  onclick="location.href='login_form.jsp'" />
	</div>
</div>
<% 	
}
%>
</div>
</body>
</html>