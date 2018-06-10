$(document).ready(function() {
	loadCar();
	loadPark();
	$("#select_park").change(function() {
		var opt = $("#select_park").val();
		refreshParkSpace(opt);
	});
	$("#select_space").change(function() {
		var opt = $("#select_space option:selected").attr("data");
		$("#u111_input").val(opt);
	});
})

function loadCar() {
	$.post("../demo/listCar/",
		{
		},
		function(result) {
			if (result.success == true) {
				var data = result.data;
				for (var i = 0; i < data.length; i++) {
					$("#select_car").append("<option value=\"" + data[i].id + "\">" + data[i].car_number + "</option>");
				}
			}
		}, 'json');
}
function loadPark() {
	$.post("../demo/listPark/",
		{
		},
		function(result) {
			if (result.success == true) {
				var data = result.data;
				for (var i = 0; i < data.length; i++) {
					$("#select_park").append("<option value=\"" + data[i].id + "\">" + data[i].park_name + "</option>");
				}
			}
		}, 'json');
}

function refreshParkSpace(parkId) {
	$.post("../demo/listSpaceByPark/",
		{
			parkId : parkId
		},
		function(result) {
			if (result.success == true) {
				$("#select_space").empty();
				var data = result.data;
				for (var i = 0; i < data.length; i++) {
					$("#select_space").append("<option data=\"" + data[i].space_price_perhour + "\" value=\"" + data[i].id + "\">" + data[i].space_name + "</option>");
				}
			}
		}, 'json');
}

/**
 * 申请进场
 */
function askInParking() {
	var carNumber = $("#select_car option:selected").html();
	var parkId = $("#select_park option:selected").val();
	$.post("../demo/askInParking/",
		{
			parkId : parkId,
			carNumber:carNumber,
			spaceId:$("#select_space option:selected").val()
		},
		function(result) {
			if (result.success == true) {
				alert("允许进入");
			}else{
				alert(result.msg);
			}
		}, 'json');
}
/**
 * 申请出场
 */
function askOutParking() {
	var carNumber = $("#select_car option:selected").html();
	var parkId = $("#select_park option:selected").val();
	$.post("../demo/askOutParking/",
			{
				parkId : parkId,
				carNumber:carNumber
			},
			function(result) {
				if (result.success == true) {
					stop();
					alert("允许出场");
				}else{
					alert(result.msg);
				}
			}, 'json');
}
/**
 * 驶入或驶出停车场
 * 0 驶入； 1 驶出
 */
function parking(parkingType) {
	var carNumber = $("#select_car option:selected").html();
	var parkId = $("#select_park option:selected").val();
	var spaceId = $("#select_space option:selected").val();
	$.post("../demo/parking/",
			{
				carNumber:carNumber,
				parkId : parkId,
				spaceId : spaceId,
//				entranceId : entranceId,
				parkingType : parkingType
			},
			function(result) {
				if (result.success == true) {
					start();
					alert("开始计时");
				}else{
					alert(result.msg);
				}
			}, 'json');
}



//初始化变量
var hour,minute,second;//时 分 秒
hour=minute=second=0;//初始化
var millisecond=0;//毫秒
var int;
//重置函数
function Reset()
{
  window.clearInterval(int);
  millisecond=hour=minute=second=0;
  document.getElementById('u114_input').value='00时00分00秒000毫秒';
}
//开始函数
function start()
{
  int=setInterval(timer,50);//每隔50毫秒执行一次timer函数
}
//计时函数
function timer()
{
  millisecond=millisecond+50;
  if(millisecond>=1000)
  {
    millisecond=0;
    second=second+1;
  }
  if(second>=60)
  {
    second=0;
    minute=minute+1;
  }

  if(minute>=60)
  {
    minute=0;
    hour=hour+1;
  }
  document.getElementById('u114_input').value=hour+'时'+minute+'分'+second+'秒'+millisecond+'毫秒';

}
//暂停函数
function stop()
{
  window.clearInterval(int);
}