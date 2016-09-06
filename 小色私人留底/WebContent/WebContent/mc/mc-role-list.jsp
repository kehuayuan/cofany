<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>角色列表</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirm.js"></script>
		<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/mc/roleList";
			$(function(){
				
				$(".permission-menu input[name='permissionId']").on("click",function(){
					var obj = $(this).parent().parent().parent();
					if(obj.siblings().length>0){
						var domDTObject = obj[0];
						
						if(domDTObject.tagName=="DT"){
							var isCheckedDT = $(domDTObject).find("input[type='checkbox']").prop("checked");
							if(isCheckedDT){
								$(domDTObject).siblings().each(function(i){
									$(this).find("input[type='checkbox']").prop("checked",true);
								});
							}else{
								$(domDTObject).siblings().each(function(i){
									$(this).find("input[type='checkbox']").prop("checked",false);
								});
							}
						}
						/* if(obj.hasClass("menu-margin-left")){
							
						}else{
							
						} */
					}
				});
				
				$(".permi-sub-menu input[name='permissionId']").on("click",function(){
					var _firstObj = $(this);
					var _secondObj = $(this).parent().parent().parent();
					if(_firstObj.prop("checked")){
						_secondObj.siblings(".menu-margin-left").each(function(i){
							$(this).find("input[type='checkbox']").prop("checked",true);
						});
					}else{
						_secondObj.siblings(".menu-margin-left").each(function(i){
							$(this).find("input[type='checkbox']").prop("checked",false);
						});
					}
				});
				
				$(".permission-menu dd input[type='checkbox']").on("click",function(){
					var obj = $(this).parent().parent().parent().parent(".permission-menu");
					obj.find("dt input[type='checkbox']").prop("checked",true);
					var arry = new Array();
					obj.find("dd").each(function(i){
						var flag = $(this).find("input[type='checkbox']").prop("checked");
						arry.push(flag);
					});
					
					if($.inArray(true,arry)<0){
						obj.find("dt input[type='checkbox']").prop("checked",false);
					}
				});
			});
		</script>
		<style type="text/css">
			.permission-menu{float:left;margin-left:10px;}
			.permission-menu dd{margin-left:20px;}
			.menu-margin-left{padding-left:15px;}
		</style>
	</head>
	<body>
		<div class="container-fluid">
			<div class="panel panel-info">
				<div class="panel-heading">
					位置：员工管理-->角色列表
				</div>
				<div class="panel-body">
					<input id="addRoleId" type="button" class="btn btn-default btn-sm" value="添 加" onclick="addRole();" />
					<table class="table table-bordered table-hover" style="margin-top:10px;">
						<thead>
							<tr>
								<th>名称</th>
								<th>描述</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pager.list}" var="role">
								<tr>
									<td>${role.role_name}</td>
									<td>${role.description}</td>
									<td>
										<input class="btn btn-primary btn-xs" type="button" value="编辑" onclick="edit(this,'${role.ids}');" />
										<input class="btn btn-danger btn-xs" type="button" value="删除" onclick="del('${role.ids}')" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<jsp:include page="/mc/pager.jsp"></jsp:include>
				</div>
			</div>
			
			<div id="formModal" class="modal fade">
				<div class="modal-dialog" style="width:60%;">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        					<h4 class="modal-title">编辑</h4>
						</div>
						<div class="modal-body">
							<form id="form" class="form-inline">
								<input type="hidden" name="ids" id="ids" />
								<div class="form-group">
									<label for="role_name">名称：</label>
									<input type="text" name="role_name" class="form-control" id="role_name" placeholder="名称" maxlength="30" />
									<span id="roleId" style="color:#f00;">*</span>
								</div>
								<div class="form-group" style="margin-left:10px;">
									<label for="description">描述：</label>
									<textarea name="description" class="form-control" id="description" rows="3" style="resize:none;" maxlength="100"></textarea>
								</div>
								<div class="form-group">
									<!-- <label>功能菜单：</label> -->
									<%-- <c:forEach items="${permissionList}" var="permission">
										<label class="checkbox-inline">
											<input name="permissionId" type="checkbox" value="${permission.ids}" />${permission.permission_name}
										</label>
									</c:forEach> --%>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="1" /> 控制台
												</label>
											</div>
										</dt>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="2" /> 微信平台
												</label>
											</div>
										</dt>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="3" /> 微信客服
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="4" /> 微信统计
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="5" /> 微信客户资料
												</label>
											</div>
										</dd>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="6" /> 客户电话管理
												</label>
											</div>
										</dt>
										<dd>
											<div class="checkbox permi-sub-menu">
												<label>
													<input type="checkbox" name="permissionId" value="7" /> 客户电话
												</label>
											</div>
											<dd class="menu-margin-left">
												<div class="checkbox">
													<label>
														<input type="checkbox" name="permissionId" value="36" /> 客户电话分配
													</label>
												</div>
											</dd>
											<dd class="menu-margin-left">
												<div class="checkbox">
													<label>
														<input type="checkbox" name="permissionId" value="37" /> 我的客户电话
													</label>
												</div>
											</dd>
											<dd class="menu-margin-left">
												<div class="checkbox">
													<label>
														<input type="checkbox" name="permissionId" value="38" /> 公共客户电话
													</label>
												</div>
											</dd>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="8" /> 客户电话工单记录
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="9" /> 电话客户资料
												</label>
											</div>
										</dd>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="10" /> 权限管理
												</label>
											</div>
										</dt>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="11" /> 员工列表
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="12" /> 员工组
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="13" /> 角色列表
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="14" /> 权限分配
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="41" /> 技能组
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="42" /> 公告
												</label>
											</div>
										</dd>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="15" /> 知识库
												</label>
											</div>
										</dt>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="16" /> 话术
												</label>
											</div>
										</dt>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="17" /> 总体统计
												</label>
											</div>
										</dt>
										<dd>
											<div class="checkbox permi-sub-menu">
												<label>
													<input type="checkbox" name="permissionId" value="18" /> 电话统计
												</label>
											</div>
											<dd class="menu-margin-left">
												<div class="checkbox">
													<label>
														<input type="checkbox" name="permissionId" value="20" /> 录音查询
													</label>
												</div>
											</dd>
											<dd class="menu-margin-left">
												<div class="checkbox">
													<label>
														<input type="checkbox" name="permissionId" value="40" /> IVR查询
													</label>
												</div>
											</dd>
										</dd>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="21" /> 监控
												</label>
											</div>
										</dt>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="22" /> 呼叫监控
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="23" /> IVR排队监控
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="24" /> 坐席监控
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="25" /> 微信监控
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="26" /> 微信排队监控
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="27" /> 微信坐席监控
												</label>
											</div>
										</dd>
									</dl>
									<dl class="permission-menu">
										<dt>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="28" /> 其他
												</label>
											</div>
										</dt>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="29" /> 日历提醒
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="30" /> 黑名单
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="31" /> VIP名单
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="32" /> 用户信息
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="33" /> 操作日志记录
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="34" /> 相册
												</label>
											</div>
										</dd>
										<dd>
											<div class="checkbox">
												<label>
													<input type="checkbox" name="permissionId" value="35" /> 日历
												</label>
											</div>
										</dd>
									</dl>
								</div>
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
			function addRole(){
				$("#form")[0].reset();
				$("#formModal").modal("show");
			}
			
			function isNotNullForm(){
				if($.trim($("#role_name").val())==""){
					$("#roleId").html("不为空");
					return false;
				}else{
					$("#roleId").html("");
				}
				return true;
			}
			
			function edit(obj,ids){
				
				$("input[name='permissionId']").prop("checked",false);
				
				var roleName = $(obj).parent().parent().find("td").eq(0).text();
				var description = $(obj).parent().parent().find("td").eq(1).text();
				
				$.ajax({
					async : false,
					url : '${pageContext.request.contextPath}/mc/getPermissionOfRole',
					data : {role_id:ids},
					type : 'post',
					dataType : 'json',
					success : function(data){
						$("input[name='permissionId']").each(function(){
							if($.inArray($(this).val(),data)>=0){
								$(this).prop("checked",true);
							}
						});
					},
					error : function(){
						alert("服务器请求失败！");
					}
				});
				
				$("#ids").val(ids);
				$("#role_name").val(roleName);
				$("#description").val(description);
				$("#formModal").modal("show");
			}
			function onSubmit(){
				if(isNotNullForm()){
					$.ajax({
						type : "post",
						url : "${pageContext.request.contextPath}/mc/submitRole",
						data : $("#form").serialize(),
						dataType : "json",
						success : function(data){
							if(data){
								window.location.href = "${pageContext.request.contextPath}/mc/roleList";
							}else{
								alert("操作失败!");
							}
						},
						error : function(){
							alert("服务器请求失败！");
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
	                    		url : "${pageContext.request.contextPath}/mc/deleteRole",
	                    		data : {ids:ids},
	                    		dataType : "json",
	                    		success : function(data){
	                    			if(data.code==0){
	                    				window.location.href = "${pageContext.request.contextPath}/mc/roleList";
	                    			}else{
	                    				alert(data.message);
	                    			}
	                    		},
	                    		error : function(){
	                    			alert("服务器请求失败！");
	                    		}
	                    	});
	                    }
	                }
	            });
			}
		</script>
	</body>
</html>