<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<style>
#idMsg {
	font-size: 12px;
    padding-top: 5px;
    display: inline-block;
}
.fontRed { color:red; font-weight:bold; }
.fontBlue { color:blue; font-weight:bold; }

.btn2 {width:140px; height:30px; background-color:black;  border:solid 1px black; color:white; font-size:15px; }
.btn3 {width:140px; height:30px; background-color:gray;  border:solid 1px gray; color:white; font-size:15px; }

.join-title{width:700px; margin:auto; text-align:center; font-weight:bold; font-size:23px; padding-bottom:15px; border-bottom:2px solid #000;}
.join-table{width:600px; margin:50px auto 0; background:#fff;}
.join-table table{width:100%; border:1px solid #eee;}
.join-table table td{border-bottom:1px solid #eee;}
.join-table table tr{}
.join-table input[type=text],input[type=password]{border:none; outline:none; width:100%; height:50px; text-indent:15px; font-size:15px;}
.join-table .btn{text-align:center; padding-top:30px;}

.policy-textarea{resize:none; width:100%; padding:10px; color:#777; border-color:#eee; box-sizing:border-box; outline:none;}
.policy-table{width:100%;font-size:14px;border:1px solid #eee;}
.policy-table tr{height:40px;}
.policy-table th{background:#eee; color:#555; font-weight:bold; text-align:center;}
.policy-table td{text-align:center; color:#777;}
.policy-table td:first-child{background:#eee;}

.agree-box2{width:100%; border:1px solid #eee; font-size:13px;}
.agree-box2 table{width:100%;}
.agree-box2 tr{height:30px;}
.agree-box2 td{border-bottom:1px solid #eee; padding:10px;}
.agree-box2 tr:last-child td{border-bottom:none;}
.agree-box2 .text{padding:10px 20px; line-height:20px;}
.agree-box2 p{color:#777;}
.agree-box2 a{display:inline-block;text-decoration:none; font-size:12px; width:80px; text-align:center; background:#eee; color:#777; line-height:18px; border:1px solid #ddd;}

</style>
<script src="jquery-3.5.1.js"></script>
<script>
/* 아이디 중복체크 */
function chkDupId(){
	var uid = $("#uid").val();
	if (uid.length >= 4) {
		$.ajax({
			type : "POST",	// 데이터 전송방법 
			url : "dupID", 	// 중복체크를 위해 이동할 컨트롤러 URL
			data : {"uid":uid}, // url로 지정한 곳으로 보낼 데이터
			success : function(chkRst) {
			// 함수 실행시 url로 지정한 곳에서 작업한 결과를 chkRst로 받아 옴
				
				var msg = "";
				if(chkRst == 0) {
					msg = "<span class='fontBlue'>사용하실 수 있는 ID입니다.</span>";
					$("#idChk").val("Y");
				} else {
					msg = "<span class='fontRed'>이미 사용중 인 ID입니다.</span>";
					$("#idChk").val("N");
				}
				document.getElementById("idMsg").innerHTML = msg;
			}
		});
	}
}

/* 회원가입 검사 */
function chkData(frm) {
	var name = frm.name.value;		var pwd = frm.pwd.value;	 	var pwd2 = frm.pwd2.value;
	var email = frm.email.value;	var phone = frm.phone.value;	var birth = frm.birth.value;
	var uid = frm.uid.value;		var gender = frm.gender;	
	
	if (name == "") {
		alert("이름을 입력하세요.");		frm.name.focus();		return false;
	} 
	
	if (uid == "") {
		alert("아이디를 입력하세요.");	frm.uid.focus();		return false;
	} else if (uid.length < 4) {	// // 아이디를 4자미만으로 입력했으면
		alert("아이디는 4~20 이내로 입력하세요.");
		frm.uid.select();	return false;
	} else {
		for (var i = 0; i < uid.length; i++) {
		// uid의 글자개수만큼 루프를 돌면서 작업
			var c = uid.charAt(i).toLowerCase();
			if (!(c >= 'a' && c <= 'z' || c >= '0' && c <= '9' )) {
				alert("아이디는 영문과 숫자로만 입력하세요.");
				frm.uid.value = "";	return false;
			}
		}
	}
	
	if (pwd == "") {
		alert("비밀번호를 입력하세요.");	frm.pwd.focus();		return false;
	}
	if (pwd2 == "") {
		alert("비밀번호 확인를 입력하세요.");		frm.pwd2.focus();		return false;
	} else if (pwd != pwd2) {
		alert("비밀번호와 비밀번호 확인이 다릅니다.");
		frm.pwd2.value = "";	frm.pwd2.focus();	return false;
	}
	if (email == "") {
		alert("이메일를 입력하세요.");	frm.email.focus();		return false;
	}
	if (phone == "") {
		alert("휴대폰 번호를 입력하세요.");	frm.phone.focus();		return false;
	} else if (phone.length < 13) {
		alert("휴대폰 번호는ex) 010-1234-1234 \"-\" 을 포함시켜 입력하세요.");
		frm.phone.select();	return false;
	}
		
	if (birth == "") {
		alert("생년월일을 확인를 입력하세요.");		frm.birth.focus();		return false;
	} else if (birth.length < 10) {
		alert("생년월일은 ex) 2021-01-01  \"-\"  포함시켜 입력하세요.");
		frm.birth.select();	return false;
	}
	
	var isChk = true;	
	for (var i = 0; i < gender.length ; i++) {
		if (gender[i].checked) {
			isChk = false;
			break;
		}
	}
	if (isChk) {
		alert("성별을 입력하세요.");		return false;
	}
}

function chkAll(all) {
	var arrChk = document.frmChk.chk;
	for (var i = 0 ; i < arrChk.length ; i++) {
		arrChk[i].checked = all.checked;
	}
}
</script>
</head>
<body>
<div id="wrapper">
<h2 class="join-title">Join Us</h2>
<form name="frmJoin" action="join_proc.jsp" method="post" onsubmit="return chkData(this);">
<input type="hidden" name="idChk" id="idChk" value="N" />
<div class="join-table">
	<table cellpadding="5" align="center">
	<tr colspan="2"><td align="center" colspan="2"><input type="text" name="name" placeholder="이름" /></td></tr>
	<tr><td colspan="2"><input type="text" name="uid" id="uid" onkeyup="chkDupId();" placeholder="아이디" /></td></tr>
	<tr><td colspan="2"><span id="idMsg" style="text-indent:15px; padding:5px 0;">아이디는 4~20자 이내의 영문, 숫자 조합으로 입력하세요.</span></td></tr>
	<tr><td colspan="2"><input type="password" name="pwd" placeholder="비밀번호" /></td></tr>
	<tr><td colspan="2"><input type="password" name="pwd2" placeholder="비밀번호 확인" /></td></tr>
	<tr><td colspan="2"><input type="text" name="email" placeholder="이메일" /></td></tr>
	<tr><td colspan="2"><input type="text" name="phone" placeholder="휴대폰 번호 ex) 010-1234-1234" /></td></tr>
	<tr>
		<td><input type="text" name="birth" placeholder="생년월일 ex) 2021-01-10" /></td>
		<td>
			<input type="radio" name="gender" value="M" /> 남
			<input type="radio" name="gender" value="F"/> 여
		</td>
	</tr>
	</table>
	
	<div class="btn">
		<input type="submit" value="회원 가입" class="btn2"/>
		<input type="reset" value="취소" class="btn3"/>
	</div>
</div>
</form>
<jsp:include page="/content.jsp"></jsp:include>
</div>
</body>
</html>

