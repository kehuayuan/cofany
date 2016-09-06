<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>技能组列表</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/statistical/ivrsvc";
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="panel panel-success">
				<div class="panel-heading">
					位置：权限管理-->技能组
				</div>
				<div class="panel-body">
					<input type="button" class="btn btn-default btn-sm" value="添 加" onclick="addIvrsvc();" />
					<table id="dataTable" class="table table-bordered table-hover" style="margin-top:10px;">
						<thead>
							<tr>
								<th>技能组ID</th>
								<th>技能组名称</th>
								<th>技能组ID1</th>
								<th>技能组ID2</th>
								<th>预留字段</th>
								<th>是否使用</th>
								<th>排队策略</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pager.list}" var="ivrsvc">
								<tr>
									<td>${ivrsvc.svccode}</td>
									<td>${ivrsvc.svcname}</td>
									<td>${ivrsvc.icdid1}</td>
									<td>${ivrsvc.icdid2}</td>
									<td>${ivrsvc.gubun}</td>
									<td>${ivrsvc.use_yn}</td>
									<td>${ivrsvc.remark}</td>
									<td>
										<input class="btn btn-primary btn-xs" type="button" value="编辑" onclick="edit('${ivrsvc.svccode}');" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<jsp:include page="/mc/pager.jsp"></jsp:include>
				</div>
			</div>
			
			<div id="formModal" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        					<h4 class="modal-title">编辑</h4>
						</div>
						<div class="modal-body">
							<form id="form" class="form-inline">
								<input type="hidden" name="isAdd" id="isAdd" />
								<input type="hidden" name="svccodeDefault" id="svccodeDefault" />
								<div class="form-group">
									<label for="user_id">技能组ID：</label>
									<input type="text" name="svccode" class="form-control" id="svccode" placeholder="技能组ID" maxlength="10" />
									<span id="svccodeId" style="color:#f00;">*</span>
								</div>
								<div class="form-group">
									<label for="user_id">技能组名称：</label>
									<input type="text" name="svcname" class="form-control" id="svcname" placeholder="技能组名称" maxlength="20" />
									<span id="svcnameId" style="color:#f00;">*</span>
								</div>
								<div class="form-group">
									<label for="user_id">技能组ID1：</label>
									<input type="text" name="icdid1" class="form-control" id="icdid1" placeholder="技能组ID1" maxlength="4" />
								</div>
								<div class="form-group">
									<label for="user_id">技能组ID2：</label>
									<input type="text" name="icdid2" class="form-control" id="icdid2" placeholder="技能组ID2" maxlength="4" />
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        					<input type="button" class="btn btn-primary" value="提交" onclick="onSubmit();"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			function addIvrsvc(){
				$("#form")[0].reset();
				$("#isAdd").val(1);
				$("#formModal").modal("show");
			}
		
			function edit(svccode){
				$("#isAdd").val(0);
				$.ajax({
					url : "${pageContext.request.contextPath}/statistical/getIvrsvcData",
					data : {svccode:svccode},
					type : "post",
					dataType : "json",
					success : function(data){
						if(data){
							$("#svccodeDefault").val(data.SVCCODE);
							$("#svccode").val(data.SVCCODE);
							$("#svcname").val(data.SVCNAME);
							$("#icdid1").val(data.ICDID1);
							$("#icdid2").val(data.ICDID2);
							$("#formModal").modal("show");
						}
					},
					error : function(){
						alert("服务器错误");
					}
				});
				
			}
			
			function onSubmit(){
				$.ajax({
					type : "post",
					url : "${pageContext.request.contextPath}/statistical/submitIvrsvc",
					data : $("#form").serialize(),
					dataType : "json",
					success : function(data){
						if(data.code==0){
							window.location.href = "${pageContext.request.contextPath}/statistical/ivrsvc";
						}else{
							alert(data.message);
						}
					},
					error : function(){
						alert("服务器错误");
					}
				});
			}
		</script>
	</body>
</html>