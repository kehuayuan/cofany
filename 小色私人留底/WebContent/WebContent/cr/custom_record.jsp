<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.ncit.weixin.model.CustomRecordModel,java.net.URLEncoder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<div class="page-content">
		<div class="page-header">
			<h1>
				CTI中心 <small> <i class="icon-double-angle-right"></i> 呼叫系统
				</small>
			</h1>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->

				<div class="row">
					<div class="col-sm-6">
						<h4>客户信息</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<jsp:include page="../ci/custom_info_edit_cpt.jsp"></jsp:include>
	</div>
	<hr/>
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->

				<div class="row">
					<div class="col-sm-6">
						<h4>客户电话记录</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="btn-group">
			<a type="button" class="btn btn-default"
				href="custom_record_edit.jsp?callback=<%=URLEncoder.encode("custom_record.jsp?tel=" + request.getParameter("tel"), "utf-8")%>&tel=<%=request.getParameter("tel")%>">增加</a>
		</div>
	</div>
	<div class="container">
		<%
			Object po = CustomRecordModel.dao.pagingByTel(request.getParameter("tel"), request.getParameter("start"),
					request.getParameter("limit"));
			request.setAttribute("po", po);
			request.setAttribute("pageUrl", "custom_record.jsp?tel=" + request.getParameter("tel"));
			request.setAttribute("editCallbackUrl",
					URLEncoder.encode("custom_record.jsp?" + CustomRecordModel.dao.generateParams(request)));
		%>
		<c:if test="${empty po.list }">
			<div class="panel">

				<p class="panel-body">
					暂无<%=request.getParameter("tel")%>的记录，请<a
						href="custom_record_edit.jsp?tel=<%=request.getParameter("tel")%>&callback=<%=URLEncoder.encode("custom_record.jsp?tel=" + request.getParameter("tel"), "utf-8")%>">添加</a>
				</p>
			</div>
		</c:if>
		<c:if test="${!empty po.list }">
			<jsp:include page="custom_record_list.jsp"></jsp:include>
		</c:if>
	</div>

	<script type="text/javascript">
		table_row_select('#custom_record_modal');
	</script>
</body>
</html>