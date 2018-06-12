$(function(){
	loadOrderInfo();
})

function loadOrderInfo(){
	$("body").showLoadingView();
	var orderNo = getParam('orderNo');
	$.post("../smartOrder/getOrderInfoByOrderNo/", 
	{
		orderNo:orderNo
	},
	function(result){
		$("body").hiddenLoadingView();
		if(result.success == true){
			var data = result.data;
			$("#pay_order_amount").html(data[0].receivable_amount);
			$("#pay_order_amount_bo").html(data[0].receivable_amount);
			$("#pay_order_begin_time").html(data[0].begin_time);
			$("#pay_order_end_time").html(data[0].end_time);
			$("#pay_order_no").html(data[0].id);
		}else{
			$("body").alertDialog({
				title: "提示",
				text: result.msg,
				okFtn: function(){
					window.location.href = "index.html";
				}
			});
		}
		
	},'json');
}

function runTime(){
	var m=29;
	var s=59;
	setInterval(function(){
		if(s<10){
			$('#left_time').html(m+':0'+s);
		}else{
			$('#left_time').html(m+':'+s);
		}
		s--;
		if(s<0){
			s=59;
			m--;
		}
	},1000)
}