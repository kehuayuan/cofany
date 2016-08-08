$(function(){
	$(".oms-cd li a").mouseover(function() {
		var oimg=$(this).children('img');
		var str=oimg.attr('src');
		re=new RegExp(".png","g");
   		var newstr=str.replace(re,"-hover.png");
		oimg.attr('src',newstr);
	}).mouseout(function() {
		var oimg=$(this).children('img');
		var str=oimg.attr('src');
		re=new RegExp("-hover.png","g");
   		var newstr=str.replace(re,".png");
		oimg.attr('src',newstr);
		});
	$(".sidebar ul li").click(function(){
		$(".sidebar ul li").removeClass("cd-hover");
		$(this).addClass("cd-hover");
	});
});