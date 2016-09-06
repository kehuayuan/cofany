<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>管理中心</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
	</head>
	<body>
		
		<nav class="navbar navbar-default navbar-static-top">
			<div class="container-fluid">
				<ul class="nav navbar-nav">
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" role="button">
							员工管理<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="${pageContext.request.contextPath}/mc/userList" target="mc-content">员工列表</a></li>
							<li><a href="${pageContext.request.contextPath}/mc/userGroupList" target="mc-content">员工组</a></li>
							<li><a href="${pageContext.request.contextPath}/mc/roleList" target="mc-content">角色列表</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>
		<div class="container">
			<iframe src="${pageContext.request.contextPath}/mc/userList" width="100%" height="100%" id="mc-content" name="mc-content" onload="iFrameHeight()" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
		</div>
		
		<script type="text/javascript">
			function iFrameHeight(){
				var ifm= document.getElementById("mc-content");
				var subWeb = document.frames ? document.frames["mc-content"].document : ifm.contentDocument;
				if(ifm != null && subWeb != null) {
				   ifm.height = subWeb.body.scrollHeight;
				   ifm.width = subWeb.body.scrollWidth;
				}
			}
		</script>
	</body>
</html>