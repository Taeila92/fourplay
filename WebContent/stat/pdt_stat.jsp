<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../statistics_menu.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<StatPdtInfo> statPdtList = (ArrayList<StatPdtInfo>)request.getAttribute("statPdtList");
String plname = "";
for(int i = 0; i < statPdtList.size(); i++){
	plname += ", '"+ statPdtList.get(i).getPl_name()+ "'";
}
plname = plname.substring(1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<script src="stat/js/Chart.min.js"></script>
<script src="stat/js/utils.js"></script>
<script>
var color = Chart.helpers.color;
var barChartData = {
	labels: [<%=plname%>],
	datasets: [{
		label: '판매량',
		backgroundColor: [
			'rgba(255, 99, 132, 0.5)',
			'rgba(54, 162, 235, 0.5)',
			'rgba(255, 206, 86, 0.5)',
			'rgba(75, 192, 192, 0.5)',
			'rgba(153, 102, 255, 0.5)',
			'rgba(255, 159, 64, 0.5)',
			'rgba(96, 36, 99, 0.5)',
			'rgba(54, 222, 54, 0.5)',
			'rgba(125, 77, 55, 0.5)',
			'rgba(255, 187, 64, 0.5)'
		],
		borderColor: [
			'rgba(255, 99, 132, 1)',
			'rgba(54, 162, 235, 1)',
			'rgba(255, 206, 86, 1)',
			'rgba(75, 192, 192, 1)',
			'rgba(153, 102, 255, 1)',
			'rgba(255, 159, 64, 1)',
			'rgba(96, 36, 99, 1)',
			'rgba(54, 222, 54, 1)',
			'rgba(125, 77, 55, 1)',
			'rgba(255, 187, 64, 1)'
		],
		borderWidth: 1,
		data: 
		[
<%
		for(int i = 0; i < statPdtList.size(); i++){
			if(i == 0)		out.println(statPdtList.get(i).getOrders());
			else 			out.println(", " + statPdtList.get(i).getOrders());
		}
%>
		]
	}]
};

window.onload = function() {
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myBar = new Chart(ctx, {
		type: 'bar',
		data: barChartData,
		options: {
			responsive: true,
			legend:{ position:'top' }, 
			title:{ display:true, text:'누적 판매량 상위 10 상품' },
			scales: {
				yAxes : [{
					ticks: {
						beginAtZero:true
					}
				}]
			},
		}
	});
};
</script>
</head>
<body>
<div id="wrapper">
<div id="container" style="width: 75%;">
	<canvas id="canvas"></canvas>
</div>
</div>
</body>
</html>