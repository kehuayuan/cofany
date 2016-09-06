<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ncit.weixin.model.CustomInfoModel"%>
<%@ page import="com.ncit.weixin.model.UserModel"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String ci_id = request.getParameter("ci_id");
	String tel = request.getParameter("tel");
	if (ci_id != null) {
		CustomInfoModel cim = CustomInfoModel.dao.findById(ci_id);
		request.setAttribute("cim", cim);
		request.setAttribute("tel", cim.getTel());
	} else {
		request.setAttribute("tel", tel);
		//CustomInfoModel cim = CustomInfoModel.dao.findById(tel);
		CustomInfoModel cim = CustomInfoModel.dao.findByTel(tel);
		request.setAttribute("cim", cim);
	}
%>
<div>
	<div class="container">
		<h4>客户信息${tel}</h4>
	</div>

	<div class="container">
		<form id="cr_edit_form" role="form"
			action="<%=request.getContextPath()%>/ci/doInsert">
			<div class="row">
				<div class="col-lg-4">
					<div class="input-group">
						<span class="input-group-addon">姓名</span> <input type="text"
							name="ci_name" value="${cim.name}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
					<div class="input-group">
						<span class="input-group-addon">手机1</span> <input type="text"
							name="ci_phone1" value="${tel}" class="form-control"
							placeholder="请输入信息">
						</textarea>
					</div>
					<div class="input-group">
						<span class="input-group-addon">家庭电话</span> <input type="text"
							name="ci_home_tel" value="${cim.homeTel}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
					<div class="input-group">
						<span class="input-group-addon">Email</span> <input type="text"
							name="ci_email" value="${cim.email}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="input-group">
						<span class="input-group-addon">客户性别</span>
						<%-- <input type="text"
							name="ci_sex" value="${cim.sex}" class="form-control"
							placeholder="请输入信息"> </input> --%>
						<select class="form-control" name="ci_sex" value="${cim.sex}">
							<option value="1">男</option>
							<option value="2">女</option>
						</select>
					</div>
					<div class="input-group">
						<span class="input-group-addon">电话2</span> <input type="text"
							name="ci_tel2" value="${cim.tel2}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
					<div class="input-group">
						<span class="input-group-addon">其他电话</span> <input type="text"
							name="ci_other_tel" value="${cim.otherTel}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
					<div class="input-group">
						<span class="input-group-addon">客户归属</span> <select type="text"
							name="ci_owner_id" value="${cim.ownerId}" class="form-control"
							placeholder="请输入信息">
							<%
								Object users = UserModel.dao.find("select user_id,user_caption from FY_B_USER");
							request.setAttribute("users", users);
							%>
							<c:forEach items="${users}" var="u">
								<option value="${ u.id}">${u.caption}</option>
							</c:forEach>
							</select>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="input-group">
						<span class="input-group-addon">电话1</span> <input type="text"
							name="ci_sex" value="${cim.sex}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
					<div class="input-group">
						<span class="input-group-addon">手机2</span> <input type="text"
							name="ci_phone2" value="${cim.phone2}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
					<div class="input-group">
						<span class="input-group-addon">传真</span> <input type="text"
							name="ci_tax" value="${cim.tax}" class="form-control"
							placeholder="请输入信息"> </input>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-10">
					<div class="input-group">
						<span class="input-group-addon">备注</span> <textarea type="text"
							name="ci_mark" value="" class="form-control"
							placeholder="请输入信息">${cim.mark}</textarea>
					</div>
					</div>
			</div>

			<input type="hidden" name="ci_tel" value="${tel}"></input> <input
				type="hidden" name="id" value="${cim.id}"></input> <input
				type="hidden" name="callback"
				value="<%=request.getParameter("callback") == null ? "" : request.getParameter("callback")%>"></input>
			<br />
			<button type="submit" class="btn btn-success">保存</button>

		</form>
		<script type="text/javascript">
			$('#cr_edit_form').find('select').each(function(i, d) {
				var d = $(d);
				var v = d.attr('value');
				if (v) {
					d.find('option[value=' + v + ']').attr('selected', 'true');
				}
			});
		</script>
	</div>
</div>