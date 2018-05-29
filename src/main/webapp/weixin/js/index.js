$(function() {
//	alert(getParam("code"));
	init();
})


function init(){
	var code = getParam("code");
	getCarParkInfo(code);
	
}
function getCarParkInfo(code){
	$.post("../wechat/getCarParkInfoByCode/", 
	{
		authCode:code
	},
	function(result){
		if(result.success == true){//登陆成功
//			console.log(result);
//			consoleLog(JSON.stringify(result));
			var data = result.data;
			if(data.state){
				if("1" == data.state){
				}else{//未绑定手机，跳转手机页面
					window.location.href = "validateMobile.htm";
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