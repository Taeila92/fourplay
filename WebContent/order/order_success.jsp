<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String olid = request.getParameter("olid");
String ismember = request.getParameter("ismember");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#head {
	width:100%; border:1px solid lightgray; 
}
#kTitle {color:#8e8e8e; font-size:17px; }
#head {background-color:#d1d1d1; width:100%; height:190px; line-height:170px; margin:5px auto; text-align:center;}
#head .hImg{vertical-align:middle; margin-right:10px;}

.ordSuccess {width:200px; height:200px; margin:20px auto; border:1px solid red;}
.ordSuccess h3 {display:block;margin:0 auto;}
.btn { width:80px; height:30px; background-color:lightgray; float:left; margin-left:10px; margin-top:10px;}
</style>
</head>
<body>
<div id="wrapper">
	<div id="head">
		<img src="../images/CARTLIST.png" name="cartImg" class="hImg" width="128"  alt="장바구니"/>
		<img src="../images/checklist.png" name="ordFormImg" class="hImg" width="128" alt="주문서 작성" />
		<img src="../images/computer_mouse.png" name="ordChkImg" class="hImg" width="128"/>
		<img src="../images/delivery_complete.png" name="ordDoneImg" class="hImg" width="128"  alt="주문 완료" style="padding:8px; border:6px solid darkgray;"/><br />
	</div>
	<div class="ordSuccess">
		<h3>주문이 성공했습니다</h3>
		<ul>
			<li>주문번호: <%=olid %></li>
		<%
		if (ismember.equals("n")){
		%>
			<li>비회원 주문조회를 위해서는 주문번호 정보가 필요합니다.</li>
		<%
		}
		%>
		</ul>
		<ul>
			<li><input type="button" class="btn" value="주문 조회" onclick="location.href='/fourplay/order_list.mpg';" /></li>
			<li><input type="button" class="btn" value="계속 쇼핑" onclick="location.href='../index.jsp';" /></li>
		</ul>
	</div>
</div>
</body>
</html>