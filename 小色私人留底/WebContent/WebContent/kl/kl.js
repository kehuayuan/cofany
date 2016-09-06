$(function(){
	
	$("#tabsTT").tabs({
		tabPosition:"left",
		onSelect : function(title){
			if(title=="常用语"){
				$("#oftenUseLanPg").treegrid({
					url : rootPath+"/knowledge/loadOftenUseLanguageData",
					rownumbers: true,
					animate: true,
					pagination : true,
					idField: 'id',
					treeField: 'name',
					onContextMenu : function(e,row){
						e.preventDefault();
						$(this).treegrid('select', row.id);
						if(row._parentId){
							$("#oftenUseLanAddId").hide();
						}else{
							$("#oftenUseLanAddId").show();
						}
						$('#oftenUseLanMenu').menu('show',{
							left: e.pageX,
							top: e.pageY
						});
					},
					columns : [[
					     {field:"name",title:"常用语",width:400}
					]],
					toolbar : "#oftenUseLanTools"
				});
			}else if(title=="常用链接"){
				$("#oftenUseLinkPg").treegrid({
					url : rootPath+"/knowledge/loadOftenUseLinkData",
					rownumbers: true,
					animate: true,
					pagination : true,
					idField: 'id',
					treeField: 'name',
					onContextMenu : function(e,row){
						e.preventDefault();
						$(this).treegrid('select', row.id);
						if(row._parentId){
							$("#oftenUseLinkAddId").hide();
						}else{
							$("#oftenUseLinkAddId").show();
						}
						$('#oftenUseLinkMenu').menu('show',{
							left: e.pageX,
							top: e.pageY
						});
					},
					columns : [[
					     {field:"name",title:"名称",width:200},
					     {field:"linkaddress",title:"链接",width:400}
					]],
					toolbar : "#oftenUseLinkTools"
				});
			}else if(title=="附件库"){
				
				$("#attachmentTable").datagrid({
					url : rootPath+"/knowledge/loadAttachmentData",
					rownumbers: true,
					animate: true,
					pagination : true,
					singleSelect: true,
					idField: 'ids',
					method : "post",
					toolbar : "#attachmentTools",
					columns : [[
					    {field:'name',title:'文件',width:350,align:"center",formatter:function(value,rowData,rowIndex){
					    	return "<a href='"+rootPath+rowData.filePath+"'>"+value+"</a>";
					    }},
					    {field:'size',title:'大小',width:100,align:"center"},
					    {field:'update_time',title:'时间',width:200,align:"center"}
					]],
					onLoadSuccess : function(data){
						
					},
					onLoadError : function(){
						alert("数据加载失败!");
					}
				});
				
				$("#attachmentTypeTree").tree({
					url : rootPath+"/knowledge/loadAttachmentTypeData",
					method : "post",
					animate : true,
					onContextMenu : function(e, node){
						e.preventDefault();
						$(this).tree('select',node.target);
						if(node.parentids==0){
							$("#attachmentTypeAdd").show();
						}else{
							$("#attachmentTypeAdd").hide();
						}
						$('#attachmentTypeMenu').menu('show',{
							left: e.pageX,
							top: e.pageY
						});
					}
				});
			}
		}
	});
	
	/*问题分类数据*/
	$("#protypeId").tree({
		url : rootPath+"/knowledge/problemTypes",
		method: 'post',
		animate: true,
		onContextMenu: function(e,node){
			e.preventDefault();
			$(this).tree('select',node.target);
			if(node.parentids==0){
				$("#protypeadd").show();
			}else{
				$("#protypeadd").hide();
			}
			$('#protypeMenuId').menu('show',{
				left: e.pageX,
				top: e.pageY
			});
		},
		onClick : function(node){
			$("#protypeData").datagrid("load",{protypeIds:node.id});
		}
	});
	
	/*问题数据列表*/
	$("#protypeData").datagrid({
		url : rootPath+"/knowledge/problems",
		method : "post",
		rownumbers : true,
		pagination : true,
		pageSize : 10,
		singleSelect : true,
		pageList: [10, 20, 30, 40, 50],
		toolbar : '#protypetools',
		columns : [[
		    {field:'name',title:'标题',width:100,align:"left"},
		    {field:'similarAsk',title:'相似问法',width:30,align:"left"},
		    {field:'status',title:'词条状态',width:60,align:"left",formatter:function(value,rowData,rowIndex){
		    	if(value==1){
		    		return "已发布";
		    	}
		    }},
		    {field:'updateTime',title:'最后编辑时间',width:120,align:"left"},
		    {field:'effectiveTime',title:'问题时效',width:70,align:"left"},
		    {field:'answer',title:'答案',width:100,align:"left",formatter:function(value,rowData,rowIndex){
		    	var abValue = value;
		    	if (value.length>=6) {
                    abValue = value.substring(0,6) + "...";
                }
		    	var content = '<a title="' + value + '" class="note">' + abValue + '</a>';
		    	return content;
		    }}
		]],
		onLoadSuccess : function(data){
			if(data.total>0){
				$(".note").tooltip({
					position : 'left',
					onShow : function(){
						$(this).tooltip('tip').css({
							width:'300',
							boxShadow: '1px 1px 3px #292929'
						});
					}
				});
			}
		},
		onLoadError : function(){
			alert("数据加载失败!");
		}
	});
});

