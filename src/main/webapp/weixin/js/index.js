$(function() {
//	alert(getParam("code"));
	init();
})


function init(){
	var code = getParam("code");
	getCarParkInfo(code);
	
}
function getCarParkInfo(code){
	$("body").showLoadingView();
	$.post("../wechat/getCarParkInfoByCode/", 
	{
		authCode:code
	},
	function(result){
		$("body").hiddenLoadingView();
		if(result.success == true){//登陆成功
			var data = result.data;
//			alert(data.state);
			if(data.state){
				if("1" == data.state){//已经绑定过手机，展示当前停车信息
					if(data.carstate){//查询到车辆信息，并且拿到车辆停车状态
						var carState = data.carstate;
						//TODO 添加当前车辆状态
					}else{//查询不到车辆信息
						
					}
					
				}else{//未绑定手机，跳转手机页面
//					window.location.href = "validateMobile.html";
				}
			}
		}else {
		}
	},'json');
}

function consoleLog(data){
	$.post("../wechat/console/", 
	{
		data:data
	},
	function(result){
		
	},'json');
}