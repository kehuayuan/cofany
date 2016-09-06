<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>公告</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirm.js"></script>
		<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/notice/list";
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="panel panel-danger">
				<div class="panel-heading">
					位置：权限管理-->公告
				</div>
				<div class="panel-body">
					<input type="button" class="btn btn-default btn-sm" value="添 加" onclick="addNotice();" />
					<table class="table table-bordered table-hover" style="margin-top:10px;">
						<thead>
							<tr>
								<th>标题</th>
								<th>内容</th>
								<th>发布时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${pager.list.size()==0}">
								<tr align="center">
									<td colspan="4" style="color:#f00;">暂无数据...</td>
								</tr>
							</c:if>
							<c:if test="${pager.list.size()>0}">
								<c:forEach items="${pager.list}" var="group">
									<tr>
										<td>${group.title}</td>
										<td>${group.content}</td>
										<td>${group.createTime}</td>
										<td>
											<input class="btn btn-primary btn-xs" type="button" value="编辑" onclick="edit('${group.ids}');" />
											<input class="btn btn-danger btn-xs" type="button" value="删除" onclick="del('${group.ids}')" />
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<jsp:include page="/notice/pager.jsp"></jsp:include>
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
									<label for="group_name">标题：</label>
									<input type="text" name="title" class="form-control" id="title" placeholder="标题" maxlength="80" />
									<span id="titleId" style="color:#f00">*</span>
								</div>
								<div class="form-group">
									<label for="group_name">内容：</label>
									<textarea name="content" id="content" class="form-control" rows="5" maxlength="180" style="resize:none;"></textarea>
									<span id="contentId" style="color:#f00">*</span>
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
			function addNotice(){
				$("#form")[0].reset();
				$("#formModal").modal("show");
			}
			
			function isNotNullForm(){
				if($.trim($("#title").val())==""){
					$("#titleId").html("不能为空");
					return false;
				}else{
					$("#titleId").html("");
				}
				if($.trim($("#content").val())==""){
					$("#contentId").html("不能为空");
					return false;
				}else{
					$("#contentId").html("");
				}
				return true;
			}
			
			function onSubmit(){
				if(isNotNullForm()){
					$.ajax({
						type : "post",
						url : "${pageContext.request.contextPath}/notice/submitNotice",
						data : $("#form").serialize(),
						dataType : "json",
						success : function(data){
							if(data.code==0){
								window.location.href = "${pageContext.request.contextPath}/notice/list";
							}else{
								alert(data.msg);
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
	                    		url : "${pageContext.request.contextPath}/notice/deleteNotice",
	                    		data : {ids:ids},
	                    		dataType : "json",
	                    		success : function(data){
	                    			if(data.code==0){
	                    				window.location.href = "${pageContext.request.contextPath}/notice/list";
	                    			}else{
	                    				alert(data.msg);
	                    			}
	                    		},
	                    		error : function(){
	                    			
	                    		}
	                    	});
	                    }
	                }
	            });
			}
			
			function edit(ids){
				$.ajax({
					async : false,
					url : "${pageContext.request.contextPath}/notice/loadNoticeByIds",
					data : {ids:ids},
					type : "post",
					dataType : "json",
					success : function(data){
						if(data){
							$("#ids").val(data.ids);
							$("#title").val(data.title);
							$("#content").val(data.content);
							$("#formModal").modal("show");
						}
					},
					error : function(){
						
					}
				});
			}
		</script>
	</body>
</html>