<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
OrdListInfo detailInfo = (OrdListInfo)request.getAttribute("detailInfo");
String olid = request.getParameter("olid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#wrapper {width:100%; font-size:13px;}
#wrapper table {width:800px;  border:0px; }
#wrapper table td {border-bottom:1px solid lightgray; align:center;}
#ordInfo th { background-color:lightgray; }
#pdtInfo th { background-color:lightgray; }
#delivery th { background-color:lightgray; }
#delivery {}
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:underline;  font-weight:bold;}
a:active { color:#f00; text-decoration:none; }	
a:focus { color:#f00; text-decoration:underline; }
</style>
</head>
<body>
<div id="wrapper">
<h2>ORDER DETAIL</h2>
<div id="ordInfo">
<%if (detailInfo != null){ %>
<table cellpadding="5" cellspacing="0" border="1">

<tr><th colspan="2">주문정보</th><th colspan="2">결제정보</th></tr>
<tr>
<th>주문번호</th><td><%=detailInfo.getOl_id() %></td>
<th rowspan="2">총 결제금액</th><td rowspan="2"><%=detailInfo.getOl_pay() %></td>
</tr>
<tr><th>주문일자</th><td><%=detailInfo.getOl_date() %></td>
</tr>
<tr><th>주문자</th><td><%=detailInfo.getOl_bname() %></td>
<th rowspan="2">결제수단</th>
<td rowspan="2">
<%
switch(detailInfo.getOl_payment()){
case "a": 	out.print("카드");		break;
case "b": 	out.print("휴대폰");		break;
case "c": 	out.print("계좌이체");		break;
case "d": 	out.print("무통장입금");	break;
}
 %>
</td>
</tr>
<tr><th>주문처리상태</th>
<td>
<% switch(detailInfo.getOl_status()){
	case "a": 	out.print("입금 전<br />계좌번호: 국민은행<br />6131802-01473-365(김현수)");		break;
	case "b": 	out.print("입금 확인");	break;
	case "c": 	out.print("상품준비중");	break;
	case "d": 	out.print("배송중<br/>한진택배: 419079564046");		break;
	case "e": case "k": 	out.print("배송완료");				break;
	case "f": 	out.print("교환요청");	break;
	case "g": 	out.print("교환완료");	break;
	case "h": 	out.print("환불요청");	break;
	case "i": 	out.print("환불완료");	break;
	case "j": 	out.print("취소");		break;
}
%>
</td>
</tr>
</table>
</div>
<div id="pdtInfo">
<table cellspacing="0">
<tr><th colspan="6">주문 상품 정보</th></tr>
<tr><th>사진</th><th>상품정보</th><th>수량</th><th>가격</th><th>주문처리상태</th><th>취소/교환/반품</th></tr>
<%
for (int i = 0; i < detailInfo.getOrdDetailList().size() ; i++){
%>
<tr>
<td><img src='/fourplay/product/pdt_img/<%=detailInfo.getOrdDetailList().get(i).getPl_img1() %>' width="50" /></td>
<td><%=detailInfo.getOrdDetailList().get(i).getPl_name() + "<br />옵션: " 
+ detailInfo.getOrdDetailList().get(i).getOd_opt().replace(':', ',') %></td>
<td><%=detailInfo.getOrdDetailList().get(i).getOd_cnt() %></td>
<td><%=detailInfo.getOrdDetailList().get(i).getOd_price() %></td>
<td>
<% switch(detailInfo.getOl_status()){
	case "a": 	out.print("입금 전<br />계좌번호: 국민은행<br />6131802-01473-365(김현수)");		break;
	case "b": 	out.print("입금 확인");	break;
	case "c": 	out.print("상품준비중");	break;
	case "d": 	out.print("배송중<br/>한진택배: 419079564046");		break;
	case "e": 	out.print("배송완료");	break;
	case "f": 	out.print("교환요청");	break;
	case "g": 	out.print("교환완료");	break;
	case "h": 	out.print("환불요청");	break;
	case "i": 	out.print("환불완료");	break;
	case "j": 	out.print("취소");		break;
}%> 
</td>
<td>
<% switch(detailInfo.getOl_status()){
	case "a": case "b": case"c": 	out.print("<input type='button' value='주문취소' onclick='ordCancel("+ detailInfo.getOl_id()+");'/>");		break;
	case "d": case "g":	out.print("<input type='button' value='교환/반품' onclick=''/>");					break;
	case "e":	out.print("배송완료"); break;
	case "f": 	out.print("교환요청");	break;
	case "h": 	out.print("환불요청");	break;
	case "i": 	out.print("환불완료");	break;
	case "j": 	out.print("취소완료");	break;
}
%>
</td>
</tr>
<%} %>
</table>
</div>
<div id="delivery">
<table  cellspacing="0">
<tr><th colspan="6">배송 정보</th></tr>
<tr><th>받으시는 분</th><td><%=detailInfo.getOl_rname() %></td>
<tr><th>우편번호</th><td><%=detailInfo.getOl_rzip() %></td>
<tr><th>주소</th><td><%=detailInfo.getOl_raddr1() + " " + detailInfo.getOl_raddr2() %></td>
<tr><th>전화</th><td><%=detailInfo.getOl_rphone() %></td>
</table>

</div>
<%} else {
	out.println("없음");
}
%>
</div>
</body>
</html>