<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<style>
.box{border:1px solid #000; padding:10px; margin:auto; width:350px;}
.box h2{text-align:center; padding-bottom:15px;}
.box input[type=password]{width:100%; height:30px; outline:none;}
.btn{padding-top:15px; display:flex;}
.btn input{width:100%; height:40px; background:#000; color:#fff; border:none; margin:0 5px;}
.gray{background:gray !important;}
</style>
<script>
function notColl () {
	if (confirm("정말 삭제하시겠습니까?")) {
		document.chkPwd.submit();
	} 
}
</script>
</head>
<body>
<div id="wrapper">
	<div class="box">
		<h2>비밀번호</h2>
		<form name = "chkPwd" action="member_del_proc.mpg" method="post" >
		<input type="hidden" name="uid" value="<%=loginMember.getMlid() %>" />
		<input type="password" name="pwd" /><br />
		<div class="btn">
			<input type="button" value="확인" onclick="notColl();"  />
			<input type="button" value="취소" onclick="location.href='mypage.mpg'" class="gray"/>
		</div>
		</form>
	</div>
</div>
</body>
</html>
