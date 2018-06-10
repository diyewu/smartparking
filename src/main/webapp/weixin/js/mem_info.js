var	contextPath;
$(function() {
	showUserName();
    var platType = getCookie('platType');
    if (platType == 2){//支付宝支付
        $(".share_friend").css('visibility', 'hidden');
    }
})

/**
 * 获取当前登录用户信息
 */
function showUserName(){
	$("body").showLoadingView();
	jQuery.ajax({  
	    url: "../smartMember/getCurrentUserInfo/",  
	    type: "post",  
	    dataType: "json",  
	    async: false,  
	    data: {
	    },  
	    success: function(result){  
	    	$("body").hiddenLoadingView();
			if(result.success == true){//登陆成功
				var data = result.data;
				$(".mem_name").html(data.mobile);
			}else {//验证失败
				$("body").alertDialog({
                    title: "提示",
                    text: result.msg,
                    okFtn: function(){
                        window.location.href = "validateMobile.html";
                    }
                });
			}
	    }  
	});  
}