/*编辑问题库数据*/
function editProblem(){
	var obj = $("#protypeData").datagrid("getSelected");
	if(obj){
		$("#problemWindow").window({
			title : "编辑问题",
			collapsible: false,
			minimizable: false,
			maximizable: false,
			closable: false
		}).window("open");
		$("#problemTypeIds").combotree({
			url:rootPath+'/knowledge/problemTypes',
			valueField:'id',
			textField:'text'
		});
		$("#problemIds").val(obj.ids);
		$("#problemName").textbox("setValue",obj.name);
		$("#problemSimilarAsk").textbox("setValue",obj.similarAsk);
		$("#problemTypeIds").combotree("setValue",obj.problemTypeIds);
		$("#problemAnswer").textbox("setValue",obj.answer);
	}else{
		$.messager.alert('系统提示','请选择一条记录','info');
	}
}

/*删除问题库数据*/
function deleteProblem(){
	var obj = $("#protypeData").datagrid("getSelected");
	if(obj){
		$.messager.confirm('删除问题', '您确定要删除吗?', function(r){
			if (r){
				$.ajax({
					url : rootPath+"/knowledge/deleteProblem",
					type : "post",
					data : {ids:obj.ids},
					dataType : "json",
					success : function(data){
						if(data){
							$("#protypeData").datagrid("load");
						}else{
							
						}
					},
					error : function(){
						window.location.href = rootPath+"/login.html";
					}
				});
			}
		});
	}else{
		$.messager.alert('系统提示','请选择一条记录','info');
	}
}

/*查看全部问题*/
function queryAllProblems(){
	$("#protypeData").datagrid("load",{});
}

/*提交问题分类数据*/
function submitProTypeForm(){
	var validateFlag = $("#protypeForm").form('enableValidation').form('validate');
	var nameFlag = true;
	if($.trim($("#protypeName").textbox("getValue"))==""){
		nameFlag = false;
	}
	if(validateFlag && nameFlag){
		$.ajax({
			url : rootPath+"/knowledge/submitProType",
			data : $("#protypeForm").serialize(),
			type : "post",
			dataType : "json",
			success : function(data){
				if(data.flag){
					$("#protypeId").tree('append', {
						data : [{
							id : data.ids,
							text : $("#protypeName").textbox("getValue")
						}]
					});
					$("#protypeId").tree("reload");
					$("#protypeWindow").window("close");
				}else{
					alet("操作失败!");
				}
			},
			error : function(){
				window.location.href = rootPath+"/login.html";
			}
		});
	}
}

