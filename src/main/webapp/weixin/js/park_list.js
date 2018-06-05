var	contextPath;
var currentCity = "全国";
var parkList;
var currentLng;
var currentLat;
$(function() {
    contextPath = $("#contextPath").val();
    currentCitySearch();
    getMyLocation();
})

function showInMap(longitude,latitude){
	var longitude = 121.330725;
	var latitude = 31.247019;
//	window.location.href = "http://api.map.baidu.com/geocoder?location="+latitude+","+longitude+"&coord_type=gcj02&output=html&src=yourCompanyName|yourAppName";
	window.location.href = "http://uri.amap.com/marker?position=121.330725,31.247019&name=新世界休闲生活广场B区";
}

function showSearch(){
    $(".park_type").css("display", "none");
    $(".sel_park").css("display", "none");
    $(".sel_address").css("display", "block");
    $(".search_input").animate({"width" : "87%"}, 200, null, function () {
        $(".search_cancel").css("display", "block");
    });
}

function hiddenSearch(){
    $(".park_type").css("display", "block");
    $(".search_cancel").css("display", "none");
    $(".sel_address").css("display", "none");
    $(".search_input").animate({"width" : "100%"}, 200, null, function () {});
    $(".sel_park").css("display", "block");
}
//定位当前经纬度
function getMyLocation(){
    $("body").showLoadingView();
    AMap.plugin('AMap.Geolocation', function () {
        var geolocation = new AMap.Geolocation({
            enableHighAccuracy: true,//是否使用高精度定位，默认:true
            timeout: 10000,          //超过10秒后停止定位，默认：无穷大
            maximumAge: 0,           //定位结果缓存0毫秒，默认：0
            convert: true,           //自动偏移坐标，偏移后的坐标为高德坐标，默认：true
            showButton: false,        //显示定位按钮，默认：true
            buttonPosition: 'LB',    //定位按钮停靠位置，默认：'LB'，左下角
            buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            showMarker: true,        //定位成功后在定位到的位置显示点标记，默认：true
            showCircle: true,        //定位成功后用圆圈表示定位精度范围，默认：true
            panToLocation: true,     //定位成功后将定位到的位置作为地图中心点，默认：true
            zoomToAccuracy: false      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
        });
        geolocation.getCurrentPosition();
        //返回定位信息
        AMap.event.addListener(geolocation, 'complete', function(geolocationResult){
//        	console.log(geolocationResult.position.lng, geolocationResult.position.lat);
            regeocoder(geolocationResult.position.lng, geolocationResult.position.lat);
            getParkList(geolocationResult.position.lng, geolocationResult.position.lat);
            currentLng = geolocationResult.position.lng;
            currentLat = geolocationResult.position.lat;
        });
        //返回定位出错信息
        AMap.event.addListener(geolocation, 'error', function(geolocationError){
            $("body").hiddenLoadingView();
            $("body").alertDialog({
                title: "提示",
                text: geolocationError.info
            });
        });
    })
}
/**
 * 逆向地理编码（坐标-地址）, 显示当前定位信息
 */
function regeocoder(lng, lat){
    var lnglat = [lng, lat];
    var geocoder = new AMap.Geocoder({
        radius: 1000,
        extensions: "base"
    });
    geocoder.getAddress(lnglat, function(status, result) {
        if (status === 'complete' && result.info === 'OK') {
            $(".current_address div").html("当前位置：" + result.regeocode.formattedAddress);
//            console.log(result.regeocode.formattedAddress);
        } else {
            $(".current_address div").html("当前位置：未知");
        }
    });
}
//输入提示
function autoComplete(obj){
    var keys = $.trim($(obj).val());
    if (keys == ''){
        $(".sel_address").html('');
        return;
    }
    var auto = new AMap.Autocomplete({
        city : currentCity,
        datatype : "poi"
    });
    auto.search($.trim($(obj).val()), function(status, result){
        if (status === 'complete') {
            var html = "";
            for (var i = 0; i < result.tips.length; i++){
                if (result.tips[i].location.lng == undefined || result.tips[i].location.lat == undefined){
                    continue;
                }
                html += "<div class='sel_address_div' onclick=\"clickAutoTips('" + result.tips[i].name + "'," + result.tips[i].location.lng + "," + result.tips[i].location.lat + ")\">" +
                            "<img src='" + contextPath + "/resources/images/weChat/park_list/icon_search_address@3x.png'>" +
                            "<div class='sel_address_div_title'>" + result.tips[i].name + "</div>" +
                            "<div class='sel_address_div_desc'>" + (result.tips[i].address == '' ? result.tips[i].name : result.tips[i].address) + "</div>" +
                        "</div>";
            }
            $(".sel_address").html(html);
            //alert(JSON.stringify(result));
        } else if (status === 'no_data'){
            $(".sel_address").html('');
        } else {
            $("body").alertDialog({
                title: "提示",
                text: result.info
            });
        }
    })
}
function clickAutoTips(name, lng, lat){
    $("body").showLoadingView();
    $(".search_input input").val(name);
    hiddenSearch();
    getParkList(lng, lat);
}
//通过ip定位城市信息
function currentCitySearch(){
    //加载IP定位插件
    AMap.plugin(["AMap.CitySearch"], function() {
        //实例化城市查询类
        var citysearch = new AMap.CitySearch();
        //自动获取用户IP，返回当前城市
        citysearch.getLocalCity();
        AMap.event.addListener(citysearch, "complete", function(result){
            if(result && result.city && result.bounds) {
                currentCity = result.city;
            } else {
                currentCity = "全国";
            }
        });
    });
}

