<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
ArrayList<AddrInfo> addrList = (ArrayList<AddrInfo>)request.getAttribute("addrList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<script src="jquery-3.5.1.js"></script>
<script>
function getSelectChk() {	// 사용자가 선택한 체크박스들의 value를 추출하는 함수
	var arrChk = document.frmAddr.chk;
	var idx = "";
	for (var i = 0 ; i < arrChk.length ; i++) {
		if (arrChk[i].checked) {
			idx += "," + arrChk[i].value;	
		}
	}
	if (idx != "") {
		if (idx.indexOf(",,") > -1)	idx = idx.substring(2);	
		else						idx = idx.substring(1);	
	}
	
	return idx;
}

function notCool(idx) {		
	var isConfirm = false;
	if (idx == 0) {	
		var arrChk = document.frmAddr.chk;
		idx = getSelectChk();	
		if (idx != "") {	
			isConfirm = confirm("선택한 주소(들)을 주소록에서 삭제하시겠습니까?");
		} else {	
			alert("삭제할 주소를 하나 이상 선택하세요.");
		}
	} else {	
		isConfirm = confirm("해당 주소를 주소록에서 삭제하시겠습니까?");
	}

	if (isConfirm) {
		$.ajax({
			type : "POST", 
			url : "/fourplay/addr_del.mpg", 
			data : { "idx" : idx }, 
			success : function(chkRst) {
				if(chkRst == 0)		alert("선택한 상품 삭제에 실패했습니다.\n다시 시도해 주십시오.");
				else				location.reload();
			}
		});
	}
}
</script>
</head>
<body onload="window.resizeTo(500, 400);">
<form name= "frmAddr" action="" method="post">
<table border="1px solid balck" width="100%" >
<tr><th width="15%">우편번호</th><th width="*">주소</th><th width="15%">선택</th></tr>
<%
if (loginMember != null) {
	if (addrList != null && addrList.size() > 0) {
		for (int i = 0; i < addrList.size(); i++) {
%>
<tr align="center">
<td><%=addrList.get(i).getMa_zip() %></td>
<td><%=addrList.get(i).getMa_addr1() + " " + addrList.get(i).getMa_addr2() %></td>
<td><input type="checkbox" name="chk" value="<%=addrList.get(i).getMa_idx() %>" /></td>
</tr>
<%
		}	
%>
</table>
<br />
<%
	} else {
%>
<table>
<tr><td colspan="3" align="center">주소록이 비었습니다.</td></tr>
</table>
<% 
	}
}
%>
<div align="right">
<input type="button" value="주소추가"  />&nbsp;&nbsp;
<input type="button" value="선택삭제" onclick="notCool(0);" />
</div>
</form>
</body>
</html>
