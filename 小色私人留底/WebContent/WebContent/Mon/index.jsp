<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
	 .div1 
        {
          float:left;  width:100%; height:100px;
        }
       .margin_top20
        {
          float:left; width:60%; height:90px;
        }
    	.container
        {
            position:absolute;
            left:280px;
            top:40px;
        }
</style>
<script type="text/javascript">
	    var _contextPath = '<%=request.getContextPath()%>';
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-2.0.3.min.js"></script>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/js/Chart.min.js"></script>
	<script type="text/javascript">
			var path = "${pageContext.request.contextPath}/cangent/userGroupList";
		</script>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:_contextPath+"/cangent/userGroupList",
		type:"POST",
		success:function(data){
			$("#ss").html(data);
		}
	});
});
</script>
<script type="text/javascript">
function sele(){
	   //var path = "${pageContext.request.contextPath}/cangent/select1";
	   var parm= $("#jin").val();
	   
	$("#ss").html(" ");
	$.ajax({
		url:_contextPath+"/cangent/select1",
		type:"POST",
		data:{"parm":parm},
		success:function(data){
			$("#ss").html(data);
		}
	});
}
</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>坐席监控</h1>
<div>
		<input type="button" value="刷新"
			onclick="javascript:window.location.reload()">
	</div>
技能组:	<select  onchange="sele()" id="jin">
<option value=" ">所有</option>
<c:forEach items="${lis}" var="lis">
 <option value="${lis.ICDID1}">${lis.SVCNAME }</option>
 </c:forEach>
</select>
<div class="div1">
<div id="ss"></div>
	         <div class="container"  >		
	                    
						<div class="panel-body text-center">
						<canvas id="pieChatId" width="250" height="250" ></canvas>
							<br>
							<button  style="background-color:#FFE4B5;"  ><label>等待</label></button>&nbsp;
							<button  style="background-color:#87CEFA;"><label>通话</label></button>&nbsp;
							<button  style="background-color: #54FF9F;"><label>话后</label></button>&nbsp;
							<button  style="background-color: #CD2990;"><label>休息</label></button>&nbsp;
							<button  style="background-color: #D3D3D3;"><label>振铃</label></button>&nbsp;
							<button  style="background-color: #8B6914;"><label>其他</label></button>&nbsp;
						<div  width="100px"  align="center">通道数量</div>
					</div>
					</div>
					</div>
		<script type="text/javascript">
			/*通道饼图*/
		 	var pieChat = $("#pieChatId").get(0).getContext("2d");
			$.ajax({
				url : _contextPath+"/cangent/customerCount",
				type:"POST",
				dataType : "json",
				success : function(data){
					console.log(data);
					new Chart(pieChat).Pie(data.pie);
					
				},
				error : function(){
					alert("服务器请求错误");
				}
			}); 
		</script>
</body>
</html>