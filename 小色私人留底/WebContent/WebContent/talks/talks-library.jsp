<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realPath = request.getServletContext().getContextPath();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>话术库</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.4/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.4/themes/icon.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.4/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript">
			var rootPath = "<%=realPath%>";
		</script>
	</head>
	<body>
		<div id="tabsTT" class="easyui-tabs" style="width:100%;height:550px;">
			<div title="话术库" style="padding:5px;">
				<div class="easyui-layout" style="width:100%;height:100%;">
					<div data-options="region:'west'" title="话术分类" style="width:20%;">
						<div class="easyui-panel" title=" " data-options="tools:'#typeTT'" style="width:100%;height:100%;">
							<a href="javascript:queryAllProblems();" class="easyui-linkbutton" style="width:100%;">全部问题</a>
							<ul id="protypeId" class="easyui-tree"></ul>
						</div>
						<div id="protypeMenuId" class="easyui-menu" style="width:120px;">
							<div id="protypeadd" onclick="addProType()" data-options="iconCls:'icon-add'">添加</div>
							<div onclick="editProType()" data-options="iconCls:'icon-edit'">编辑</div>
							<div onclick="deleteProType()" data-options="iconCls:'icon-remove'">删除</div>
						</div>
						<div id="typeTT">
							<a href="javascript:addParentProType();" class="icon-add"></a>
						</div>
					</div>
					<div data-options="region:'center'" title="话术列表">
						<table id="protypeData"></table>
						<div id="protypetools" style="padding:5px;height:auto">
							<div style="margin-bottom:5px">
								<a href="javascript:addProblem();" class="easyui-linkbutton" iconCls="icon-add" plain="true">新建问题</a>
								<a href="javascript:editProblem();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑问题</a>
								<a href="javascript:deleteProblem();" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除问题</a>
							</div>
							<div>
								有效性：
								<select name="effectiveTime" class="easyui-combobox" panelHeight="auto">
									<option value="">全部</option>
									<option value="1">当前有效</option>
									<option value="2">当前无效</option>
								</select>
								<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search">搜索话术</a>
							</div>
						</div>
					</div>
					<div id="problemWindow" class="easyui-window" data-options="modal:true,closed:true">
						<div style="padding:10px 60px 20px 60px">
							<form id="problemForm">
								<input type="hidden" id="problemIds" name="ids" />
								<table>
									<tr>
						    			<td>话术名称:</td>
						    			<td><input class="easyui-textbox" type="text" id="problemName" name="name" data-options="required:true"></input></td>
						    		</tr>
						    		<tr>
						    			<td>相似问法:</td>
						    			<td><input class="easyui-textbox" type="text" id="problemSimilarAsk" name="similarAsk" data-options="required:true"></input></td>
						    		</tr>
						    		<tr>
						    			<td>类别:</td>
						    			<td>
											<select id="problemTypeIds" class="easyui-combotree" name="problemTypeIds" 
												data-options="required:true" panelHeight="auto" style="width:150px;">
											</select>
										</td>
						    		</tr>
						    		<tr>
						    			<td>答案:</td>
						    			<td>
											<input class="easyui-textbox" id="problemAnswer" name="answer" data-options="multiline:true" style="height:60px"></input>
										</td>
						    		</tr>
						    		<!-- <tr>
						    			<td>问题有效期:</td>
						    			<td>
						    				<input class="easyui-textbox" type="text" name="effectiveTime" data-options="required:true"></input>
										</td>
						    		</tr> -->
								</table>
							</form>
							<div style="text-align:center;padding:5px">
						    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitProblem()">提交</a>
						    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeProblem()">关闭</a>
						    </div>
						</div>
					</div>
				</div>
				<div id="protypeWindow" class="easyui-window" title="话术分类编辑" data-options="modal:true,closed:true">
					<div style="padding:10px 60px 20px 60px">
						<form id="protypeForm" class="easyui-form">
							<input type="hidden" name="parentids" id="parentIds" />
							<input type="hidden" name="protypeids" id="protypeids" />
							<table>
								<tr>
					    			<td>分类名称:</td>
					    			<td><input id="protypeName" class="easyui-textbox" type="text" name="name" data-options="required:true" maxlength="50"></input></td>
					    		</tr>
							</table>
						</form>
						<br/>
						<div style="text-align:center">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitProTypeForm()">提交</a>
		    				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeProType()">关闭</a>
						</div>
					</div>
				</div>
			</div>
			<div title="常用语" style="padding:5px;">
				<table id="oftenUseLanPg" class="easyui-treegrid"></table>
				<div id="oftenUseLanTools">
					<a href="javascript:addOftenUseLanType()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建常用语类别</a>
				</div>
				<div id="oftenUseLanMenu" class="easyui-menu" style="width:120px;">
					<div id="oftenUseLanAddId" onclick="addOftenUseLan()" data-options="iconCls:'icon-add'">添加</div>
					<div onclick="editOftenUseLan()" data-options="iconCls:'icon-edit'">编辑</div>
					<div onclick="deleteOftenUseLan()" data-options="iconCls:'icon-remove'">删除</div>
				</div>
				<div id="oftenUseLanWindow" class="easyui-window" data-options="modal:true,closed:true">
					<div style="padding:10px 60px 20px 60px">
						<form id="oftenUseLanForm" class="easyui-form">
							<input type="hidden" name="ids" id="oftenUseLanIds" />
							<input type="hidden" name="parentIds" id="oftenUseLanParentIds" />
							<table>
								<tr>
					    			<td>常用语类别:</td>
					    			<td><input id="oftenUseLanName" class="easyui-textbox" type="text" name="name" data-options="required:true" maxlength="100"></input></td>
					    		</tr>
							</table>
						</form>
						<br/>
						<div style="text-align:center">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitOftenUseLanForm()">提交</a>
		    				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeOftenUseLan()">关闭</a>
						</div>
					</div>
				</div>
			</div>
			<div title="常用链接" style="padding:5px;">
				<table id="oftenUseLinkPg" class="easyui-treegrid"></table>
				<div id="oftenUseLinkTools">
					<a href="javascript:addOftenUseLinkType()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">新建链接类别</a>
				</div>
				<div id="oftenUseLinkMenu" class="easyui-menu" style="width:120px;">
					<div id="oftenUseLinkAddId" onclick="addOftenUseLink()" data-options="iconCls:'icon-add'">添加</div>
					<div onclick="editOftenUseLink()" data-options="iconCls:'icon-edit'">编辑</div>
					<div onclick="deleteOftenUseLink()" data-options="iconCls:'icon-remove'">删除</div>
				</div>
				
				<div id="oftenUseLinkWindow" class="easyui-window" data-options="modal:true,closed:true">
					<div style="padding:10px 60px 20px 60px">
						<form id="oftenUseLinkForm" class="easyui-form">
							<input type="hidden" name="ids" id="oftenUseLinkIds" />
							<input type="hidden" name="parentIds" id="oftenUseLinkParentIds" />
							<table>
								<tr>
					    			<td>名称:</td>
					    			<td><input id="oftenUseLinkName" class="easyui-textbox" type="text" name="name" data-options="required:true" maxlength="100"></input></td>
					    		</tr>
					    		<tr>
					    			<td>链接:</td>
					    			<td><input id="oftenUseLinkAddress" class="easyui-textbox" type="text" name="linkaddress" data-options="required:true" maxlength="300"></input></td>
					    		</tr>
							</table>
						</form>
						<br/>
						<div style="text-align:center">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitOftenUseLinkForm()">提交</a>
		    				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeOftenUseLink()">关闭</a>
						</div>
					</div>
				</div>
			</div>
			<div title="附件库" style="padding:5px;">
				<div class="easyui-layout" style="width:100%;height:100%;">
					<div data-options="region:'west'" title="附件分类" style="width:20%;">
						<a href="javascript:addAttachmentType();" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="width:100%;">新建分类</a>
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100%;">全部附件</a>
						<ul id="attachmentTypeTree" class="easyui-tree"></ul>
						<div id="attachmentTypeMenu" class="easyui-menu" style="width:120px;">
							<div id="attachmentTypeAdd" onclick="addAttachmentType()" data-options="iconCls:'icon-add'">添加</div>
							<div onclick="editAttachmentType()" data-options="iconCls:'icon-edit'">编辑</div>
							<div onclick="deleteAttachmentType()" data-options="iconCls:'icon-remove'">删除</div>
						</div>
						<div id="attachmentTypeWindow" class="easyui-window" data-options="modal:true,closed:true">
							<div style="padding:10px 60px 20px 60px">
								<form id="attachmentTypeForm">
									<input type="hidden" id="attachmentTypeIds" name="ids" />
									<input type="hidden" id="attachmentTypeParentIds" name="parentIds" />
									<table>
										<tr>
							    			<td>名称:</td>
							    			<td><input class="easyui-textbox" type="text" id="attachmentTypeName" name="name" data-options="required:true" maxlength="100"></input></td>
							    		</tr>
									</table>
								</form>
								<div style="text-align:center;padding:5px">
							    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAttachmentType()">提交</a>
							    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeAttachmentType()">关闭</a>
							    </div>
							</div>
						</div>
					</div>
					<div data-options="region:'center'" title="附件列表">
						<table id="attachmentTable"></table>
						<div id="attachmentTools" style="padding:5px;height:auto">
							<div style="margin-bottom:5px">
								<input type="file" id="file1" name="file" style="display:none;" onchange="addAttachment()" />
								<input type="file" id="file2" name="file" style="display:none;" onchange="editAttachment()" />
								<input type="hidden" name="ids" id="attachmentIds" />
								<a href="javascript:document.getElementById('file1').click();" class="easyui-linkbutton" iconCls="icon-add" plain="true">上传附件</a>
								<a href="javascript:document.getElementById('file2').click();" class="easyui-linkbutton" iconCls="icon-edit" plain="true">重新上传</a>
								<a href="javascript:deleteAttachment()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
							</div>
							<div>
								<input class="easyui-textbox" type="text" name="name" id="queryAttachmentName"></input>
								<a href="javascript:queryAttachment();" class="easyui-linkbutton" iconCls="icon-search">搜索附件</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/talks/talks.js"></script>
	</body>
</html>