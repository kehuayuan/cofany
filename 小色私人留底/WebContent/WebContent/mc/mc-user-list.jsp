<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>员工列表</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirm.js"></script>
		<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/mc/userList";
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="panel panel-success">
				<div class="panel-heading">
					位置：员工管理-->用户列表
				</div>
				<div class="panel-body">
					<input type="button" class="btn btn-default btn-sm" value="添 加" onclick="addUser();" />
					<table id="dataTable" class="table table-bordered table-hover" style="margin-top:10px;">
						<thead>
							<tr>
								<th>名称</th>
								<th>员工组</th>
								<th>角色</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pager.list}" var="user">
								<tr>
									<td>${user.user_id}</td>
									<td>${user.groups}</td>
									<td>${user.roles}</td>
									<td>
										<input class="btn btn-primary btn-xs" type="button" value="编辑" onclick="edit('${user.userids}','${user.user_id}','${user.email}','${user.tel}','${user.roleids}','${user.groupids}');" />
										<input class="btn btn-danger btn-xs" type="button" value="删除" onclick="del('${user.userids}')" />
										<input class="btn btn-info btn-xs" type="button" value="分配技能组" onclick="allotIvrsvc('${user.userids}','${user.user_id}')" />
										<input class="btn btn-info btn-xs" type="button" value="点击查看详情" data-toggle="popover" />
										<div style="display:none">
											<p><label>邮箱：</label>${user.email}</p>
											<p><label>电话：</label>${user.tel}</p>
											<p><label>角色：</label>${user.roles}</p>
											<p><label>员工组：</label>${user.groups}</p>
										</div>
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
									<label for="user_id">名称：</label>
									<input type="text" name="user_id" class="form-control" id="user_id" placeholder="名称" maxlength="20" />
									<span id="userId" style="color:#f00;">*</span>
								</div>
								<div class="form-group" style="margin-left:10px;">
									<label for="email">邮箱：</label>
									<input type="email" name="email" class="form-control" id="email" placeholder="邮箱" maxlength="50" />
								</div>
								<div class="form-group" style="margin-top:10px;">
									<label for="tel">电话：</label>
									<input type="tel" name="tel" class="form-control" id="tel" placeholder="电话" maxlength="20" />
								</div>
								<div class="form-group" style="margin:10px 0px 0px 10px;">
									<label>角色：</label>
									<select name="user-role" id="user_role" class="form-control">
										<option value="">请选择角色</option>
										<c:forEach items="${roleList}" var="role">
											<option value="${role.ids}">${role.role_name}</option>
										</c:forEach>
									</select>
									<span id="roleId" style="color:#f00;">*</span>
								</div>
								<div class="form-group" style="margin:10px 0px 0px 2px;">
									<label>员工组：</label>
									<select name="user-group" id="user-group" class="form-control">
										<option value="">请选择员工组</option>
										<c:forEach items="${userGroupList}" var="userGroup">
											<option value="${userGroup.ids}">${userGroup.group_name}</option>
										</c:forEach>
									</select>
									<span id="groupId" style="color:#f00;">*</span>
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
			
			<div id="allotModal" class="modal fade">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        					<h4 class="modal-title">分配技能组</h4>
						</div>
						<div class="modal-body">
							<form id="allotForm" class="form">
								<input type="hidden" name="userids" id="userids" />
								<div class="form-group">
									<label for="user_id">员工名称：</label>
									<input type="text" class="form-control" id="userName" disabled="disabled" />
								</div>
								<div class="form-group">
									<label for="user_id">选择技能组：</label>
									<select multiple class="form-control" name="svccode" id="svccodeId" style="height:200px;">
										<c:forEach items="${ivrsvcList}" var="ivrsvc">
											<option value="${ivrsvc.svccode}">${ivrsvc.svcname}</option>
										</c:forEach>
									</select>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        					<input type="button" class="btn btn-primary" value="提交" onclick="onAllot();"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			$(function(){
				$('[data-toggle="popover"]').popover({
					html : true,
					title : function(){
						return "<b style='font-size:18px;'>"+$(this).parent().parent().find("td").eq(0).text()+"</b>";
					},
					content : function(){
						return $(this).parent().find("div").html();
					}
				});
			});
			
			function isNotNullForm(){
				if($.trim($("#user_id").val())==""){
					$("#userId").html("不为空");
					return false;
				}else{
					$("#userId").html("");
				}
				if($.trim($("#user_role").val())==""){
					$("#roleId").html("不为空");
					return false;
				}else{
					$("#roleId").html("");
				}
				if($.trim($("#user-group").val())==""){
					$("#groupId").html("不为空");
					return false;
				}else{
					$("#groupId").html("");
				}
				
				return true;
			}
		
			function addUser(){
				$("#form")[0].reset();
				$("#formModal").modal("show");
			}
		
			function edit(ids,user_id,email,tel,roleids,groupids){
				$("#ids").val(ids);
				$("#user_id").val(user_id);
				$("#email").val(email);
				$("#tel").val(tel);
				$("#user_role").val(roleids);
				$("#user-group").val(groupids);
				$("#formModal").modal("show");
			}
			
			/**给用户分配技能组*/
			function allotIvrsvc(userids,userName){
				$("#userids").val(userids);
				$("#userName").val(userName);
				$.ajax({
					async : false,
					url : "${pageContext.request.contextPath}/mc/findIvrsvcOfUser",
					type : "post",
					data : {userids:userids},
					dataType : "text",
					success : function(data){
						if(data != ""){
							var array = [];
							var arr = data.split(",");
							for(var i=0; i<arr.length; i++){
								array.push(arr[i]);
							}
							$("#svccodeId").val(array);
						}
					},
					error : function(){
						alert("服务器错误");
					}
				});
				$("#allotModal").modal("show");
			}
			
			/** 提交分配技能组数据 */
			function onAllot(){
				$.ajax({
					url : "${pageContext.request.contextPath}/mc/allotIvrsvc",
					type : "post",
					data : $("#allotForm").serialize(),
					dataType : "json",
					success : function(data){
						window.location.href = "${pageContext.request.contextPath}/mc/userList";
					},
					error : function(){
						alert("服务器错误");
					}
				});
			}
			
			function onSubmit(){
				if(isNotNullForm()){
					$.ajax({
						type : "post",
						url : "${pageContext.request.contextPath}/mc/submitUser",
						data : $("#form").serialize(),
						dataType : "json",
						success : function(data){
							if(data){
								window.location.href = "${pageContext.request.contextPath}/mc/userList";
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
	                    		url : "${pageContext.request.contextPath}/mc/deleteUser",
	                    		data : {ids:ids},
	                    		dataType : "json",
	                    		success : function(data){
	                    			if(data){
	                    				window.location.href = "${pageContext.request.contextPath}/mc/userList";
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
		</script>
	</body>
</html>