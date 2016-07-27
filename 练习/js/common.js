$(function(){
			
	//下拉菜单
	$(".drop-m").click(function(e) {
		if ($(this).next(".drop-main").is(":hidden")) {
		$(this).next(".drop-main").fadeIn();
			e?e.stopPropagation():event.cancelBubble = true;
		}
		$(this).parent(".drop-box").toggleClass("active");
	});
	$(".drop-main").click(function(e) {
		e?e.stopPropagation():event.cancelBubble = true;
	});
	$(document).click(function() {
		$(".drop-main").fadeOut();
		$(".drop-box").removeClass("active");
	});
	$(".drop-close").click(function() {
		$(".drop-main").fadeOut();
		$(".drop-box").removeClass("active");
	});

	
	//底部固定弹出
	$(".fixed-bottom textarea").focus(function(){
		$(this).siblings().removeClass("hide");
	});

	$(".fixed-bottom .operate .cancel").click(function(){
		$(this).parent().parent().addClass("hide");
	});
	
	//点击选择样式切换
	$(".operate .btn-group .btn,.search-rt ul li,.select-ul li").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
	});
	
	//删除上传文件
	$(".paperclip-remove").click(function(){
		$(this).parent().parent().remove();
	});
	
	
	//打分
	$(".tab-right li:first-child span").mouseover(function(){
		$(this).siblings().removeClass("glyphicon-star").addClass("glyphicon-star-empty");
		$(this).removeClass("glyphicon-star-empty").addClass("glyphicon-star");
		$(this).prevAll().removeClass("glyphicon-star-empty").addClass("glyphicon-star");	
	});
	
	//打分
	$(".star-box span").mouseover(function(){
		$(this).siblings().removeClass("glyphicon-star").addClass("glyphicon-star-empty");
		$(this).removeClass("glyphicon-star-empty").addClass("glyphicon-star");
		$(this).prevAll().removeClass("glyphicon-star-empty").addClass("glyphicon-star");	
	});
	

	$(".tab-right li:first-child span").click(function(){
		$(this).removeClass("glyphicon-star-empty").addClass("glyphicon-star");
		$(this).prevAll().removeClass("glyphicon-star-empty").addClass("glyphicon-star");
	});
	
	
		 var winHeight = 0;
/*
* 根据高度设定滚动条部分高度
*/
$(document).ready(function(){
	findDimensions();
});
window.onresize = findDimensions;
function findDimensions(){
	//获取窗口高度
	if (window.innerHeight){
		winHeight = window.innerHeight;
	} else if((document.body) && (document.body.clientHeight)){
		winHeight = document.body.clientHeight;
	}	
	$(".wrapper,.main").css("height", winHeight-60);	
	$(".inner-left,.inner-right").css("height", winHeight-150);	
}

});

