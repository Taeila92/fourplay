<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("utf-8");
OrdListInfo ordInfo = (OrdListInfo)request.getAttribute("ordInfo");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 
<link href="css/reset.css" type="text/css" rel="stylesheet" />
<link href="css/base.css" type="text/css" rel="stylesheet" />
 -->
<style>
#wrapper {font-size:12px;}
#wrapper table td {border-bottom:1px solid lightgray; align:center;}
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:underline;  font-weight:bold;}
a:active { color:#f00; text-decoration:none; }	
a:focus { color:#f00; text-decoration:underline; }
</style>
<script>
function ordCancel(olid){
	if(confirm('주문을 취소하시겠습니까?\n취소 철회는 불가능합니다.')){
		location.href="ord_proc.ord?olid="+olid;
	}
}
</script>
</head>
<body>
<h2>비회원 ORDER LIST</h2>
<div id="wrapper">
<table width="900" cellpadding="5" cellspacing="0" border="0">
	<div class="head">
	<tr style="background-color:#e1e1e1; ">
	<th width="15%">주문일자<br />[주문번호]</th><th width="10%">사진</th><th width="*">상품정보</th><th width="5%">수량</th>
	<th width="8%">가격</th><th width="10%">주문처리상태</th><th width="15%">취소/교환/반품</th>
	</tr>
	</div>
	<div class="ordList">
	<tr>
	<td><a href="non_order_detail.mpg?olid=<%=ordInfo.getOl_id() %>&bname=<%=ordInfo.getOl_bname()%>">
	<%=ordInfo.getOl_date().substring(0,11) %>
	<br />[<%=ordInfo.getOl_id() %>]</a></td>
	<td><img src='/fourplay/product/pdt_img/<%=ordInfo.getOrdDetailList().get(0).getPl_img1() %>' width='50' align="absmiddle"/></td>
	<td>
	<%
	for(int i = 0 ; i < ordInfo.getOrdDetailList().size(); i++){
		String plid = ordInfo.getOrdDetailList().get(i).getPl_id();
		String plname = ordInfo.getOrdDetailList().get(i).getPl_name();
		String opt = ordInfo.getOrdDetailList().get(i).getOd_opt();
		if(opt == null)		opt = "옵션없음";
		if(i == ordInfo.getOrdDetailList().size() -1){	//해당 주문의 마지막 상품이면
			out.print("<a href='/product/product_detail.jsp?id=" + plid + "'>"
				+ plname + "<br />[" + opt + "]</a> <br />");
		} else {
			out.print("<a href='/product/product_detail.jsp?id=" + plid + "'>"
					+ plname + "<br />[" + opt + "]</a>, <br />");
		}
	} 
	%>
	</td>
	<td>
	<%
	int cnt = 0;
	for (int i = 0; i < ordInfo.getOrdDetailList().size(); i++) {
		cnt += ordInfo.getOrdDetailList().get(i).getOd_cnt();
	} 
	out.print(cnt);
	%>
	</td>
	<td><%=ordInfo.getOl_pay() %></td>
	<td>
	<%
	switch(ordInfo.getOl_status()){
		case "a": 							out.print("입금 전<br />계좌번호: 국민은행<br />6131802-01473-365(김현수)");		break;
		case "b": 							out.print("입금 확인");														break;
		case "c": 							out.print("상품준비중");													break;
		case "d": 							out.print("배송중<br/>한진택배: 419079564046");								break;
		case "e": 	case "k":				out.print("배송완료");														break;
		case "f": 							out.print("교환요청");														break;
		case "g": 							out.print("교환완료");														break;
		case "h": 							out.print("환불요청");														break;
		case "i": 							out.print("환불완료");														break;
		case "j": 							out.print("취소");														break;
	}
	%></td>
	<td>
	<%
	switch(ordInfo.getOl_status()){
		case "a": case "b": case"c": 	out.print("<input type='button' value='주문취소' onclick='ordCancel("+ ordInfo.getOl_id()+");'/>");		break;
		case "d": case "g":				out.print("<input type='button' value='교환/반품' onclick=''/>");											break;
		case "e":						out.print("배송완료");	break;
		case "f": 						out.print("교환요청");	break;
		case "h": 						out.print("환불요청");	break;
		case "i": 						out.print("환불완료");	break;
		case "j": 						out.print("취소완료");	break;
	}
	%>
	</td>
	</tr>
	</div>
</table>
</div>
</body>
</html>