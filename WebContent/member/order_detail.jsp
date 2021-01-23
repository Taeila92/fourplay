<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../menu.jsp" %>
<%
request.setCharacterEncoding("utf-8");
OrdListInfo detailInfo = (OrdListInfo)request.getAttribute("detailInfo");

String status = "";
switch(detailInfo.getOl_status()){
case "a": 	status = "입금 전<br />계좌번호: 국민은행<br />6131802-01473-365(김현수)";		break;
case "b": 	status = "입금 확인";	break;
case "c": 	status = "상품준비중";	break;
case "d": 	status = "배송중<br/>한진택배: 419079564046";		break;
case "e": case "k": 	status = "배송완료";				break;
case "f": 	status = "교환요청";	break;
case "g": 	status = "교환완료";	break;
case "h": 	status = "환불요청";	break;
case "i": 	status = "환불완료";	break;
case "j": 	status = "취소";		break;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#wrapper {font-size:13px; }
#wrapper table {width:800px; }
#wrapper table td {border-bottom:1px solid lightgray; align:center;}
.detail { width: 800px; margin:0 auto; }
#ordInfo th { background-color:lightgray; }
#pdtInfo th { background-color:lightgray; }
#delivery th { background-color:lightgray; }
#delivery {}
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:underline;  font-weight:bold;}
a:active { color:#f00; text-decoration:none; }	
a:focus { color:#f00; text-decoration:underline; }

.btn {text-align:right;}
.detailList {display:block; margin:15px auto;}
</style>
<!-- 
<link href="css/reset.css" type="text/css" rel="stylesheet" />
<link href="css/base.css" type="text/css" rel="stylesheet" />
 -->
 <script src="jquery-3.5.1.js"></script>
<script>
function ordCancel(olid) {
	if (confirm('주문을 취소하시겠습니까?\n취소 철회는 불가능합니다.')) {
		$.ajax({
			type : "POST", 
			url : "/fourplay/ord_proc.ord", 
			data : { "olid" : olid, "wtype" : "cancel" }, 
			success : function(chkRst) {
				if(chkRst == 0)		alert("주문 취소에 실패했습니다.\n다시 시도해 주십시오.");
				else				location.reload();
			}
		});
	}
}
</script>
</head>
<body>
<div id="wrapper">
	<div class="detail">
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
	case "c": 	out.print("계좌이체");	break;
	case "d": 	out.print("무통장입금");	break;
	}
	 %>
	</td>
	</tr>
	<tr><th>주문처리상태</th>
	<td><%=status%></td>
	</tr>
	</table>
	</div>
	<div id="pdtInfo">
	<table cellspacing="0">
	<tr><th colspan="6">주문 상품 정보</th></tr>
	<tr><th>사진</th><th>상품정보</th><th>수량</th><th>가격</th><th>주문처리상태</th><th>취소/교환/반품</th></tr>
	<%
	for (int i = 0; i < detailInfo.getOrdDetailList().size(); i++){
	%>
	<tr>
	<td><img src='/fourplay/product/pdt_img/<%=detailInfo.getOrdDetailList().get(i).getPl_img1() %>' width="50" /></td>
	<td><%=detailInfo.getOrdDetailList().get(i).getPl_name() + "<br />옵션: " 
	+ (detailInfo.getOrdDetailList().get(i).getOd_opt().equals("") ? "없음" : detailInfo.getOrdDetailList().get(i).getOd_opt().replace(':', ',')) %></td>
	<td><%=detailInfo.getOrdDetailList().get(i).getOd_cnt() %></td>
	<td><%=detailInfo.getOrdDetailList().get(i).getOd_price() %></td>
	<td><%=status%></td>
	<td>
		<% switch(detailInfo.getOrdDetailList().get(i).getOd_status()){
			case "a": case "b": case"c": 	out.print("<input type='button' value='주문취소' onclick='ordCancel("+ detailInfo.getOl_id()+");'/>");		break;
			case "d": case "g":				out.print("<input type='button' value='교환/반품' onclick=''/>");					break;
			case "e":	
				if(loginMember != null){
					out.print("<input type='button' value='구매후기' onclick=\"location.href='review_form.review?wtype=in&plid="
					+ detailInfo.getOrdDetailList().get(i).getPl_id()+ "&plname="+detailInfo.getOrdDetailList().get(i).getPl_name()
					+ "&odidx=" + detailInfo.getOrdDetailList().get(i).getOd_idx() 
					+ "&olid=" + detailInfo.getOrdDetailList().get(i).getOl_id() +"';\"/>");							
				} else{
					out.print("배송완료");
				}
				break;
			case "f": 	out.print("교환요청");	break;
			case "h": 	out.print("환불요청");	break;
			case "i": 	out.print("환불완료");	break;
			case "j": 	out.print("취소완료");	break;
			case "k": 	out.print("배송완료");	break;
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
	<tr class="btn"><td colspan="2"><input type="button" value="주문내역으로" onclick="location.href='order_list.mpg';"/></td></tr>
	</table>
	</div>
	</div>
</div>
<%} else {
	out.println("없음");
}
%>
</body>
</html>
