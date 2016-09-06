<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">

<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<script type="text/javascript" src="/assets/js/jquery-2.0.3.min.js"></script>

<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirm.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/Chart.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-2.0.3.min.js"></script>
		<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/ctrunk/userGroupList";
		</script>
<style type="text/css">
       .div1 
        {
          float:left;  width:100%; height:180px;
        }
       .margin_top20
        {
          float:left; width:70%; height:180px;
        }
    	.container
        {
            width:30%;height:180px; float:right; margin-top: 10px;
        }
</style>
</head>
<body>
	<jsp:include page="base_css.jsp"></jsp:include>
	<jsp:include page="base_js.jsp"></jsp:include>

	<div>
		<h4>当前位置：监控-->IVR排队监控</h4>
	</div>
	<br>
	<div>
		<input type="button" value="刷新"
			onclick="javascript:window.location.reload()">
	</div>
	<br>
<div class="div1">
	<div  class="margin_top20" >
		<table id="usertalbe"
			class="table table-striped table-bordered dataTable no-footer">
			<thead>
			<tr>
					<td>IVR通道</td>
					<td>通道状态</td>
					<td>本状态持续时间</td>
					<td>空闲时间</td>
					<td>通话时间</td>
					<td>通话个数</td>	
				</tr>

				<c:forEach var="list" items="${pager.list}">
				<tr>
						<td>${list.Trunk}</td>
						<c:if test="${list.TkState=='1'}">
						<td>空闲</td>
						</c:if>
						
						<c:if test="${list.TkState=='2'}">
						<td>连接</td>
						</c:if>
						<c:if test="${list.TkState=='3'}">
						<td>振铃</td>
						</c:if>
						<c:if test="${list.TkState=='0'||list.TkState>'3'}">
						<td>其他</td>
						</c:if>
						<td>${list.Duration}</td>
						<td>${list.AVAILTIME}</td>
						<td>${list.ACDTIME}</td>
						<td>${list.ACDCALLS}</td>
						</tr>	
			</c:forEach>
			</tbody>
		</table>
		<jsp:include page="/ivrlinemonitor/pager.jsp"></jsp:include>
	</div>
	<!-- Pie Chart  -->
	<div class="container"  >		
						<div class="panel-body text-center">
							<canvas id="pieChatId" width="250" height="250" ></canvas>
							<br>
							<button  style="background-color:#FFDEAD;"  ><label>其他</label></button>&nbsp;
							<button  style="background-color:#7afec6;"><label>通话</label></button>&nbsp;
							<button  style="background-color: #7d7dff;"><label>振铃</label></button>&nbsp;
							<button  style="background-color: yellow;"><label>等待</label></button>&nbsp;
						</div> 
						<div   align="center">通道数量</div>
					</div>
	</div>	
		<script type="text/javascript">
			/*通道饼图*/
		 	var pieChat = $("#pieChatId").get(0).getContext("2d");
			$.ajax({
				url : "${pageContext.request.contextPath}/ctrunk/customerCount",
				dataType : "json",
				success : function(data){
					new Chart(pieChat).Pie(data.pie);
				},
				error : function(){
					alert("服务器请求错误");
				}
			}); 
		</script>
		<script type="text/javascript">
		var pieChat = $("#pieChatId").get(0).getContext("2d");
			function play(num){
				$.ajax({
					url : "${pageContext.request.contextPath}/ctrunk/lineCount",
					data : {"num":num},
					dataType : "json",
					success : function(data){
						new Chart(pieChat).Pie(data.pie);
					},
					error : function(){
						alert("服务器请求错误");
					}
				});
			}
		</script>
</body>
</html>
