var	contextPath;
var pageIndex = 0;
var pageSize = 10;
$(function(){
    contextPath = $("#contextPath").val();
    getCoupon(1);
    refresher.init({
        id: "wrapper",
        pullDownAction: Refresh,
        pullUpAction: Load
    })
})

function Refresh() {
    setTimeout(function () {
        getCoupon(1);
    }, 1000);

}

function Load() {
    setTimeout(function () {// <-- Simulate network congestion, remove setTimeout from production!
        getCoupon(2);
    }, 1000);
}

/**
 * 获取数据
 * @param type （1：下拉；2：上拉加载更多）
 */
function getCoupon(type){
    if (type == 1){
        pageIndex = 0;
    }
    if (type == 2 && pageIndex == -1){
        wrapper.refresh();
        return;
    }
    var memberId = getParam("memberId");
    var time = getParam("time");
    var sign = getParam("sign");
    $.ajax({
        type: "get",
        dateType: "json",
        url: "../smartOrder/getOrderList/",
        data: {
        	memberId:memberId,
        	time:time,
        	sign:sign,
        	pageIndex:pageIndex,
        	pageSize:pageSize
        	
        },
        success: function(result) {
        	console.log(result);
            if (result.success == true) {
                if (result.data.total == 0){
                    $(".scroller ul").html(
                        "<li class='order_none_div' style='height: " + (document.body.offsetHeight) + "px'>" +
                        "<div class='order_none_img'>" +
                        "<img src='images/pic_discount_unavailable@3x.png'>" +
                        "</div>" +
                        "<div class='order_none_text'>暂无订单</div>" +
                        "</li>");
                    wrapper.refresh();
                }else{
                	var totalPage = result.data.totalPage;
                    if (totalPage <= pageIndex){
                        pageIndex = -1;
                    } else {
                        pageIndex++;
                    }
                    if (type == 1){
                        $(".scroller ul").html("");
                    }
                    for (var i = 0; i < result.data.list.length; i++){
                        var order = result.data.list[i];
                        var status = order.status;
                        var insertDiv;
                        if (status == 0){//完结
                        	insertDiv = "<div class='order_left_blue'></div>已完结</div>";
                        }else if(status == 1){//申请驶入
                        	insertDiv = "<div class='order_left_blue'></div>申请驶入</div>";
                        }else if(status == 2){//停车中
                        	insertDiv = "<div class='order_left_blue'></div>停车中</div>";
                        }else if(status == 3){//待支付
                        	insertDiv = "<div class='order_left_blue'></div>待支付</div><div onclick='jumpPay(\"" + order.id +  "\")' class='order_right'>去支付</div>";
                        }else if(status == 4){//待出场
                        	insertDiv = "<div class='order_left_blue'></div>待出场</div>";
                        }else if(status == 5){//异常
                        	insertDiv = "<div class='order_left_blue'></div>异常</div>";
                        }else if(status == 6){//取消
                        	insertDiv = "<div class='order_left_blue'></div>已取消</div>";
                        }
                        /*
                        if (status == 1){
                            insertDiv = "<div class='order_left_blue'></div>预约成功</div><div onclick='jumpOrderRenewPage(" + order.orderNo + "," + order.monthlyTypeId + ")' class='order_right'>立即续约</div>";
                        } else if (status == 2){
                            insertDiv = "<div class='order_left_blue'></div>订单执行中</div><div onclick='jumpOrderRenewPage(" + order.orderNo + "," + order.monthlyTypeId + ")' class='order_right'>立即续约</div>";
                        } else if (status == 4){
                            insertDiv = "<div class='order_left_blue'></div>包月结束</div>";
                        } else if (status == 6){
                            var refundStatus = order.refundStatus;
                            if (refundStatus == 2){
                                insertDiv = "<div class='order_left_blue'></div>订单取消中</div>";
                            } else if (refundStatus == 3) {
                                insertDiv = "<div class='order_left_blue'></div>订单已取消</div>";
                            }
                        }
                        */
                        $(".scroller ul").append(
                            "<li>" +
                                "<div class='order_line'>" +
                                    "<div class='order_left'>" + insertDiv +
                                "</div>" +
                                "<div class='order_line_1'>" +
                                    "<div class='order_line_1_left'>" + order.park_name + "</div>  " +
                                    "<div class='order_line_1_right" + ((status == 1 || status == 2) ? " order_red" : "") + "'><span>" + parseFloat(order.receivable_amount) + "</span>元</div>  " +
                                "</div>" 
                                //+"<div onclick='jumpOrderDetailPage(" + order.id + ")' class='order_line_2'>包月时长：" + order.validBeginDate + "-" + order.validEndDate + "</div>" +
                            +"</li>");
                    }
                    wrapper.refresh();
                }
            } else {
                alert(result.msg);
            }

        }
    });
    /*
    if (result.data.totalSize == 0){
        $(".scroller ul").html(
            "<li class='order_none_div' style='height: " + (document.body.offsetHeight) + "px'>" +
            "<div class='order_none_img'>" +
            "<img src='images/pic_discount_unavailable@3x.png'>" +
            "</div>" +
            "<div class='order_none_text'>暂无订单</div>" +
            "</li>");
        wrapper.refresh();
        return;
    }
    var totalPage = result.data.totalPage;
    if (totalPage <= pageIndex){
        pageIndex = -1;
    } else {
        pageIndex++;
    }
    if (type == 1){
        $(".scroller ul").html("");
    }
    for (var i = 0; i < result.data.data.length; i++){
        var order = result.data.data[i];
        var status = order.status;//1：预约成功 2：订单执行中 4：订单完成 6：订单车主取消
        var insertDiv;;
        if (status == 1){
            insertDiv = "<div class='order_left_blue'></div>预约成功</div><div onclick='jumpOrderRenewPage(" + order.orderNo + "," + order.monthlyTypeId + ")' class='order_right'>立即续约</div>";
        } else if (status == 2){
            insertDiv = "<div class='order_left_blue'></div>订单执行中</div><div onclick='jumpOrderRenewPage(" + order.orderNo + "," + order.monthlyTypeId + ")' class='order_right'>立即续约</div>";
        } else if (status == 4){
            insertDiv = "<div class='order_left_blue'></div>包月结束</div>";
        } else if (status == 6){
            var refundStatus = order.refundStatus;
            if (refundStatus == 2){
                insertDiv = "<div class='order_left_blue'></div>订单取消中</div>";
            } else if (refundStatus == 3) {
                insertDiv = "<div class='order_left_blue'></div>订单已取消</div>";
            }
        }
        $(".scroller ul").append(
            "<li>" +
                "<div class='order_line'>" +
                    "<div class='order_left'>" + insertDiv +
                "</div>" +
                "<div onclick='jumpOrderDetailPage(" + order.orderNo + ")' class='order_line_1'>" +
                    "<div class='order_line_1_left'>" + order.parkName + "</div>  " +
                    "<div class='order_line_1_right" + ((status == 1 || status == 2) ? " order_red" : "") + "'><span>" + parseFloat(order.parkingAmt) + "</span>元</div>  " +
                "</div>" +
                "<div onclick='jumpOrderDetailPage(" + order.orderNo + ")' class='order_line_2'>包月时长：" + order.validBeginDate + "-" + order.validEndDate + "</div>" +
            "</li>");
    }
    wrapper.refresh();
     */
}

function jumpPay(orderNo){
	window.location.href = "pay.html?orderNo="+orderNo
}

function jumpOrderDetailPage(orderNo){
    window.location.href = contextPath + "/weixin/order/detail/init/" + getCookie('openid') + "/" + orderNo;
}
function jumpOrderRenewPage(orderNo, monthlyTypeId){
    window.location.href = contextPath + "/weixin/order/park/type/init?openid=" + getCookie('openid')
        + "&monthlyTypeId=" + monthlyTypeId + "&monthlyBeginDate=0&orderNo=" + orderNo;
}