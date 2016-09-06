<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<nav>
		<ul class="pager">
			<c:choose>
				<c:when test="${pager.pageNumber==1}">
					<li class="disabled"><a href="javascript:void(0);">首页</a></li>
					<li class="disabled"><a href="javascript:void(0)">上一页</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="javascript:firstPage();">首页</a></li>
					<li><a href="javascript:prePage('${pager.pageNumber-1}')">上一页</a></li>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pager.pageNumber==pager.totalPage || pager.totalPage==0}">
					<li class="disabled"><a href="javascript:void(0);">下一页</a></li>
					<li class="disabled"><a href="javascript:void(0);">尾页</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="javascript:nextPage('${pager.pageNumber+1}');">下一页</a></li>
					<li><a href="javascript:lastPage('${pager.totalPage}');">尾页</a></li>
				</c:otherwise>
			</c:choose>
			<li>
				当前第${pager.pageNumber} / ${pager.totalPage}页，共${pager.totalRow}条记录
			</li>
		</ul>
	</nav>
</div>
<script type="text/javascript">
	function firstPage(){
		window.location.href = path+"?pageNumber=1";
	}
	function prePage(pageNumber){
		window.location.href = path+"?pageNumber="+pageNumber;
	}
	function nextPage(pageNumber){
		window.location.href = path+"?pageNumber="+pageNumber;
	}
	function lastPage(pageNumber){
		window.location.href = path+"?pageNumber="+pageNumber;
	}
</script>