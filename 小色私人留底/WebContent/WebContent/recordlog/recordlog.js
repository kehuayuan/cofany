$(function(){
	
	$("#startTime").datebox({editable:false});
	$("#endTime").datebox({editable:false});
	
	$("#dg").datagrid({
		url : rootPath+"/recordlog/list",
		rownumbers: true,
		animate: true,
		pagination : true,
		singleSelect: true,
		idField: 'ids',
		method : "post",
		toolbar : "#tools",
		columns : [[
		    {field:'CustomerID',title:'坐席工号',width:60,align:"center"},        
		    {field:'AGENTNAME',title:'坐席名称',width:80,align:"center"},
		    {field:'CallerNum',title:'主叫号码',width:60,align:"center"},
		    {field:'CalleeNum',title:'被叫号码',width:60,align:"center"},
		    {field:'StartTime',title:'录音开始时间',width:120,align:"center"},
		    {field:'F_Path',title:'录音文件',width:50,align:"center"},
		    {field:'TimeLength',title:'录音时长',width:70,align:"center"},
		    {field:'Flag',title:'状态',width:50,align:"center",formatter:function(value,rowData,rowIndex){
		    	if(value==0){
		    		return "未听";
		    	}else if(value==1){
		    		return "已听";
		    	}else if(value==2){
		    		return "错误";
		    	}
		    }},
		    {field:'note',title:'备注',width:50,align:"center"},
		    {field:'play', title:'播放录音',width:50,align:"center",formatter:function(value,rowData,rowIndex){
		    	var filePath = encodeURI(rowData.filePath);
		    	return '<a href="javascript:void(0);" onclick="playAudio(\''+filePath+'\')">点击播放</a>&nbsp;<a href="javascript:void(0);" onclick="stopAudio()">暂停</a>';
		    }}
		]],
		onLoadSuccess : function(data){
			
		},
		onLoadError : function(){
			alert("数据加载失败!");
		}
	});
	
});

/*点击播放录音文件*/
function playAudio(filePath){
	
	/*var audio5 = new Audio5js({
		codecs: ['wav'],
			ready: function (o) {
			this.load(decodeURI(filePath));
		}
	});
	audio5.play();*/
	
	$.ajax({
		async : false,
		url : rootPath + "/recordlog/changeToMp3",
		data : {filePath:decodeURI(filePath)},
		type : "post",
		dataType : "text",
		success : function(data){
			var obj = document.getElementById("audio_file");
			obj.src = rootPath+data;
			obj.play();
		},
		error : function(){
			
		}
	});
	
	
	/*$.ajax({
		async : false,
		url : rootPath+"/recordlog/loadWavFile",
		data : {recordPath : filePath},
		type : "post",
		dataType : "text",
		success : function(data){
			var obj = document.getElementById("audio_file");
			obj.src = data;
			obj.play();
		},
		error : function(){
			alert("服务器错误!!");
		}
	});*/
}

/*暂停播放录音*/
function stopAudio(){
	var obj = document.getElementById("audio_file");
	obj.pause();
}

/**
 * 按条件检索
 */
function query(){
	var startTime = $.trim($("#startTime").datebox("getValue"));
	var endTime = $.trim($("#endTime").datebox("getValue"));
	var callerNum = $.trim($("#callerNum").textbox("getValue"));
	var calleeNum = $.trim($("#calleeNum").textbox("getValue"));
	var fPath = $.trim($("#fPath").textbox("getValue"));
	var svccode = $.trim($("#svccode").textbox("getValue"));
	$("#dg").datagrid("load",{startTime:startTime,endTime:endTime,callerNum:callerNum,calleeNum:calleeNum,fPath:fPath,svccode:svccode});
}