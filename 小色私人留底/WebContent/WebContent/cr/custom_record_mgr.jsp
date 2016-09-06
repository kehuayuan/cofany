<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ncit.weixin.model.CustomRecordModel,java.net.URLEncoder"%>
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
		<form role="form" action="custom_record_mgr.jsp">
			<div class="input-group">
				<span class="input-group-addon">手机号</span> <input type="text"
					name="tel_key" class="form-control" placeholder="请输入手机号" value="<%=request.getParameter("tel_key")==null?"":request.getParameter("tel_key")%>"></input>
			</div>
			<div class="input-group">
				<span class="input-group-addon">关键字</span> <input type="text"
					value="<%=request.getParameter("key_word")==null?"":request.getParameter("key_word")%>"
					name="key_word" class="form-control" placeholder="请输入关键字"></input>
			</div>
			<!-- <div class="input-group">
				<span class="input-group-addon">起始日期</span> <input type="date"
					name="start"
					class="form-control" placeholder="起始日期"></input>
			</div>
			<div class="input-group">
				<span class="input-group-addon">终止日期</span> <input type="date"
					name="end"
					class="form-control" placeholder="终止日期"></input>
			</div> -->
			<button type="submit" class="btn btn-default"
				href="custom_record_mgr.jsp">查询</button>
			<!-- <a type="button" class="btn btn-default"
				href="custom_record_edit.jsp?callback=custom_record_mgr.jsp">增加</a> -->
		</form>
	</div>

	<div class="container">
		<%
			Object po = CustomRecordModel.dao.pagingByReqeust(request);
			request.setAttribute("po", po);
			request.setAttribute("pageUrl", "custom_record_mgr.jsp?" + CustomRecordModel.dao.generateParams(request));
			request.setAttribute("editCallbackUrl", URLEncoder.encode("custom_record_mgr.jsp?" + CustomRecordModel.dao.generateParams(request)));
		%>
		<jsp:include page="custom_record_list.jsp"></jsp:include>
	</div>

	<script type="text/javascript">
		table_row_select('#custom_record_modal');
	</script>
</body>
</html>