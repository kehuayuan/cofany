<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>用户组列表</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirm.js"></script>
		<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/mc/userGroupList";
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="panel panel-danger">
				<div class="panel-heading">
					位置：员工管理-->员工组
				</div>
				<div class="panel-body">
					<input type="button" class="btn btn-default btn-sm" value="添 加" onclick="addUserGroup();" />
					<table class="table table-bordered table-hover" style="margin-top:10px;">
						<thead>
							<tr>
								<th>组名</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pager.list}" var="group">
								<tr>
									<td>${group.group_name}</td>
									<td>${group.create_time}</td>
									<td>
										<input class="btn btn-primary btn-xs" type="button" value="编辑" onclick="edit(this,'${group.ids}');" />
										<input class="btn btn-danger btn-xs" type="button" value="删除" onclick="del('${group.ids}')" />
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
								<input type="hidden" name="ids" id="ids" />
								<div class="form-group">
									<label for="group_name">组名：</label>
									<input type="text" name="group_name" class="form-control" id="group_name" placeholder="组名" maxlength="50" />
								</div>
								<span id="groupId" style="color:#f00">*</span>
							</form>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-default" data-dismiss="modal" value="关闭" />
        					<input type="button" class="btn btn-primary" value="提交" onclick="onSubmit()" />
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			function addUserGroup(){
				$("#form")[0].reset();
				$("#formModal").modal("show");
			}
			
			function isNotNullForm(){
				if($.trim($("#group_name").val())==""){
					$("#groupId").html("不为空");
					return false;
				}else{
					$("#groupId").html("");
				}
				return true;
			}
			
			function onSubmit(){
				if(isNotNullForm()){
					$.ajax({
						type : "post",
						url : "${pageContext.request.contextPath}/mc/submitUserGroup",
						data : $("#form").serialize(),
						dataType : "json",
						success : function(data){
							if(data){
								window.location.href = "${pageContext.request.contextPath}/mc/userGroupList";
							}else{
								alert("操作失败!");
							}
						},
						error : function(){
							
						}
					});
				}
			}
			
			function del(ids){
				Confirm.show('删除操作', '您确定要删除吗？', {
	                '删除': {
	                    'primary': true,
	                    'callback': function() {
	                    	$.ajax({
	                    		type : "post",
	                    		url : "${pageContext.request.contextPath}/mc/deleteUserGroup",
	                    		data : {ids:ids},
	                    		dataType : "json",
	                    		success : function(data){
	                    			if(data.code==0){
	                    				window.location.href = "${pageContext.request.contextPath}/mc/userGroupList";
	                    			}else{
	                    				alert("操作失败");
	                    			}
	                    		},
	                    		error : function(){
	                    			
	                    		}
	                    	});
	                    }
	                }
	            });
			}
			
			function edit(obj,ids){
				var groupName = $(obj).parent().parent().find("td").eq(0).text();
				$("#ids").val(ids);
				$("#group_name").val(groupName);
				$("#formModal").modal("show");
			}
		</script>
	</body>
</html>