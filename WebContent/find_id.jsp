<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.find { width:250px; height:100px; border:1px solid black; }
#find2 { display:none;}
</style>
<script>
function showChk(find) {
	find1.style.display = "none";
	find2.style.display = "none";
	var obj = document.getElementById(find);
	obj.style.display = "block";
}
</script>
</head>
<body>
<form name="frmFind" action="FindIdAction" method="post">
<input type="radio" name="chk" onclick="showChk('find1')" checked="checked"/>이메일로 찾기 <input type="radio" name="chk" onclick="showChk('find2')">휴대폰 번호로 찾기<br />
<div class="find" id="find1">
이름 <input type="text" name="name" /><br />
이메일 <input type="text" name="email" /><br />
</div>
<div class="find" id="find2">
이름 <input type="text" name="name" /><br />
<div>휴대폰 번호 
<select>
	<option value="010" selected="selected">010</option>
	<option value="011">011</option>
	<option value="016">016</option>
</select> -
<input type="text" name="p2" size="4" /> - <input type="text" name="p3" size="4" />
</div>
</div>
<input type="submit" value="전송" />
</form>

</body>
</html>