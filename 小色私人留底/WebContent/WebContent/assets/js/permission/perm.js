//定义标题栏
var columns = [[{
	field : 'user_id',
	title : '用户名',
	width : 80,
	align : 'center'
} , {
	field : 'tel',
	title : '电话',
	width : 150,
	align : 'center'
} , {
	field : 'sex',
	title : '性别',
	width : 80,
	align : 'center',
	formatter : function(value, rowData, rowIndex){
		if(value==0){
			return "男";
		}else if(value==1){
			return "女";
		}
	}
} , {
	field : 'role_name',
	title : '所属角色',
	width : 200,
	align : 'center'
}, {
	field : 'create_time',
	title : '创建时间',
	width : 200,
	align : 'center'
} , {
	field : 'oper',
	title : '操作',
	width : 150,
	align : 'center',
	formatter : function(value, rowData, rowIndex){
		return "<a href='javascript:void(0)' onclick='openRoleWin(\""+rowData.user_id+"\")'>分配角色</a>";
	}
}]];

$(function(){
	$.messager.defaults={ok:"确定",cancel:"取消"};
	$("#dg").datagrid({
		height : 350,
		width : 980,
		url : basePath+"/permission/listUser",
		idField : 'user_id',
		rownumbers : true,
		pagination : true,
        pageSize : 10,
        singleSelect : true,
		columns : columns
	});
});

var rolecolumns = [[{
	field : 'role_name',
	title : '名称',
	width : 100,
	align : 'center'
} , {
	field : 'description',
	title : '描述',
	width : 500,
	align : 'center'
}
]];

/*设置用户的角色*/
function openRoleWin(userId){
	$("#userid").val(userId);
	/*设置窗口*/
	$("#roleWin").window({
		title : "设置角色",
		width : 660,
		height : 300,
		minimizable : false,
		maximizable : false,
		collapsible : false,
		modal : true
	}).window("center").window("open");
	/*加载角色列表*/
	$("#rolelist").combogrid({
		panelWidth:230,
		idField:'ids',
		textField:'role_name',
		url:basePath+'/permission/listRole',
		editable:false,
		columns:[[
		   {field:'role_name',title:'名称',width:100},
		   {field:'description',title:'描述',width:120}
		]]
	});
}

function setRole(){
	var roleVal = $("#rolelist").combogrid("getValue");
	if($.trim(roleVal)!=""){
		$.ajax({
			cache: false,
			type: "post",
			url: basePath+"/permission/distributionRole",
			data: $("#setRoleForm").serialize(),
			async: true,
			error: function(request){
				
			},
			success: function(data){
				if(data){
					$("#roleWin").window("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}else{
		alert("请选择角色！");
	}
}