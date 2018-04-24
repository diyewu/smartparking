<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>主页</title>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=plEzfOG4jm58EGxEsHw4kCPoG3UjOcNv"></script>
    <script src="js/layer/layer.js"></script>
    <script src="js/common.js"></script>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" type="text/css" href="css/layerown.css" />
    <script type="text/javascript" src="js/layerown.js"></script>
    <script src="js/classie.js"></script>
</head>

<body style="overflow:hidden;">
	<div class = "video-class" style="z-index:9999" id = "playearthmap">
	  	<video autoplay muted style="width:100%" onended = "endPlay();";>
	  		<source src="img/dfmz1.mp4" type="video/mp4">
	  	</video>
  	</div>
  
    <div  style="z-index:1" class="container" id="container">
			<button class="trigger" data-info=""><span></span></button>
        <div class="header" id="header">
            <a href="/" class="logo"></a>
            <input type="text" placeholder="请输入区域、板块或楼盘名" class="search-input" @click="resultFlag = !resultFlag">
            <a class="search-btn"><i class="fa fa-search" aria-hidden="true"></i></a>
            <div class="result-list" style="display: none;">
                <ul>

                </ul>
            </div>
            <div class="result-list" v-show="resultFlag" style="display:none;">
                <ul>
                    <li class="hot-title">热门搜索</li>
                    <li>
                        <span class="name-span">中环国际公寓三期</span>
                    </li>
                    <li>
                        <span class="name-span">佳兆业君汇上品</span>
                    </li>
                    <li>
                        <span class="name-span">中骏天悦</span>
                    </li>
                    <li>
                        <span class="name-span">香溢花城</span>
                    </li>
                    <li>
                        <span class="name-span">路劲佘山院子</span>
                    </li>
                    <li>
                        <span class="name-span">上海Villa</span>
                    </li>
                    <li>
                        <span class="name-span">中铁北城时代</span>
                    </li>
                    <li>
                        <span class="name-span">臻水岸</span>
                    </li>
                    <li>
                        <span class="name-span">尚景丽园</span>
                    </li>
                </ul>
            </div>
            <div class="region-box" @mouseenter="over('region')" @mouseleave="out('region')">
                <a href="javascript:;" id="regionTab" class="region" :class="{'expand':expand=='region'}" @click="">
                                    <span>区域/地铁</span>
                                    <i class="fa fa-sort-desc" aria-hidden="true"></i>                        
                                </a>
            </div>
            <div class="region-list slide-transition sh" style="display: none;" v-show="subFlag == 'region'" @mouseenter="subOver('region')"
                @mouseleave="subOut('region')">
                <ul class="first-info-list">
                    <li :class="{ 'selected': selected == 1 }" @mouseenter="selected = 1">不限</li>
                    <li :class="{ 'selected': selected == 2 }" @mouseenter="selected = 2">区域</li>
                    <li :class="{ 'selected': selected == 3 }" @mouseenter="selected = 3">地铁</li>
                </ul>
                <ul class="second-info-list data-list swing-transition" style="display: none;" v-show="selected == 3">
                    <li>全部</li>
                    <li data-dianji="区域/地铁/1号线">1号线</li>
                    <li data-dianji="区域/地铁/2号线">2号线</li>
                    <li data-dianji="区域/地铁/3号线">3号线</li>
                    <li data-dianji="区域/地铁/4号线">4号线</li>
                    <li data-dianji="区域/地铁/5号线">5号线</li>
                    <li data-dianji="区域/地铁/6号线">6号线</li>
                    <li data-dianji="区域/地铁/7号线">7号线</li>
                    <li data-dianji="区域/地铁/8号线">8号线</li>
                    <li data-dianji="区域/地铁/9号线">9号线</li>
                    <li data-dianji="区域/地铁/10号线">10号线</li>
                    <li data-dianji="区域/地铁/11号线">11号线</li>
                    <li data-dianji="区域/地铁/12号线">12号线</li>
                    <li data-dianji="区域/地铁/13号线">13号线</li>
                    <li data-dianji="区域/地铁/14号线(在建)">14号线(在建)</li>
                    <li data-dianji="区域/地铁/15号线(在建)">15号线(在建)</li>
                    <li data-dianji="区域/地铁/16号线">16号线</li>
                    <li data-dianji="区域/地铁/17号线(在建)">17号线(在建)</li>
                    <li data-dianji="区域/地铁/18号线(在建)">18号线(在建)</li>
                </ul>
                <ul class="third-info-list data-list swing-transition" style="display: none;" v-show="selected == 2">
                    <li>全部</li>
                    <li data-dianji="bizcircle/华新">华新</li>
                    <li data-dianji="bizcircle/香花桥">香花桥</li>
                    <li data-dianji="bizcircle/徐泾">徐泾</li>
                    <li data-dianji="bizcircle/夏阳">夏阳</li>
                    <li data-dianji="bizcircle/盈浦">盈浦</li>
                    <li data-dianji="bizcircle/重固">重固</li>
                    <li data-dianji="bizcircle/朱家角">朱家角</li>
                    <li data-dianji="bizcircle/赵巷">赵巷</li>
                </ul>
            </div>
            <div class="filter-box">
                <a href="javascript:;" class="filter price" :class="{'expand':expand=='price'}" @mouseenter="over('price')" @mouseleave="out('price')">
                                    <span>总价</span>
                                    <i class="fa fa-sort-desc" aria-hidden="true"></i>                        
                                </a>
            </div>
            <div class="info-list price slide-transition" style="display: none;" v-show="subFlag=='price'" @mouseenter="subOver('price')"
                @mouseleave="subOut('price')">
                <ul>
                    <li>不限</li>
                    <li data-dianji="price/100万以下">
                        <span class="text">
                                            100万以下
                                        </span>

                    </li>
                    <li data-dianji="price/100-200万">
                        <span class="text">
                                            100-200万
                                        </span>

                    </li>
                    <li data-dianji="price/200-300万">
                        <span class="text">
                                            200-300万
                                        </span>

                    </li>
                    <li data-dianji="price/300-400万">
                        <span class="text">
                                            300-400万
                                        </span>

                    </li>
                    <li data-dianji="price/400-500万">
                        <span class="text">
                                            400-500万
                                        </span>

                    </li>
                    <li data-dianji="price/500-800万">
                        <span class="text">
                                            500-800万
                                        </span>

                    </li>
                    <li data-dianji="price/800-1000万">
                        <span class="text">
                                            800-1000万
                                        </span>

                    </li>
                    <li data-dianji="price/1000万以上">
                        <span class="text">
                                            1000万以上
                                        </span>

                    </li>
                </ul>
            </div>
            <div class="filter-box">
                <a href="javascript:;" class="filter room" :class="{'expand':expand=='room'}" @mouseenter="over('room')" @mouseleave="out('room')">
                                    <span>户型</span>
                                    <i class="fa fa-sort-desc" aria-hidden="true"></i>                        
                                </a>
            </div>
            <div class="info-list room slide-transition" style="display: none;" v-show="subFlag=='room'" @mouseenter="subOver('room')"
                @mouseleave="subOut('room')">
                <ul>
                    <li>不限</li>
                    <li data-dianji="room/一室" @click="smcbSelect($event)">
                        <span class="text">
                                            一室
                                        </span>
                        <div class="checkbox checkbox-sm">
                            <span class="check"></span>
                        </div>
                    </li>
                    <li data-dianji="room/二室" @click="smcbSelect($event)">
                        <span class="text">
                                            二室
                                        </span>
                        <div class="checkbox checkbox-sm">
                            <span class="check"></span>
                        </div>
                    </li>
                    <li data-dianji="room/三室" @click="smcbSelect($event)">
                        <span class="text">
                                            三室
                                        </span>
                        <div class="checkbox checkbox-sm">
                            <span class="check"></span>
                        </div>
                    </li>
                    <li data-dianji="room/四室" @click="smcbSelect($event)">
                        <span class="text">
                                            四室
                                        </span>
                        <div class="checkbox checkbox-sm">
                            <span class="check"></span>
                        </div>
                    </li>
                    <li data-dianji="room/五室" @click="smcbSelect($event)">
                        <span class="text">
                                            五室
                                        </span>
                        <div class="checkbox checkbox-sm">
                            <span class="check"></span>
                        </div>
                    </li>
                    <li data-dianji="room/五室以上" @click="smcbSelect($event)">
                        <span class="text">
                                            五室以上
                                        </span>
                        <div class="checkbox checkbox-sm">
                            <span class="check"></span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="more-box" @mouseenter="over('more')" @mouseleave="out('more')">
                <a href="javascript:;" class="filter more " :class="{'expand':expand=='more'}">
                                    <span>更多</span>
                                    <i class="fa fa-sort-desc" aria-hidden="true"></i>                        
                                </a>
            </div>
            <div class="condition-box slide-transition" style="display:none;" v-show="subFlag=='more'" @mouseenter="subOver('more')"
                @mouseleave="subOut('more')">
                <div class="condition-row">
                    <div class="condition-title">
                        <span>物业类型</span>

                    </div>
                    <div class="condition-colon">：</div>
                    <div class="condition-body">
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">住宅</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">别墅</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">商业</span>
                        </div>
                    </div>
                </div>
                <div class="condition-row">
                    <div class="condition-title">
                        <span>售卖状态</span>

                    </div>
                    <div class="condition-colon">：</div>
                    <div class="condition-body">
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">在售</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">待售</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">尾盘</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">售完</span>
                        </div>
                    </div>
                </div>

                <div class="condition-row">
                    <div class="condition-title">
                        <span>环</span>
                        <span>线</span>
                    </div>
                    <div class="condition-colon">：</div>
                    <div class="condition-body">
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">内环内</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">内中环</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">中外环</span>
                        </div>
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">外环外</span>
                        </div>
                    </div>
                </div>

                <div class="condition-row">
                    <div class="condition-title">
                        <span>特</span>
                        <span>色</span>

                    </div>
                    <div class="condition-colon">：</div>
                    <div class="condition-body">
                        <div class="condition-item" @click="cbSelect($event)">
                            <div class="checkbox checkbox-lg">
                                <span class="check"></span>
                            </div>
                            <span class="condition-txt">独栋</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="login-register">
                <i class="fa fa-user" aria-hidden="true"></i>
                <div class="typeUserInfo">
                    <div class="no-login">
                        <a class="login login-user-btn btn-login ">登录</a> |
                        <a href="//passport.lianjia.com/register/resources/lianjia/register.html?service=http%3A%2F%2Fsh.fang.lianjia.com" target="_blank"
                            class="register">注册</a>
                    </div>
                    <div class="logged" style="display: none;">
                        <a class="user-name" href="http://user.sh.lianjia.com"></a>
                        <a href="http://user.sh.lianjia.com/locallogout?service=//sh.fang.lianjia.com/ditu" class="">退出</a>
                    </div>
                </div>
            </div>
            <a class="go-to-list"><i class="fa fa-list-ul" aria-hidden="true"></i>列表找房</a>
        </div>
        <div id="allmap" class="content"></div>
        <div class="expander fadeOut" @click="expander()">
        </div>
        <div class="list-container">
            <div class="overlay" style="display: none;"></div>
            <div class="list-header">
                <span class="total-count">共找到<em>316</em>个楼盘</span>
                <span class="sort" data-dianji="time/排序">开盘时间<i class="fa fa-arrow-down" aria-hidden="true"></i></span>
                <span class="sort" data-dianji="price/排序">价格<i class="fa fa-arrow-up" aria-hidden="true"></i></span>
                <span class="sort on" data-dianji="default/排序">默认</span>
            </div>
            <div class="item-wrap" style="overflow-x:hidden;overflow-y:auto;">
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="1617">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20170621/b0af0702-334f-4bdf-ae2f-1c96416a71ac.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/lujinsheshanyuanzibs/">路劲佘山院子（别墅）</a>
                                    </span>
                            <span class="villa-name">别墅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注路劲佘山院子（别墅）"></i>
                        </div>
                        <div><span>121-142m²</span> <span class="price">666万/套起</span></div>
                        <div><span>别墅户型</span></div>
                        <div><span>松江-松江松江崇南公路599弄</span></div>
                    </div>
                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="1474">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20170615/25f57378-5d9c-4340-b8ac-ca3f2108883f.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/xiangyitiandi/">香溢花城</a>
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注香溢花城"></i>
                        </div>
                        <div><span>147-198m²</span> <span class="price">105000元/m²</span></div>
                        <div><span>3室/4室</span></div>
                        <div><span>普陀-石泉东路168弄</span></div>
                    </div>
                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="1616">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20170621/489ecab2-10ef-4f37-8074-dc2a50b7d920.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/lujinsheshanyuanzi/">路劲佘山院子</a>
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注路劲佘山院子"></i>
                        </div>
                        <div><span>70-89m²</span> <span class="price">39000元/m²</span></div>
                        <div><span>2室/3室</span></div>
                        <div><span>松江-松江松江崇南公路599弄</span></div>
                    </div>
                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="349">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20160714/f4bfb6bd-ce65-4fd9-bcf3-19357581705f.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/shanghaivillabs/">上海villa</a>
                                    </span>
                            <span class="villa-name">别墅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注上海villa"></i>
                        </div>
                        <div><span>128-145m²</span> <span class="price">490万/套起</span></div>
                        <div><span>别墅户型</span></div>
                        <div><span>嘉定-恒荣路589弄</span></div>
                    </div>
                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="1618">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20170626/3e20470c-a190-4a38-a8b5-77a8e972f1d7.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/yuzhoufu/">禹洲府</a>
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注禹洲府"></i>
                        </div>
                        <div><span>77-89m²</span> <span class="price">46600元/m²</span></div>
                        <div><span>2室/3室</span></div>
                        <div><span>闵行-富国路银春路交汇处</span></div>
                    </div>
                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="1253">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20160908/8f85dadb-7093-448e-94da-bcfd66fb8083.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/jindishijia/">金地世家</a>
                
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注金地世家"></i>
                        </div>
                        <div><span>90-139m²</span> <span class="price">43000元/m²</span></div>
                        <div><span>3室/4室</span></div>
                        <div><span>嘉定-合作路199弄</span></div>
                    </div>

                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="1268">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20170414/ef70e66c-1f7e-4cef-a85e-4262aee1a734.png">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/biyunyilingbs/">碧云壹零（别墅）</a>
                
                                    </span>
                            <span class="villa-name">别墅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注碧云壹零（别墅）"></i>
                        </div>
                        <div><span>240-253m²</span> <span class="price">672万/套起</span></div>
                        <div><span>别墅户型</span></div>
                        <div><span>浦东-竹柏路758弄</span></div>
                    </div>

                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="73">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20160913/0c8e5dce-1397-4765-942f-a5346d5000ad.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/mingtianhuachengerqi/">明天华城</a>
                
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注明天华城"></i>
                        </div>
                        <div><span>67-149m²</span> <span class="price">54000元/m²</span></div>
                        <div><span>1室/2室/3室</span></div>
                        <div><span>浦东-繁荣路161号</span></div>
                    </div>

                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="127">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20161227/845cc727-7ae9-4b96-8030-5fc29697814b.png">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/zhengrongguolingbs/">正荣国领（别墅）</a>
                
                                    </span>
                            <span class="villa-name">别墅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注正荣国领（别墅）"></i>
                        </div>
                        <div><span>115-360m²</span> <span class="price">570万/套起</span></div>
                        <div><span>别墅户型</span></div>
                        <div><span>宝山-抚远路1211号</span></div>
                    </div>

                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="160">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20160712/4a55c54a-18e9-47c4-924d-29b0f0744c40.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/hongqiaozhengrongfu/">虹桥正荣府</a>
                
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注虹桥正荣府"></i>
                        </div>
                        <div><span>54-214m²</span> <span class="price">57000元/m²</span></div>
                        <div><span>1室/3室/4室</span></div>
                        <div><span>青浦-联民路100弄</span></div>
                    </div>

                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="390">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20161110/ac783bd5-68a8-43ce-9f61-29645efd6e92.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/jiabaomengzhiyuanjingting/">嘉宝梦之缘景庭</a>
                
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注嘉宝梦之缘景庭"></i>
                        </div>
                        <div><span>76-139m²</span> <span class="price">45000元/m²</span></div>
                        <div><span>1室/2室/3室</span></div>
                        <div><span>嘉定-云屏路1051号（宝塔路与云屏路交汇口）</span></div>
                    </div>

                    <hr>
                </div>
                <div class="list-item" @click="showDetail()" data-dianji="go-to-detail" data-id="768">
                    <img alt="" onerror="this.src='http://sh.lianjia.com/static/img/new-version/default_block.png';this.onerror=null;" src="http://cdn1.dooioo.com/fetch/vp/gimg/300x225/20160816/085ded40-9b71-47e4-af14-43842ac43132.jpg">
                    <div class="right-info">
                        <div>
                            <span class="title">
                                        <a target="_blank" href="/detail/yuanchangxingfuli/">源昌幸福里</a>
                
                                    </span>
                            <span class="villa-name">住宅</span>
                            <span class="sale-status" data-status="在售">在售</span>
                            <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注源昌幸福里"></i>
                        </div>
                        <div><span>80-138m²</span> <span class="price">42500元/m²</span></div>
                        <div><span>2室/3室/4室</span></div>
                        <div><span>青浦-崧泉路782号</span></div>
                    </div>

                    <hr>
                </div>
            </div>
        </div>
        <div class="detail" style="display:none;overflow:hidden;">
            <div class="imgBox">
                <img src="img/bigPic.jpeg" style="width:40rem;height:100%;vertical-align:top;">
            </div>
            <div class="houseInfo" style="margin: 0.3rem 0.85rem;">
                <span class="title" style="font-weight:bolder;font-size:0.9rem;">
                    <a target="_blank" href="/detail/lujinsheshanyuanzibs/">路劲佘山院子（别墅）</a>
                </span>
                <span class="villa-name">别墅</span><span class="sale-status" data-status="在售">在售</span>
                <i class="iconfont favor-icon" style="display: none;" data-dianji="favor/关注路劲佘山院子（别墅）"></i>
                <div class="inlineText"><span><span class="tag">住房面积：</span><span>121-142m²</span></span><span class="afterSpan"><span class="tag">户型介绍：</span><span>别墅户型</span></span>
                </div>
                <div class="inlineText"><span><span class="tag">销售总价：</span><span class="price">666万/套起</span></span><span class="afterSpan"><span class="tag">地址：</span><span>松江-松江松江崇南公路599弄</span></span>
                </div>
            </div>
        </div>
</body>
<script src="https://unpkg.com/vue"></script>
<script src="js/index.js"></script>

</html>