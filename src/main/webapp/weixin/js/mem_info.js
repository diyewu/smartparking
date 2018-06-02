/**
 * Created by chengwang on 2016/7/28.
 */
var	contextPath;
$(function() {
    contextPath = $("#contextPath").val();

    var platType = getCookie('platType');
    if (platType == 2){//支付宝支付
        $(".share_friend").css('visibility', 'hidden');
    }
})