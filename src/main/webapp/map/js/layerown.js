//弹出一个提示层
$('#test1').on('click', function() {
	layer.msg('hello');
});

$(document).ready(function() {
	//alert(document.body.clientWidth);
	var clientWidth = document.body.clientWidth;
	var clientHeight = document.body.clientHeight;
//	layer.open({
//	  type: 1,
//	  title: false,
//	  closeBtn: 0,
//	  area: [clientWidth,clientHeight],
//	  shadeClose: true,
//	  offset: 'lt',
//	  content: $("#playearthmap")
//	});
	
});

function endPlay(){
	$("#playearthmap").slideDown();
}