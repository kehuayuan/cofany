<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/acd/userGroupList";
		</script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-2.0.3.min.js"></script>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="div1">
	<div  class="margin_top20" >
		<table id="usertalbe"
			class="table table-striped table-bordered dataTable no-footer">
				<tr>
					<td>序号</td>
					<td>通道</td>
					<td>主叫号码</td>
					<td>技能组</td>
					<td>开始时间</td>																	
				</tr>
				<c:forEach items="${pager.list}" var="user">		
				 	<tr>				 	
						<td>${user.IVRIndex}</td>
						<td>${user.CALLID}</td>
						<td>${user.AgentID}</td>
						<td>${user.SkillGroup}</td>
						<td>${user.CallStartTime}</td>					
					</tr> 
					</c:forEach>
		</table>
	</div>
</div>
		<jsp:include page="/ivrlinemonitor/pager.jsp"></jsp:include>

</body>
</html>