var myChart = echarts.init(document.getElementById('main'));
var option = {
    backgroundColor: '#000',
    globe: {
        baseTexture: 'img/data-1491890179041-Hkj-elqpe.jpg',
        heightTexture: 'img/data-1491889019097-rJQYikcpl.jpg',
        displacementScale: 0.01,
        shading: 'lambert',
        environment: 'img/data-1491837999815-H1_44Qtal.jpg',
        light: {
            ambient: {
                intensity: 0.1
            },
            main: {
                intensity: 1.5
            }
        },
        layers: [{
            type: 'blend',
            blendTo: 'emission',
            texture: 'img/data-1491890291849-rJ2uee5ag.jpg'
        }, {
            type: 'overlay',
            texture: 'img/data-1491890092270-BJEhJg96l.png',
            shading: 'lambert',
            distance: 5
        }]
    },
    series: []
}
$(document).ready(function () {
    myChart.setOption(option);
    $('#loginBtn').click(function () {
        if (!$('.idBox').hasClass('bounceInLeft') || $('.idBox').hasClass('bounceOutLeft') || $(
                '.idBox').hasClass('register')) {
            $('.idBox').addClass('animated bounceInLeft login');
            $('.pwdBox').addClass('animated bounceInRight login');
            $('.codeBox').addClass('animated bounceInLeft login');
            $('.idBox').removeClass('bounceOutLeft register');
            $('.pwdBox').removeClass('bounceOutRight register');
            $('.codeBox').removeClass('bounceOutLeft register');
            $('.idBox').show();
            $('.forgetPwd').removeClass('bounceOutRight');
            $('.forgetPwd').addClass('bounceInRight');
            $('.pwdBox').show();
            $('.codeBox').show();
        } else {
            $('.idBox').removeClass('bounceInLeft');
            $('.pwdBox').removeClass('bounceInRight');
            $('.codeBox').removeClass('bounceInLeft');
            $('.idBox').addClass('bounceOutLeft');
            $('.pwdBox').addClass('bounceOutRight');
            $('.codeBox').addClass('bounceOutLeft');
        }
    })
    $('#registerBtn').click(function () {
        if (!$('.idBox').hasClass('bounceInLeft') || $('.idBox').hasClass('bounceOutLeft') || $('.idBox').hasClass('login')) {
            $('.codeBox').addClass('bounceOutLeft');
            $('.idBox').addClass('animated bounceInLeft register');
            $('.pwdBox').addClass('animated bounceInRight register');
            $('.idBox').removeClass('bounceOutLeft login');
            $('.pwdBox').removeClass('bounceOutRight login ');
            $('.forgetPwd').addClass('animated bounceOutRight');
            $('.idBox').show();
            $('.pwdBox').show();
        } else {
            $('.idBox').removeClass('bounceInLeft');
            $('.pwdBox').removeClass('bounceInRight');
            $('.idBox').addClass('bounceOutLeft');
            $('.pwdBox').addClass('bounceOutRight');
        }
    })
    $("#loginBtn_").click(function(){
    	weblogin();
    });
    
    $(".container").keypress(function(e) {
    	var keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
    	if (keyCode == 13) {
    		weblogin();
    	}
    });
    
    /**
     * input失去焦点事件focusout
     * 这跟blur事件区别在于，他可以在父元素上检测子元素失去焦点的情况。
     */
    $("#userName").focusout(function(e){
        var msg="请填写用户名！";
        if($.trim($(this).val())==""){
        	showTip(msg,'#userName');
        }
    });
    $("#userPwd").focusout(function(e){
    	var msg="请填写用户密码！";
    	if($.trim($(this).val())==""){
    		showTip(msg,'#userPwd');
    	}
    });
    $("#userImgCode").focusout(function(e){
    	var msg="请填写验证码！";
    	if($.trim($(this).val())==""){
    		showTip(msg,'#img');
    	}
    });
});

function weblogin(){
	var userName = $("#userName").val();
	var userPwd = $("#userPwd").val();
	var imgCode = $("#userImgCode").val();
	if($.trim(userName)==""){
		showTip("请填写用户名！",'#userName');
		return;
	}
	if($.trim(userPwd)==""){
		showTip("请填写用户密码！",'#userPwd');
		return;
	}
	if($.trim(imgCode)==""){
		showTip("请填写验证码！",'#img');
		return;
	}
	$.post(path+"/webctrl/login/", 
	{
		userName:userName,
		userPwd:userPwd,
		imgCode:imgCode
	},
	function(result){
		if(result.success == true){//登陆成功
			window.location.href="index.jsp"; 
		}else {
			layer.tips('登陆失败：'+result.msg, '#loginBtn_', {
				tips: [2, '#CC0033']
			});
			changeImg()
		}
	},'json');
}

function showTip(msg,id){
	layer.tips(msg, id, {
		tips: [2, '#CC0033'] //还可配置颜色
	});
}
