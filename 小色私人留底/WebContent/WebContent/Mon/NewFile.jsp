<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">

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
<c:if test="${pager.pageNumber>1 }">
<a href="/wxapi/cangent">返回查询页面</a>
</c:if>
	<div  class="margin_top20" >
		<table id="usertalbe"
			class="table table-striped table-bordered dataTable no-footer">
				<tr>
					<td>IP地址</td>
					<td>坐席名称</td>
					<td>内线号码</td>
					<td>技能组</td>
					<td>呼叫方向</td>
					<td>状态</td>
				</tr>
				<c:forEach items="${pager.list }" var="sas">
                   <tr>
                        <td>${sas.agentname}</td>
                        <td>${sas.ipaddress}</td>
                        <td>${sas.extn}</td>
                         <td>${sas.svcname}</td>
                         <td>${sas.direction}</td>
                         <td>${sas.state}</td>
                   </tr>
                 </c:forEach>
		</table>
		<jsp:include page="/Mon/pager.jsp"></jsp:include>
	</div>


</body>
</html>