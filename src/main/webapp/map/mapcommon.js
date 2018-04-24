/**
 * Created by huangdong on 13/6/2016.
 */
function t(e) {
    lianjiaCasManager ? e() : o = e
}
function e() {
    lianjiaCasManager.config({
        setLoginUrl: $.env.fixedUrl("//login.lianjia.com/login/getUserInfo/"),
        service: location.href
    }), o && o()
}
function a() {
    $(".panel_login").fadeOut(), $(".overlay_bg").fadeOut(), $("body").css({overflow: ""}), $("#dialog").removeClass("bounceIn")
}

jQuery(function(){
    $(".typeUserInfo").delegate(".btn-login", "click", function (e) {
        return $(".overlay_bg").fadeIn(300), $(".panel_login").removeAttr("class").addClass("panel_login animated bounceIn").fadeIn(), $("body").css({overflow: "hidden"}), !1
    }), $(".overlay_bg,.claseDialogBtn").click(function () {
        a()
    }), $("#con_login_user ul").delegate("input", "keyup", function (e) {
        e.stopPropagation();
        e.preventDefault();
        if(13 == e.keyCode){
            $(".login-user-btn-submit").click();
        }
    }), $(".login-user-btn-submit").on("click", function (e) {
        function n(e) {
            e = e || "用户名或者密码错误";
            var t = $("#con_login_user").find(".show-error");
            t.find("dd").html(e), t.show()
        }

        var a = $("#con_login_user").find(".item"),
            r = ($("#con_login_agent").find(".item"), a.find(".users").val()),
            o = a.find(".password").val();
        if (!r) return void a.find(".users").focus();
        if (!o) return void a.find(".password").focus();
        var i = $("#con_login_user").find('[name="remember"]').get(0),
            s = {username: r, password: o, verifycode: ""};
        if (i && i.checked && (s.remember = 1), "none" != $(".checkVerimg").css("display")) {
            if (!$(".ver-img").val()) return void $(".ver-img").focus();
            s.verifyCode = $(".ver-img").val()
        }
        t(function () {
            lianjiaCasManager.login(
                //    {
                //    username: $.trim($("#user_name").val()),
                //    password: $.trim($("#user_password").val()),
                //    verifycode: ""
                //}
                s
                ,function(e) {
                    //登录成功
                    window.location.reload();
                },
                function() {
                    //登录失败
                    loginDoing = false;
                    $(".show-error").show();
                    console.info("执行失败");
                }
            );
            //lianjiaCasManager.login(s, function (e) {
            //    -1 == e.code ? n() : ($.listener.trigger("loginActSuccess"), window.NOTAUTOJUMP || location.reload())
            //}, function () {
            //    n()
            //})
        })
    });


});

function checkBrowserIsLegal(){
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
    var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器

    var legalBrowser = true;

    if (isIE) {
        var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
        reIE.test(userAgent);
        var fIEVersion = parseFloat(RegExp["$1"]);

        legalBrowser = fIEVersion > 8.0;//如果小于版本ie8
    }

    return legalBrowser;
}
