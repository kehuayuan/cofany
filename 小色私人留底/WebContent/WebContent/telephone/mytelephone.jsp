<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ncit.weixin.filter.SecurityContext" %>
<%@ page import="com.ncit.weixin.constanst.Constants" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ncit.weixin.model.PermissionModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	List<Map<String,String>> mobileList = (List<Map<String,String>>)request.getAttribute("mobilelist");
	String basePath = request.getServletContext().getContextPath();
	request.setAttribute("mobilelist", mobileList);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../Datatable/css/dataTables.bootstrap.css">
<script type="text/javascript" src="../js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.form.js"></script>
 <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../Datatable/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../Datatable/js/dataTables.bootstrap.js"></script>
<!-- 

<link rel="stylesheet" href="../Datatable/css/jquery.dataTables.min.css">
 -->


<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript">
	
	//导入电话号码
	var _contextPath = '<%=request.getContextPath()%>';
	$(document).ready( function () {
		
	    $('#moblietalbe').DataTable({
	    	"language": {
	    	      "emptyTable": "当前没有数据",
	    	      "info": "当前显示  _PAGE_ of _PAGES_",
	    	      "lengthMenu": "每页显示 _MENU_ 记录",
	    	      "paginate": {
	    	          "previous": "上一页",
	    	          "next": "下一页"
	    	        },
	    		  "zeroRecords": "没有查询到数据",
	    		  "search": "搜索："
	    	    }
	    });
	} );


	
	function updateTelephoneStatus(id){
		$.ajax({
			type: "POST",
			url : _contextPath + "/telephone/updateTelephoneStatus",
			data : 'id='+ id,
			success:function(data){
				document.location.reload();
			},
			error:function(data){
				document.location.reload();
			}
		});
	}
	
	
	

</script>
</head>
<body id="telbody">
	<div id='loading-mask' class="display_none"></div>
	<div id="loading" class="display_none">加载中...</div>
    <div class="margin_top20">
    	<table id="moblietalbe" class="table table-striped table-bordered dataTable no-footer">
    		<thead>
    			<tr>
    				<th>电话号码</th>
    				<th>所属分组</th>
    				<th>操作</th>
    			</tr>
    		</thead>
    		<tbody>
    			<c:forEach var="mobile" items="${mobilelist}">
    				<tr>
	    				<td>${mobile.telephone}</td>
	    				<td>${mobile.group}</td>
	    				<td>
	    					<button class="btn btn-info" onclick="updateTelephoneStatus('${mobile.ids}')">已拨打</button>
	    				</td>
	    			</tr>
				</c:forEach>
    		</tbody>
    	</table>
    </div>

</body>
</html>