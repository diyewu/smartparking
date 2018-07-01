$(function(){
	loadOrderInfo();
})
var globalOrderNo = "";
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
			$("#footer").attr("onclick","getPrepayInfo('"+data[0].id+"')");
			globalOrderNo = data[0].id;
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

function getPrepayInfo(orderNo){
	$("#footer").attr("onclick","");
	$("#paytext").html("支付中...");
	$("body").showLoadingView();
	var orderNo = getParam('orderNo');
	$.post("../wepay/getWePayPrepayId/", 
	{
		orderNo:orderNo
	},
	function(result){
		$("body").hiddenLoadingView();
		if(result.success == true){
			var data = result.data;
			if(data){
				var appId = data.appId;
				var timeStamp = data.timeStamp;
				var nonceStr = data.nonceStr;
				var Package = data.package;
				var signType = data.signType;
				var paySign = data.paySign;
				
				onBridgeReady(appId, timeStamp, nonceStr, Package, signType, paySign)
				
			}
		}else{
			$("body").alertDialog({
				title: "提示",
				text: result.msg,
				okFtn: function(){
//					window.location.href = "index.html";
				}
			});
		}
		$("#footer").attr("onclick","getPrepayInfo('"+globalOrderNo+"')");
		$("#paytext").html("确认支付:");
	},'json');
}

function onBridgeReady(appId,timeStamp,nonceStr,Package,signType,paySign) {
	WeixinJSBridge.invoke(
		'getBrandWCPayRequest', {
			"appId" : appId, //公众号名称，由商户传入
			"timeStamp" : timeStamp, //时间戳，自1970年以来的秒数     
			"nonceStr" : nonceStr, //随机串     
			"package" : Package,
			"signType" : signType, //微信签名方式：     
			"paySign" : paySign //微信签名 
		},
		function(res) {
			if (res.err_msg == "get_brand_wcpay_request:ok") {
				$("body").alertDialog({
					title: "提示",
					text: "支付成功！",
					okFtn: function(){
					   window.location.replace("index.html");
					}
				});
				
			}
		}
	);
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