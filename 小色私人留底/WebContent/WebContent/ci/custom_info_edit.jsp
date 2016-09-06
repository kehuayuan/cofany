<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ncit.weixin.model.CustomInfoModel"%>
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
<jsp:include page="../cr/base_css.jsp"></jsp:include>
<jsp:include page="../cr/base_js.jsp"></jsp:include>
	<div class="container">
		<h2>编辑客户信息${tel}</h2>
	</div>
	<jsp:include page="custom_info_edit_cpt.jsp"></jsp:include>
</body>
</html>