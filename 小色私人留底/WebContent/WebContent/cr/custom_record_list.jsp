<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.ncit.weixin.controller.PagingInfo"%>
<%@ page import="java.net.URLEncoder"%>
<div>

	
		<table class="table table-hover table-select">
			<thead>
				<tr>
					<th>手机</th>
					<th>时间</th>
					<th>信息</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${po.list}" var="o">
					<tr id="${o.crId}">
						<td><a href="<%=request.getContextPath() %>/ci/custom_info_edit.jsp?tel=${o.tel}&callback=<%=URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString())%>">${o.tel}</a></td>
						<td>${o.createTime}</td>
						<td>${o.msg}</td>
						<td><a
							href="custom_record_edit.jsp?callback=${editCallbackUrl}&id=${o.crId}">修改</a>,<a
							href="#" class="cr_del">删除</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<ul class="pagination">
			<%
				Object pi = new PagingInfo((String) request.getAttribute("pageUrl"),
							(com.jfinal.plugin.activerecord.Page) request.getAttribute("po"));
					request.setAttribute("pi", pi);
			%>
			<c:forEach items="${pi.list}" var="o">
				<li class="${o.cssClass }"><a href="${o.href }">${o.num}</a></li>
			</c:forEach>
		</ul>


</div>