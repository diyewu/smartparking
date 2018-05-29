$(function() {
//	alert(getParam("code"));
	
})


function init(){
	var code = getParam("code");
	
}
function getCarParkInfo(code){
	$.post("../wechat/getCarParkInfoByCode/", 
	{
		authCode:code
	},
	function(result){
		if(result.success == true){//登陆成功
			console.log(result);
		}else {
		}
	},'json');
}