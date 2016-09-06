<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ncit.weixin.filter.SecurityContext" %>
<%@ page import="com.ncit.weixin.constanst.Constants" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ncit.weixin.model.PermissionModel" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	List<Map<String,String>> userlist = (List<Map<String,String>>)request.getAttribute("userlist");
	String basePath = request.getServletContext().getContextPath();
	request.setAttribute("userlist", userlist);
	
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
		
	    $('#usertalbe').DataTable({
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
	function improtTelephoneList(){
		$("#importTelephoneFile").click();
	}
	function improtTelephoneSubmit(){    
		$('#loading-mask').removeClass("display_none");
		$('#loading').removeClass("display_none");
	    $("#importTelephongForm").ajaxSubmit({ 
	      type: "POST",
	      url:_contextPath + "/telephone/importTelephone",
	      complete: function (data) {  
	    	  console.log(data);
	    	  if(data.status==200){
	    		  var json = data.responseJSON;
	    		 var status = json.checkStatus;
	    		  if (status == "NG") {
	    			  alert("报错");
	    			  $('#loading-mask').addClass("display_none");
	    			  $('#loading').addClass("display_none");
                  }else{
                	    alert("操作成功  ");
                	    $('#loading-mask').addClass("display_none");
  	    			    $('#loading').addClass("display_none");
                	    location.reload();
                  }	    
	          }else{
	              alert("操作失败 ");
	          }        
	     } 
	  }); 
	 }
	var groupid = null;
	function showAllocationNext(index){
		groupid = index;
		$.ajax({
			type: "POST",
			url : _contextPath + "/telephone/countOfNoGroup",
			data : '',
			success:function(data){
				$('#allocation_num').text(data);
				$('#allocation').modal('hide');
				$('#allocation_next').modal('show');
			},
			error:function(data){
				alert("请求错误");
			}
		});
		
	}
	function allocationSave(){
		$('#allocation_next').modal('hide');
		$('#allocation').modal('show');
	}
	function allocationClose(){
		$('#allocation_next').modal('hide');
		$('#allocation').modal('show');
	}
	
	function createUser(){
		$.ajax({
			type: "POST",
			url : _contextPath + "/telephone/createUser",
			data : '',
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
	<div class="text-right">
		<button class="btn btn-info btn-rounded btn-lg" onclick="createUser()">创建用户 </button>
		 <button class="btn btn-info btn-rounded btn-lg" data-toggle="modal" data-target="#allocation">按组分配 </button>
	
		 <button id="importTelephoneBtnId" href="javascript:void(0)"  onclick="improtTelephoneList()"  class="btn btn-danger btn-rounded btn-lg"><i class="fa fa-export"></i>导入电话</button>
	</div>
	<form id="importTelephongForm"   method="POST" enctype="multipart/form-data" >
     	<input type="file" onchange="improtTelephoneSubmit()"   id="importTelephoneFile" style="display:none" name="TelephoneList">
    </form>
    
    
    <div class="margin_top20">
    	<table id="usertalbe" class="table table-striped table-bordered dataTable no-footer">
    		<thead>
    			<tr>
    				<th>用户名</th>
    				<th>电话号码</th>
    				<th>所属角色</th>
    				<th>所属分组</th>
    				<th>创建时间</th>
    			</tr>
    		</thead>
    		<tbody>
    			<c:forEach var="user" items="${userlist}">
    				<tr>
	    				<td>${user.user_id}</td>
	    				<td>${user.tel}</td>
	    				<td>${user.description}</td>
	    				<td>${user.description}</td>
	    				<td>${user.create_time}</td>
	    			</tr>
				</c:forEach>
    		</tbody>
    	</table>
    
    </div>
    
    
    <div class="modal fade" id="allocation" tabindex="-1" role="dialog" aria-labelledby="importModal">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">分配号码</h4>
	      </div>
	      <div class="modal-body">
	        <table class="table">
	        	<thead>
	        		<tr>
		        		<th class="text-center">组名</th>
		        		<th class="text-center">人数</th>
		        		<th class="text-center">操作</th>
	        		</tr>
	        	</thead>
	        	<tbody>
	        		<tr>
	        			<td class="text-center">A组</td>
	        			<td class="text-center">20</td>
	        			<td class="text-center">
	        				<button class="btn btn-primary" onclick="showAllocationNext(1)">分配</button>
	        			</td>
	        		</tr>
	        	</tbody>
	        	
	        </table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
	<div class="modal fade" id="allocation_next" tabindex="-1" role="dialog" aria-labelledby="allocation_next">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">分配号码</h4>
	      </div>
	      <div class="modal-body">
	        <div>可分配号码：<span id="allocation_num"></span>条</div>
	        <div class="form-group">
		    <input type="number" class="form-control" id="allocationnum" placeholder="请输入分配数量">
		  </div>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary" onclick="allocationSave()">保存</button>
	        <button type="button" class="btn btn-default" onclick="allocationClose()">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
    

</body>
</html>