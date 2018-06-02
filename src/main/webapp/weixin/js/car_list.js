/**
 * Created by wangcheng on 2016/5/3.
 */
var	contextPath;
$(function(){
    contextPath = $("#contextPath").val();
    setCookie("homepageRefreshFlag", 1);//设置首页刷新flag,1则返回首页要刷新页面
});

function deleteCarNum(obj, carNum){
    $("body").confirmDialog({
        title: "提示",
        text: "是否删除该车牌？",
        okFtn: function(){
            $("body").showLoadingView();
            $.ajax({
                type: "post",
                dateType: "json",
                url: contextPath + "/weixin/car/delete",
                data: {carNum : carNum, openid : getCookie('openid')},
                success: function(result) {
                    $("body").hiddenLoadingView();
                    if (result.resCode == '000000') {
                        location.reload();
                    } else {
                        $("body").alertDialog({
                            title: "提示",
                            text: result.msg
                        });
                    }
                }
            });
        }
    });
}