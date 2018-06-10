$(document).ready(function() {
	loadCar();
	loadPark()
})

function loadCar() {
	$.post("../demo/listCar/",
		{
		},
		function(result) {
			if (result.success == true) {
				var data = result.data;
				for (var i = 0; i < data.length; i++) {
					$("#select_car").append("<option value=\"" + data.id + "\">" + data.car_number + "</option>");
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
					$("#select_park").append("<option value=\"" + data.id + "\">" + data.park_name + "</option>");
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
					$("#select_space").append("<option value=\"" + data.id + "\">" + data.space_name + "</option>");
				}
			}
		}, 'json');
}


