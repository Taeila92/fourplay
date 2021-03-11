<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*, java.util.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../statistics_menu.jsp" %>
<%
String year = (String)request.getAttribute("year");
ArrayList<StatPdtInfo> statSalesList = (ArrayList<StatPdtInfo>)request.getAttribute("statSalesList");
String month = "", sales = "";
for(int i = 0; i < statSalesList.size(); i++ ){
	month += ", '" + statSalesList.get(i).getMonth() + "월' ";
	sales += ", " + statSalesList.get(i).getSales();
}
month = month.substring(1);
sales = sales.substring(1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
canvas{
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<script src="stat/js/Chart.min.js"></script>
<script src="stat/js/utils.js"></script>
<script>
var config = {
	type: 'line',
	data: {
		labels: [<%=month%>], 
		datasets: [{
			label: '매출액', 
			backgroundColor: window.chartColors.red,
			borderColor: window.chartColors.red,
			data: [<%=sales%>], 
			fill: false,
		}]
	},
	options: {
		responsive: true,
		title: { display: true, text: '<%=year%>년 월별 매출' }, 
		tooltips: { mode: 'index', intersect: false }, 
		hover: { mode: 'nearest', intersect: true }, 
		scales: { 
			xAxes: [{ display:true, scaleLabel:{ display:true, labelString:'월별' } }],
			yAxes: [{ display:true, scaleLabel:{ display:true, labelString:'금액' } }]
		}
	}
};

window.onload = function() {
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myLine = new Chart(ctx, config);
};
</script>
</head>
<body>
<div id="wrapper">
<div style="width:75%;">
	<canvas id="canvas"></canvas>
</div>
</div>
</body>
</html>