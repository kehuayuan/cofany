<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
	    var _contextPath = '<%=request.getContextPath()%>';
</script>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/Chart.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery-2.0.3.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/flot/jquery.flot.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/confirm.js"></script>
<script type="text/javascript">
	var path = "${pageContext.request.contextPath}/acd/userGroupList";
	</script>

<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:_contextPath+"/acd/userGroupList",
		type:"POST",
		success:function(data){
			$("#ss").html(data);
		}
	});
});
</script>
</head>
<body>

	<h3>当前位置-->ACD排队监控界面:</h3>
	<div>
		<input type="button" value="刷新"
			onclick="javascript:window.location.reload()">
		<jsp:include page="base_css.jsp"></jsp:include>
		<jsp:include page="base_js.jsp"></jsp:include>
		技能组: <select id="jin" onchange="sele()">
			<option value=" ">所有</option>
			<c:forEach items="${lis}" var="lis">
				<option value="${lis.SVCNAME }">${lis.SVCNAME }</option>
			</c:forEach>
		</select>
	</div>

	<!-- Oscillogram  -->
	<div>
		<canvas id="canvas" height="300" width="1100"></canvas>
	</div>
		<div class="margin_top20">
			<table id="usertalbe"
				class="table table-striped table-bordered dataTable no-footer">
				<tbody id="ss"></tbody>
			</table>
		</div>
    
	<script type="text/javascript">
			/*通道饼图*/
			$(document).ready(function(){
				
				soso();	
			  	var inter="";
				clearInterval("inter");
				inter= setInterval("soso()",6000);  
			});
			
			function soso(){
		 	var myLineChart = $("#canvas").get(0).getContext("2d");
			$.ajax({
				url : "${pageContext.request.contextPath}/acd/countOne",
				dataType : "json",
				success : function(data){				
					new Chart(myLineChart).Line(data.bar,{scaleFontSize : 13, scaleFontColor : "#ffa45e"});
				},
				error : function(){
					alert("服务器请求错误");
				}
			});
			}
		</script>
		<script type="text/javascript">
		function sele(){	 
	   var parm= $("#jin").val();
	
	$("#ss").html(" ");
	$.ajax({
		url:_contextPath+"/acd/select1",
		type:"POST",
		data:{"parm":parm},
		success:function(data){
			$("#ss").html(data);
		}
	});
}

</script>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:_contextPath+"/acd/userGroupList",
		type:"POST",
		success:function(data){
			$("#ss").html(data);
		}
	});
});
</script>
</body>
</html>