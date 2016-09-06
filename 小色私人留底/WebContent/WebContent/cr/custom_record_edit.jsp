<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ncit.weixin.model.CustomRecordModel"%>
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
	<%
		String id = request.getParameter("id");
		String tel = request.getParameter("tel");
		if(id!=null){
			CustomRecordModel m = CustomRecordModel.dao.findById(id);
			request.setAttribute("m", m);
			request.setAttribute("tel", m.getTel());
		}else{
			request.setAttribute("tel", tel);
		}
		
	%>
	<div class="container">
		<h2>客户${tel}的电话记录</h2>
	</div>
	<div class="container">
		<form id="cr_edit_form" role="form" action="doInsert">
			<div class="input-group">
				<span class="input-group-addon">信息</span> <textarea type="text"
					name="msg" value=""
					class="form-control" placeholder="请输入信息">${m.msg}</textarea>
			</div>
			<input type="hidden" name="tel" value="${tel}" />
			<input type="hidden" name="id" value="${m.crId}" />
			<input type="hidden" name="callback" value="<%=request.getParameter("callback") %>" />
			<br />
			<button type="submit" class="btn btn-success">提交</button>
			<a class="btn btn-default " rel="back">返回</a>
		</form>
	</div>

	<script type="text/javascript">
		
	</script>
</body>
</html>