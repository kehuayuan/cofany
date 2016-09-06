<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realPath = request.getServletContext().getContextPath();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>录音查询</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.4/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.4/themes/icon.css">
		<script type="text/javascript">
			var rootPath = "<%=realPath%>";
		</script>
	</head>
	<body>
		
		<div>
			<h3>当前位置：电话统计-->录音查询</h3>
		</div>
		
		<audio id="audio_file"></audio>
		
		<table id="dg"></table>
		<div id="tools" style="padding:5px;height:auto">
			<div>
				开始时间：
				<input id="startTime" class="easyui-datetimebox" style="width:200px">
				结束时间：
				<input id="endTime" class="easyui-datetimebox" style="width:200px">
				主叫号码：
				<input id="callerNum" class="easyui-textbox" type="text"></input>
				被叫号码：
				<input id="calleeNum" class="easyui-textbox" type="text"></input>
				文件名包括：
				<input id="fPath" class="easyui-textbox" type="text"></input>
				技能组：
				<input id="svccode" class="easyui-textbox" type="text"></input>
				<a href="javascript:query();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
			</div>
		</div>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/audio5.min.js"></script> --%>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.4/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/recordlog/recordlog.js"></script>
	</body>
</html>