/*只添加父节点*/
function addParentProType(){
	$('#protypeForm').form('clear');
	$("#protypeWindow").window({
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
	$("#parentIds").val("");
}

/*添加问题分类*/
function addProType(){
	$('#protypeForm').form('clear');
	$("#protypeWindow").window({
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
	
	var treeObj = $("#protypeId").tree('getSelected');
	$("#parentIds").val(treeObj.id);
}

/*关闭问题分类窗口，同时清除form表单*/
function closeProType(){
	$("#protypeWindow").window("close");
}

/*编辑问题分类*/
function editProType(){
	$("#protypeWindow").window({
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
	var treeObj = $("#protypeId").tree('getSelected');
	$("#protypeids").val(treeObj.id);
	$("#protypeName").textbox("setValue",treeObj.text);
}

/*删除问题分类*/
function deleteProType(){
	var treeObj = $("#protypeId").tree('getSelected');
	$.messager.confirm('删除问题分类', '您确定要删除吗?', function(r){
		if (r){
			$.ajax({
				url : rootPath+"/knowledge/deleteProType",
				type : "post",
				data : {ids:treeObj.id},
				dataType : "json",
				success : function(data){
					if(data.flag){
						$("#protypeWindow").window("close");
						$("#protypeId").tree("reload");
					}else{
						
					}
				},
				error : function(){
					window.location.href = rootPath+"/login.html";
				}
			});
		}
	});
}

/*新建问题页面*/
function addProblem(){
	$('#problemForm').form('clear');
	$("#problemWindow").window({
		title : "新建问题",
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
	$("#problemTypeIds").combotree({
		url:rootPath+'/knowledge/problemTypes',
		valueField:'id',
		textField:'text'
	});
}

/*提交问题数据*/
function submitProblem(){
	$.ajax({
		url : rootPath+"/knowledge/submitProblem",
		data : $("#problemForm").serialize(),
		type : "post",
		dataType : "json",
		success : function(data){
			$("#problemWindow").window("close");
			$("#protypeData").datagrid("load");
		},
		error : function(){
			
		}
	});
}

/*关闭新建问题窗口*/
function closeProblem(){
	$("#problemWindow").window("close");
}

/*添加窗口*/
function addOftenUseLan(){
	$("#oftenUseLanForm").form("clear");
	
	var obj = $("#oftenUseLanPg").treegrid("getSelected");
	
	$("#oftenUseLanForm tr td").eq(0).text("常用语");
	$("#oftenUseLanIds").val(obj.id);
	
	$("#oftenUseLanWindow").window({
		title : "新建常用语",
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*编辑常用语*/
function editOftenUseLan(){
	var obj = $("#oftenUseLanPg").treegrid("getSelected");
	
	$("#oftenUseLanIds").val(obj.id);
	$("#oftenUseLanParentIds").val("0");
	$("#oftenUseLanName").textbox("setValue",obj.name);
	var titleName = "";
	if(obj._parentId){
		$("#oftenUseLanForm tr td").eq(0).text("常用语");
		titleName = "编辑常用语";
	}else{
		$("#oftenUseLanForm tr td").eq(0).text("常用语类别");
		titleName = "编辑常用语类别";
	}
	$("#oftenUseLanWindow").window({
		title : titleName,
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*添加常用语类别*/
function addOftenUseLanType(){
	$("#oftenUseLanForm").form("clear");
	$("#oftenUseLanWindow").window({
		title : "新建常用语类别",
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*提交常用语数据*/
function submitOftenUseLanForm(){
	if($.trim($("#oftenUseLanName").textbox("getValue"))!=""){
		$.ajax({
			url : rootPath+"/knowledge/sumbitOftenUseLan",
			data : $("#oftenUseLanForm").serialize(),
			type : "post",
			dataType : "json",
			success : function(data){
				if(data){
					closeOftenUseLan();
					$("#oftenUseLanPg").treegrid("load");
				}
			},
			error : function(){
				alert("服务器错误!");
			}
		});
	}
}

/*删除常用语数据*/
function deleteOftenUseLan(){
	var treeObj = $("#oftenUseLanPg").treegrid('getSelected');
	$.messager.confirm('删除常用语类别', '您确定要删除吗?', function(r){
		if (r){
			$.ajax({
				url : rootPath+"/knowledge/deleteOftenUseLan",
				type : "post",
				data : {ids:treeObj.id},
				dataType : "json",
				success : function(data){
					if(data.flag){
						$("#oftenUseLanPg").treegrid("load");
					}else{
						$.messager.alert('删除失败',data.message,'error');
					}
				},
				error : function(){
					window.location.href = rootPath+"/login.html";
				}
			});
		}
	});
}

/*关闭常用语窗口*/
function closeOftenUseLan(){
	$("#oftenUseLanWindow").window("close");
}

/*新建链接类别窗口*/
function addOftenUseLinkType(){
	$("#oftenUseLinkForm").form("clear");
	
	$("#oftenUseLinkForm table tr").eq(1).hide();
	$("#oftenUseLinkWindow").window({
		title : "新建链接类别",
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*添加常用链接窗口打开*/
function addOftenUseLink(){
	$("#oftenUseLinkForm").form("clear");
	
	var treeObj = $("#oftenUseLinkPg").treegrid("getSelected");
	
	$("#oftenUseLinkParentIds").val(treeObj.id);
	
	$("#oftenUseLinkForm table tr").eq(1).show();
	$("#oftenUseLinkWindow").window({
		title : "新建链接",
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*编辑常用链接*/
function editOftenUseLink(){
	var treeObj = $("#oftenUseLinkPg").treegrid("getSelected");
	var titleName = "";
	
	$("#oftenUseLinkName").textbox("setValue",treeObj.name);
	
	if(treeObj._parentId){
		$("#oftenUseLinkIds").val(treeObj.id);
		$("#oftenUseLinkAddress").textbox("setValue",treeObj.linkaddress);
		$("#oftenUseLinkForm table tr").eq(1).show();
		titleName = "编辑链接";
	}else{
		$("#oftenUseLinkForm table tr").eq(1).hide();
		$("#oftenUseLinkIds").val(treeObj.id);
		$("#oftenUseLinkAddress").textbox("setValue","");
		titleName = "编辑链接类别";
	}
	$("#oftenUseLinkWindow").window({
		title : titleName,
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*提交常用链接数据*/
function submitOftenUseLinkForm(){
	var name = $.trim($("#oftenUseLinkName").textbox("getValue"));
	var flag = false;
	var treeObj = $("#oftenUseLinkPg").treegrid("getSelected");
	if(treeObj!=null){
		var address = $.trim($("#oftenUseLinkAddress").textbox("getValue"));
		if(address != ""){
			flag = true;
		}
	}else{
		flag = true;
	}
	if(name != "" && flag){
		$.ajax({
			url : rootPath+"/knowledge/sumbitOftenUseLink",
			data : $("#oftenUseLinkForm").serialize(),
			type : "post",
			dataType : "json",
			success : function(data){
				if(data){
					closeOftenUseLink();
					$("#oftenUseLinkPg").treegrid("load");
				}
			},
			error : function(){
				alert("服务器错误!");
			}
		});
	}
}

/*删除常用链接数据*/
function deleteOftenUseLink(){
	var treeObj = $("#oftenUseLinkPg").treegrid('getSelected');
	$.messager.confirm('删除常用链接', '您确定要删除吗?', function(r){
		if (r){
			$.ajax({
				url : rootPath+"/knowledge/deleteOftenUseLink",
				type : "post",
				data : {ids:treeObj.id},
				dataType : "json",
				success : function(data){
					if(data.flag){
						$("#oftenUseLinkPg").treegrid("load");
					}else{
						$.messager.alert('删除失败',data.message,'error');
					}
				},
				error : function(){
					window.location.href = rootPath+"/login.html";
				}
			});
		}
	});
}

/*关闭连接操作窗口*/
function closeOftenUseLink(){
	$("#oftenUseLinkWindow").window("close");
}

/*新建附件库窗口*/
function addAttachmentType(){
	$("#attachmentTypeForm").form("clear");
	
	var treeObj = $("#attachmentTypeTree").tree("getSelected");
	if(treeObj!=null){
		$("#attachmentTypeParentIds").val(treeObj.id);
	}
	
	$("#attachmentTypeWindow").window({
		title : "新建附件分类",
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*编辑附件分类窗口*/
function editAttachmentType(){
	$("#attachmentTypeForm").form("clear");
	
	var treeObj = $("#attachmentTypeTree").tree("getSelected");
	
	$("#attachmentTypeIds").val(treeObj.id);
	$("#attachmentTypeName").textbox("setValue",treeObj.text);
	
	$("#attachmentTypeWindow").window({
		title : "编辑附件分类",
		collapsible: false,
		minimizable: false,
		maximizable: false,
		closable: false
	}).window("open");
}

/*提交附件分类数据*/
function submitAttachmentType(){
	var attachmentName = $.trim($("#attachmentTypeName").textbox("getValue"));
	if(attachmentName!=""){
		$.ajax({
			url : rootPath+"/knowledge/sumbitAttachmentType",
			data : $("#attachmentTypeForm").serialize(),
			type : "post",
			dataType : "json",
			success : function(data){
				if(data){
					closeAttachmentType();
					$("#attachmentTypeTree").tree("reload");
				}else{
					$.messager.alert('操作失败',"请刷新后再试!",'error');
				}
			},
			error : function(){
				alert("服务器错误!");
			}
		});
	}
}

/*删除附件分类数据*/
function deleteAttachmentType(){
	var treeObj = $("#attachmentTypeTree").tree('getSelected');
	$.messager.confirm('删除附件分类', '您确定要删除吗?', function(r){
		if (r){
			$.ajax({
				url : rootPath+"/knowledge/deleteAttachmentType",
				type : "post",
				data : {ids:treeObj.id},
				dataType : "json",
				success : function(data){
					if(data.flag){
						$("#attachmentTypeTree").tree("reload");
					}else{
						$.messager.alert('删除失败',data.message,'error');
					}
				},
				error : function(){
					window.location.href = rootPath+"/login.html";
				}
			});
		}
	});
}

/*关闭表单窗口*/
function closeAttachmentType(){
	$("#attachmentTypeWindow").window("close");
}

/*搜索附件*/
function queryAttachment(){
	var attachmentName = $.trim($("#queryAttachmentName").textbox("getValue"));
	$("#attachmentTable").datagrid("load",{name:attachmentName});
}

/*上传附件*/
function addAttachment(){
	$.ajaxFileUpload({
		url : rootPath+"/knowledge/uploadAttachmentFile",
		secureuri : false,
		fileElementId : "file1",
		dataType : "jsonp",
		success : function(data, status){
			if(data){
				$.messager.alert('系统提示','上传成功!','info');
				$("#attachmentTable").datagrid("load");
			}else{
				$.messager.alert('系统提示','上传失败!','error');
			}
		},
		error: function (data, status, e){
			$.messager.alert('系统提示','上传失败!','error');
		}
	});
}

/*修改附件数据*/
function editAttachment(){
	var obj = $("#attachmentTable").datagrid("getSelected");
	if(obj!=null){
		$.ajaxFileUpload({
			url : rootPath+"/knowledge/uploadAttachmentFile?ids="+obj.ids,
			secureuri : false,
			fileElementId : "file2",
			dataType : "jsonp",
			success : function(data, status){
				if(data){
					$.messager.alert('系统提示','修改成功!','info');
					$("#attachmentTable").datagrid("load");
				}else{
					$.messager.alert('系统提示','修改失败!','error');
				}
			},
			error: function (data, status, e){
				$.messager.alert('系统提示','修改失败!','error');
			}
		});
	}else{
		$.messager.alert('系统提示','请选择一条要修改的附件','info');
	}
}

/*删除附件数据*/
function deleteAttachment(){
	var obj = $("#attachmentTable").datagrid("getSelected");
	if(obj!=null){
		$.messager.confirm('删除附件', '您确定要删除吗?', function(r){
			if (r){
				$.ajax({
					url : rootPath+"/knowledge/deleteAttachment",
					type : "post",
					data : {ids:obj.ids},
					dataType : "json",
					success : function(data){
						if(data.flag){
							$("#attachmentTable").datagrid("load");
						}else{
							$.messager.alert('删除失败',data.message,'error');
						}
					},
					error : function(){
						window.location.href = rootPath+"/login.html";
					}
				});
			}
		});
	}else{
		$.messager.alert('系统提示','请选择一条要修改的附件','info');
	}
}