function getParkList(lng, lat){
    var bdLngLat = ggToBd(lng, lat);
    $.ajax({
        type: "get",
        dateType: "json",
        url: "../smartPark/getParkListByGeo",
        data: {
			lng : bdLngLat.bd_lng, 
			lat : bdLngLat.bd_lat, 
			pageIndex : 1, 
			pageSize : 200
        },
        success: function(result) {
            $("body").hiddenLoadingView();
            console.log(result);
            if(result.success == true){
            	insertParkList(result.data,2);
            }else{
            	$("body").alertDialog({
                    title: "提示",
                    text: result.msg
                });
            }
//            insertParkList(2);
            //alert(JSON.stringify(result));
        }
    });
}
/**
 * 插入数据
 * @param type 1：全部；2：手机支付
 */
function insertParkList(parkList,type){
    if (type == 1){
        $(".park_type_button").removeClass("park_type_button_selected");
        $(".park_type_button_right").addClass("park_type_button_selected");
    }
    if (type == 2){
        $(".park_type_button").removeClass("park_type_button_selected");
        $(".park_type_button_left").addClass("park_type_button_selected");
    }
    var html = "";
    for (var i = 0; i < parkList.length; i++){
        var detail = parkList[i];
        if (type == 2 && detail.isSupportPay == 1){//如果只显示手机支付，则不显示
            continue;
        }
        var isSupportPay = detail.isSupportPay == 1 ? "payment_gray.png'>不支持手机支付" : "icon_search_payment_green@3x.png'>支持手机支付";
        html += "<div class='sel_park_div'>" +
                    "<div class='sel_park_div_1'>" +
                        "<div class='sel_park_div_name'>" + detail.name + "</div>" +
                        ((getCookie('webSourceType') == 2 || getCookie('webSourceType') == 1) ? "<div class='sel_park_div_button' onclick=\"jumpNaviPage('" + detail.name + "'," + detail.longitude + "," + detail.latitude + ");\">导航</div>" : "") +
                    "</div>" +
                    "<div class='sel_park_div_2'>" +
                        "<div class='sel_park_div_pay'><img src='images/" + isSupportPay + "</div>" +
                        "<span>|</span>" +
                        "<div class='sel_park_div_stock'>空闲车位：" + detail.freeSpace + "</div>"+
                    "</div>" +
                    "<div class='sel_park_div_3'>" +
                        "<div class='sel_park_div_price'>收费：<span class='red'>" + detail.spacePricePerhour + "</span>元/小时</div>" +
                        "<div class='sel_park_div_distance'>距离：" + distancePares(detail.distance) + "</div>" +
                    "</div>" +
                "</div>";
    }
    $(".sel_park").html(html);
}

function distancePares(distance){
    if (distance < 1000){
        return distance.toFixed(1) + "m";
    } else {
        return (distance / 1000).toFixed(1) + "km";
    }
}

function showOrderNavi(parkName, lng, lat, isSupportPay){
    $("#orderParkName").val(parkName);
    $("#orderLng").val(lng);
    $("#orderLat").val(lat);
    $(".order_navi_div_text_1").html("停车场：" + parkName);
    if (isSupportPay == 0){
        $(".order_navi_div_text_2").html("是否确认导航到该停车场？");
        $(".order_navi_div_button_1").css("display", "none");
        $(".order_navi_div_button_2").css("display", "none");
        $(".order_navi_div_button_3").css("display", "block");
    } else {
        $(".order_navi_div_text_2").html("是否确认预订停车位并导航？");
        $(".order_navi_div_button_1").css("display", "block");
        $(".order_navi_div_button_2").css("display", "block");
        $(".order_navi_div_button_3").css("display", "none");
    }
    $(".order_navi").css("display", "block");
}

function naviOrder(type){
    $('.order_navi').css('display', 'none');
    $("body").showLoadingView();
    $.ajax({
        type: "post",
        dateType: "json",
        url: "/psa/park/reserve/navigation",
        data: {psaId : getCookie("psaId"), parkName : $("#orderParkName").val(), lng : $("#orderLng").val(), lat : $("#orderLat").val(), type : type},
        success: function(result) {
            $("body").hiddenLoadingView();
            if (result.resCode == '000000') {
                showOrderNaviSucc(type);
            } else {
                $("body").alertDialog({
                    title: "提示",
                    text: result.msg
                });
            }
        }
    });
}

function showOrderNaviSucc(type){
    if (type == 1){
        $(".order_navi_succ_div img").attr("src", contextPath + "/resources/images/weChat/park_list/order_navi.gif?" + Math.random());
        $(".order_navi_succ_div span").html("预订&导航成功");
        $(".order_navi_succ_div img").css("marginTop", "0px");
        $(".order_navi_succ_div span").css("marginTop", "-50px");
    }
    if (type == 2){
        $(".order_navi_succ_div img").attr("src", contextPath + "/resources/images/weChat/park_list/order.gif?" + Math.random());
        $(".order_navi_succ_div span").html("预订成功");
        $(".order_navi_succ_div img").css("marginTop", "-10px");
        $(".order_navi_succ_div span").css("marginTop", "-40px");
    }
    if (type == 3){
        $(".order_navi_succ_div img").attr("src", contextPath + "/resources/images/weChat/park_list/navi.gif?" + Math.random());
        $(".order_navi_succ_div span").html("导航成功");
        $(".order_navi_succ_div img").css("marginTop", "0px");
        $(".order_navi_succ_div span").css("marginTop", "-50px");
    }
    $('.order_navi_succ').css('display', 'block');
}

function jumpNaviPage(name, lng, lat){
    var ggLngLat = bdToGg(lng, lat);
    window.location.href = "http://m.amap.com/navi/?start=" + currentLng + "," + currentLat + "&dest=" + ggLngLat.gg_lng
        + "," + ggLngLat.gg_lat + "&destName=" + name + "&naviBy=car&key=4e7974f854b5d6a5368662dc3204c262";
}