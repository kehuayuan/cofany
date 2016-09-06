<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>wx_msg</title>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

<script type="text/javascript" src="../assets/js/jquery-1.10.2.min.js"></script>

<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

</head>
<body>
	<jsp:include page="base_css.jsp"></jsp:include>
	<jsp:include page="base_js.jsp"></jsp:include>	
	<div class="container">
		<h2>操作成功</h2>
	</div>

	<div class="container">
		<a type="button" class="btn btn-success"
			href="<%=request.getParameter("callback")%>">确认</a>
		<!-- <a type="button" class="btn btn-default" rel="back">关闭</a> -->
	</div>
</body>
</html>