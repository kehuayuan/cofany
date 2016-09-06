<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String basePath = request.getServletContext().getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/jquery-easyui-1.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/jquery-easyui-1.4/themes/icon.css">
<script type="text/javascript" src="<%=basePath%>/jquery-easyui-1.4/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery-easyui-1.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/assets/js/permission/perm.js"></script>
<script type="text/javascript">
	var basePath = '<%=basePath%>';
</script>
</head>
<body>
	<div>
		<table id="dg"></table>
	</div>
	<div id="roleWin" class="easyui-window" data-options="closed:true">
		<form id="setRoleForm">
			<input type="hidden" id="userid" name="userId" />
			选择角色：<section id="rolelist" class="easyui-combogrid" name="roles"></section>
			<input type="button" value="提交" onclick="setRole()" />
		</form>
	</div>
</body>
</html>