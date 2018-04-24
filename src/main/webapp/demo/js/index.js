	var markerClusterer;
	var ComplexCustomOverlay;
	var _level;
	var _key;
	var _cacheKey;
	var _currentLevel;
	var _nextLevel;
	var _ids;
	var divIdIndex = 0;
	var viewer ;
	var hasSelect = false;
	$(document).ready(function() { 
//		console.log(vm.cascaderData);
		// 百度地图API功能
		$('#autoShowList').trigger("click");
		initMap();
    	//===================
		
        $('body').addClass('loaded');
        
    	getObjectList();//加载项目数据
    	getObjectDetail();//加载项目筛选条件数据
    	initProjectMarker();//初始加载地图数据
    	$('#loader-wrapper .load_title').remove();
    	
//    	$('img').each(function() {
//            if (!this.complete || typeof this.naturalWidth == "undefined" || this.naturalWidth == 0) {
//                this.src = 'images/01.jpg';
//            }
//        });
    	//自定义覆盖物*************************************
        ComplexCustomOverlay = function(point, text, mouseoverText,showcolor,overcolor){
          this._point = point;
          this._text = text;
          this._overText = mouseoverText;
          this._showcolor=showcolor;
          this._overcolor=overcolor;
        }
        ComplexCustomOverlay.prototype = new BMap.Overlay();
        ComplexCustomOverlay.prototype.initialize = function(map){
          this._map = map;
          var div = this._div = document.createElement("div");
          div.id = "_creatdivid"+divIdIndex;
          div.style.borderRadius="4px";
          div.style.boxShadow="1px 1px 2px 1px rgba(0, 0, 0, 0.24)";
          div.style.background=this._showcolor;
          div.style.border="1px solid #ffffff";
          
          div.style.position = "absolute";
          div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
          div.style.color = "white";
          div.style.padding = "2px";
          div.style.lineHeight = "25px";
          div.style.whiteSpace = "nowrap";
          div.style.MozUserSelect = "none";
          div.style.fontSize = "15px"
          var span = this._span = document.createElement("span");
          div.appendChild(span);
          span.appendChild(document.createTextNode(this._text));      
          var that = this;
          var arrow = this._arrow = document.createElement("div");
          arrow.style.display="block";
          arrow.style.borderWidth="5px";
          arrow.style.position="absolute";
          arrow.style.bottom= "-10px";
          arrow.style.left= "10px";
          arrow.style.borderStyle= "solid dashed dashed";
          arrow.style.borderColor= this._showcolor+" transparent transparent";
          arrow.style.fontSize= 0;
          arrow.style.lineHeight= 0;
          
          div.appendChild(arrow);
         
          div.onmouseover = function(){
        	this.style.zIndex = 100;
        	this.style.cursor = "pointer";
            this.style.backgroundColor = that._overcolor;
            arrow.style.borderColor= that._overcolor+" transparent transparent";
            this.getElementsByTagName("span")[0].innerHTML = that._overText;
          }

          div.onmouseout = function(){
        	this.style.zIndex = BMap.Overlay.getZIndex(that._point.lat);
            this.style.background = that._showcolor;
            this.getElementsByTagName("span")[0].innerHTML = that._text;
            arrow.style.borderColor= that._showcolor+" transparent transparent";
          }

          map.getPanes().labelPane.appendChild(div);
          
          return div;
        }
        ComplexCustomOverlay.prototype.draw = function(){
          var map = this._map;
          var pixel = map.pointToOverlayPixel(this._point);
          this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
          this._div.style.top  = pixel.y - 30 + "px";
        }
        //添加监听事件  
        ComplexCustomOverlay.prototype.addEventListener = function(event,fun){  
            this._div['on'+event] = fun;  
        }
    	//自定义覆盖物*************************************
    	
        $(".go-to-list").click(function(){
//            layer.open({
//                type: 1,
//                title: false,
//                closeBtn: 0,
//                area: ['20rem', '20rem'],
//                shadeClose: true,
//                scrollbar: false, 
//                content: '<div><img src="../demo/img/20180116230158.png" width="100%" height="100%"/></div>'
//            });
        	window.location= path+"/demo/app/gisapp.apk";
//        	$(".modal-suspend").show();
//        	$("#imgbox").show(300);
//        	var w = $("#imgbox").width();
//        	var h = $("#imgbox img").height();
//        	layer.open({
//    	        type: 1,
//    	        title: false,
//    	        closeBtn: 0,
//    	        skin:'touming',
//    	        area: [w,h],
//    	        shadeClose: true,
//    	        scrollbar: false, 
//    	        content: $("#imgbox")
//    	    });
        	
        	
        });
        var tipindex;
        $(".go-to-list").mouseenter(function(){
        	tipindex = layer.tips('<div><img src="../demo/img/qrcode.png" width="100%" height="100%"/></div>', this,{
        		  tips: [3, '#fff'],
        		  time: 500000
        	});
//        	layer.open({
//        		type: 1,
//        		title: false,
//        		closeBtn: 0,
//        		area: ['20rem', '20rem'],
//        		shadeClose: true,
//        		scrollbar: false, 
//        		content: '<div><img src="../demo/img/20180116215105.png" width="100%" height="100%"/></div>'
//        	});
        });
        $(".go-to-list").mouseleave (function(){
        	layer.close(tipindex);
        });
     
//        $(".item-wrap").scroll(function(){
//            var $this =$(this),
//            viewH =$(this).height(),//可见高度
//            contentH =$(this).get(0).scrollHeight,//内容高度
//            scrollTop =$(this).scrollTop();//滚动高度
//           if(contentH - viewH - scrollTop <= 100) { //到达底部100px时,加载新内容
////           if(scrollTop/(contentH -viewH)>=0.95){ //到达底部100px时,加载新内容
////        	   alert(123123);
//        	   showNextPageInfo();
//           }
//        });
        
    }); 
	
	function projectClk(projectId){
		vm.subFlag = 0;
		vm.expand = 0;
		
		if(projectId){
			getMapInfoByProjectId(projectId);
		}else{
			initProjectMarker();
		}
	}
	
	/**
	 * 根据项目ID获取地图信息
	 */
	function getMapInfoByProjectId(projectId){
		$.post(path+"/webctrl/getMapInfoByUserRoleAndProjectId/", 
		{
			projectId:projectId
		},
		function(result){
			if(result.success == true){//登陆成功
				var data = result.data;
				generateMarker(data,11);
			}else {
			}
		},'json');
	}
	
	function initProjectMarker(){
		$.post(path+"/webctrl/getMapInfoByUserRole/", 
		{
		},
		function(result){
			if(result.success == true){//登陆成功
				var data = result.data;
//				generateCluster(data);
				generateMarker(data,11);
			}else {
			}
		},'json');
	}
	var overlays = new Array();
	function generateMarker(array,level){
		if(level == 11){
			cachezoom = 11;
		}
		for(var k in overlays){
			map.removeOverlay(overlays[k]);
		}
    	var pt = null;
    	var k = 0;
    	_level = level;
    	for (var i in array) {
    		pt = new BMap.Point(array[i].longitude , array[i].latitude);
//    	   var marker = new BMap.Marker(pt);
    	   var mouseoverTxt = array[i].text + " 共" + array[i].totalitem + "条问题点" ;
//    	   var tcolor = "rgba(0,153,51, 0.9)";
    	   var tcolor = "rgba(35,174,244, 0.9)";
    	   if(array[i].color){
    		   tcolor = array[i].color;
    	   }
    	   if(k == 0){
				map.centerAndZoom(pt, level);
				/*
				if(array[i].nextLevel){
					map.centerAndZoom(pt, level);
				}else{
					map.centerAndZoom(pt, 18);
				}
				*/
			}
    	   var myCompOverlay = new ComplexCustomOverlay(pt, array[i].text,mouseoverTxt,tcolor,"rgba(254,116,66, 0.8)");
    	   divIdIndex++;
    	   map.addOverlay(myCompOverlay);
    	   overlays.push(myCompOverlay);
//    	   marker.tkey = array[i].key;
    	   (function() {  
   		    	var key = array[i].key;
	       		var cacheKey = array[i].cacheKey;
	       		var currentLevel = array[i].currentLevel;
	       		var nextLevel = array[i].nextLevel;
	       		var ids = array[i].ids;
	       		myCompOverlay.addEventListener("click", function(){
	       			if(currentLevel < '7'){
	       				$(".item-wrap").empty();
	       				$('#finditemlength').html(0);
	       				if ($('.expander').hasClass("fadeOut")) {
	       					$('#autoShowList').trigger("click");
	       				}
	       				showNextLevel(level,key,cacheKey,currentLevel,nextLevel,ids);
	       			}else{
	       				if ($('.expander').hasClass("fadeIn")) {
	       					$('#autoShowList').trigger("click");
	       				}
	       				showInfo(ids);
	       			}
	       		});
          })();
    	   k++;
    	}
	}
	
	function showNextLevel(level,key,cacheKey,currentLevel,nextLevel,ids){
		if(key)
			_key = key;
		if(cacheKey)
			_cacheKey = cacheKey;
		if(currentLevel)
			_currentLevel = currentLevel;
		if(nextLevel)
			_nextLevel = nextLevel;
		if(ids)
			_ids = ids;
		$.post(path+"/webctrl/getNextMapInfoByKey/", 
		{
			key:key,
			cacheKey:cacheKey,
			currentLevel:currentLevel,
			nextLevel:nextLevel
		},
		function(result){
			if(result.success == true){
				var data = result.data;
				if(cachezoom != 19){
					cachezoom = cachezoom + 1;
				}
				generateMarker(data,level + 1);
			}else {
				 
			}
		},'json');
	}
	function showPreLevel(level,key,cacheKey,currentLevel){
		_level = level-1;
		$.post(path+"/webctrl/getPreMapInfoByKey/", 
		{
			key:key,
			cacheKey:cacheKey,
			currentLevel:currentLevel
		},
		function(result){
			if(result.success == true){
				var data = result.data;
				if(data){
					_key = data[0].preKey;
					if(!_key){
						if ($('.expander').hasClass("fadeOut")) {
							$('#autoShowList').trigger("click");
						}
						$(".item-wrap").empty();
						$('#finditemlength').html(0);
					}
					_currentLevel = data[0].preLevel;
					if(_currentLevel == 0){
						if(!hasSelect){
							initProjectMarker();
						}else{
							getMapInfoBySelectDetail();
						}
					}else{
						generateMarker(data,level-1);
						var ids ="";
						for (var i in data) {
							ids = ids + data[i].ids+",";
						}
						showInfo(ids);
					}
				}
			}else {
				
			}
		},'json');
	}
    
	function getObjectList(){
		$.post(path+"/webctrl/getObjectListByUserRole/", 
		{
		},
		function(result){
			if(result.success == true){
				var kk = 0;
				$.each(result.data, function (index, obj) {
					if(kk == 0){
						document.title = obj.menu_name;
					}
					kk++;
	               var lis = "";
	               trs = "<li id=\""+obj.id+"\" onclick=\"projectClk(this.id)\"><span class=\"text\">"+obj.menu_name+"&nbsp;&nbsp;</span></li>";
	               $(".first-info-list").append(trs);
	           });
			}else {
				window.location.href="login.jsp"; 
			}
		},'json');
	}
	function getObjectDetail(){
		$.post(path+"/webctrl/getObjectDetail/", 
		{
		},
		function(result){
			if(result.success == true){//登陆成功
				vm.cascaderData = result.data;
			}else {
				 
			}
		},'json');
	}
	function initCluster(){
		$.post(path+"/webctrl/getMapInfoByUserRole/", 
		{
		},
		function(result){
			if(result.success == true){//登陆成功
				//TODO 解析坐标点到地图上
				var data = result.data;
				generateCluster(data);
			}else {
			}
		},'json');
	}
	
	function generateCluster(array){
    	var markers = [];
    	var pt = null;
    	var k =0;
    	for (var i in array) {
			if(k == 0){
				map.centerAndZoom(new BMap.Point(array[i].longitude , array[i].latitude), 11);
			}
    	   pt = new BMap.Point(array[i].longitude , array[i].latitude);
    	   var marker = new BMap.Marker(pt);
    	   marker.tid = array[i].id;
    	   marker.addEventListener("click", showInfo)
    	   markers.push(marker);
    	   k++;
    	}
    	markerClusterer.clearMarkers();
    	markerClusterer.addMarkers(markers) 
	}
	
	
	
	
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
	    {"input" : "suggestId"
	    ,"location" : map
	    ,"onSearchComplete" : function(e) {
	    	//console.log(e);
	    }
	});
	
	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
	var str = "";
	var _value = e.fromitem.value;
	var value = "";
	if (e.fromitem.index > -1) {
	        value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
	    }    
	    str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
	
	    value = "";
	if (e.toitem.index > -1) {
	        _value = e.toitem.value;
	        value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
	    }    
	    str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
	    //G("searchResultPanel").innerHTML = str;
	});
	
	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
	var _value = e.item.value;
	    myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
	    setPlace(myValue);
	});
	
	var myGeo = new BMap.Geocoder();// 将地址解析结果显示在地图上,并调整地图视野
	function setPlace(detailAddress){// 创建地址解析器实例
		myGeo.getPoint(detailAddress, function(point){
			if (point) {
			    map.centerAndZoom(point, 11);
			    //map.addOverlay(new BMap.Marker(point));
			}else{
				alert("没有查询到相关信息");
			}
		}, "上海");
	}
	
	function searchPlace(){
		var input = $("#suggestId").val();
		setPlace(input);
	}
	
	var cachezoom = 11;
	function initMap(){
		map = new BMap.Map("allmap",{enableMapClick:false});    // 创建Map实例
    	map.centerAndZoom(new BMap.Point(121.47, 31.23), 11);  // 初始化地图,设置中心点坐标和地图级别
    	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    	map.addControl(new BMap.NavigationControl({enableGeolocation:true}));
    	map.addControl(new BMap.OverviewMapControl());
    	map.setCurrentCity("上海");          // 设置地图显示的城市 此项是必须设置的
    	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    	
//    	map.setMapType(BMAP_HYBRID_MAP);
//    	map.setMapStyle({style:'grayscale'});//灰度地图
    	
    	
    	map.addEventListener("zoomend", function(){//监听地图放大缩小事件
    		var currentzoom = this.getZoom()
    		var change = cachezoom - currentzoom;
			if(change > 0){//地图缩小
	    		cachezoom = currentzoom;
				turnback();
				if ($('.expander').hasClass("fadeOut")) {
					$('#autoShowList').trigger("click");
				}
				/*
				var times = parseInt(change/2);
				if(times > 0){
					cachezoom = currentzoom;
				}
				for(var i=0;i<times;i++){
					turnback();
				}
				if(times >=1){
					if ($('.expander').hasClass("fadeOut")) {
						$('#autoShowList').trigger("click");
					}
				}
				*/
			}else{//地图，不下钻
			}
			if(currentzoom == 11){
				cachezoom == currentzoom;
			}
    	});
    	
    	
    	/* 
    	 * 下面是markerclusterer逻辑
    	var markers = [];
    	//生成一个marker数组，然后调用markerClusterer类即可。
    	markerClusterer = new BMapLib.MarkerClusterer(map,
    		{
    			markers:markers,
    			girdSize : 100,
    			styles : [{
    	            url:'./img/blue.png',
    	            size: new BMap.Size(92, 92),
    	        	textColor: '#fff',  //文字颜色
    	        	textSize: 20,  //字体大小
    				backgroundColor : '#E64B4E'
    			}],
    		});
    	markerClusterer.setMaxZoom(11);
    	markerClusterer.setGridSize(100);
    	*/
	}



var vm = new Vue({
    el: '#myContainer',
    data: {
        resultFlag: false,
        subFlag: 0,
        mainFlag: 0,
        selected: 1,
        expand: 0,
        cascaderStatus:false,//三级联动的开关
        firstIndex:'',//一级的坐标
        secondIndex:'',//二级的坐标
        show:false,
        selectedIndex:[],//最终结果的数组
      //三级联动数据
        cascaderData:[]
        
    },
    mounted() {
    	
	},
    methods: {
    	//地图操作
    	
    	//三级菜单关联操作
    	cascadeClose :function(){//联动关闭
//    		console.log(JSON.stringify(this.cascaderData));
    		//loading层
//    		var layindex = layer.load(1, {
//    		  shade: [0.8,'#fff'] //0.1透明度的白色背景
//    		});
    		getMapInfoBySelectDetail();
    		/*
    		var jsonparam = JSON.stringify(this.cascaderData);
            this.cascaderStatus = false;
            this.firstIndex = '';
            this.secondIndex = '';
            $.post(path+"/webctrl/getMapInfo/", 
    		{
            	jsonIds:jsonparam
    		},
    		function(result){
//    			console.log(result);
    			if(result.success == true){//登陆成功
    				//TODO 解析坐标点到地图上
    				var data = result.data;
//    				initMap();
//    				generateCluster(data);
    				generateMarker(data,11);
    				layer.close(layindex); 
    			}else {
    			}
    		},'json');
            */
        },
        
        cascadeOpen: function(){//联动打开
            this.cascaderStatus = true;
        },
        
        firstOver :function(item,index){//选择第一级菜单
            this.firstIndex = index
            this.cascaderData[this.firstIndex].children.map((v)=>{
            	$.each(this.selectedIndex, function(idx, obj) {
            	    if(obj.id == v.id){
            	    	v.status = true;
            	    }
            	});
            })
            if(this.secondIndex!==''){
                this.secondIndex=''
            }
        },
        
        secondOver :function(item,index){//选择第二级菜单
            //this.selectedIndex = []
            if(this.secondIndex!==''&&this.firstIndex!==''){
                this.cascaderData[this.firstIndex].children[index].children.map((v)=>{
                	$.each(this.selectedIndex, function(idx, obj) {
                	    if(obj.id == v.id){
                	    	v.status = true;
                	    }
                	});
                })
            }
            
            this.secondIndex = index
            // this.cascaderData[firstIndex].children[index].map((v)=>{
            //     console.log(v)
            // })
        },
         
        firstClick :function(item,index){//选择第一级菜单
        	if(item.status){
        		item.status = false
        		this.selectedIndex.map((v,i)=>{
        			if(v.id==item.id){
        				this.selectedIndex.splice(i,1)
        			}
        		});
        		this.cascaderData[index].children.map((v,i)=>{
        			v.status = false;
        			this.selectedIndex.map((vs,i)=>{
            			if(v.id==vs.id){
            				this.selectedIndex.splice(i,1)
            			}
            		});
        			this.cascaderData[index].children[i].children.map((vv)=>{
        				vv.status = false;
        				this.selectedIndex.map((vss,ii)=>{
                			if(vv.id==vss.id){
                				this.selectedIndex.splice(ii,1)
                			}
                		});
        			});
                })
        	}else{
        		this.selectedIndex.push(item)
        		item.status = true
        		//设置子集为选中
        		this.cascaderData[index].children.map((v)=>{
        			v.status = true;
//        			this.selectedIndex.push(v)
        			$.each(v.children, function(idx, obj) {
        				obj.status = true;
//        				this.selectedIndex.push(obj)
                	});
                })
        	}
        },
        
        secondClick :function(item,index){//选择第二级菜单
        	//this.selectedIndex = []
        	if(item.status){
        		item.status = false;
        		this.selectedIndex.map((v,i)=>{
        			if(v.id==item.id){
        				this.selectedIndex.splice(i,1)
        			}
        		});
        		this.cascaderData[this.firstIndex].children[index].children.map((v)=>{
        			v.status = false;
        			this.selectedIndex.map((vs,i)=>{
            			if(v.id==vs.id){
            				this.selectedIndex.splice(i,1)
            			}
            		});
                })
        		
        	}else{
        		this.selectedIndex.push(item)
        		item.status = true
        		this.cascaderData[this.firstIndex].children[index].children.map((v)=>{
        			v.status = true;
//        			this.selectedIndex.push(v)
                })
                this.cascaderData[this.firstIndex].status = true;
        	}
        },
        
        thirdClick :function(item,index){//选择第三级菜单
        	if(item.status){   
        		item.status = false
        		this.selectedIndex.map((v,i)=>{
        			if(v.id==item.id){
        				this.selectedIndex.splice(i,1);
        			}
        		})
        	}else{
        		this.selectedIndex.push(item);
        		item.status = true;
        		this.cascaderData[this.firstIndex].children[this.secondIndex].status = true;
        		this.cascaderData[this.firstIndex].status = true;
        	}
        },
         
        out: function (current) {
            setTimeout(() => {
                if (this.mainFlag == 1) {
                    this.subFlag = 0;
                    this.mainFlag = 0;
                    this.expand = 0;
                }
            }, 300);
        },
        over: function (current) {
            this.selected = 1;
            this.mainFlag = 1;
            this.subFlag = current;
            this.expand = current;
        },
        subOver: function (current) {
            this.mainFlag = 0;
            this.subFlag = current;
        },
        subOut: function (current) {
            this.subFlag = 0;
            this.expand = 0;
        },
        cbSelect: function(e) {
            var that = $(e.target).parent('.condition-item');
            if(that.hasClass('selected')){
                that.removeClass('selected');
            }else{
                that.addClass('selected');
            }
        },
        smcbSelect: function(e) {
            var that = $(e.target).parent('li');
            if(that.hasClass('selected')){
                that.removeClass('selected');
            }else{
                that.addClass('selected');
            }
        },
        expander: function(){
            if ($('.expander').hasClass("fadeIn")) {
                $('.content').css("width", "73%");
                $('.expander').css("right", "26.2%");
                $('.expander').css("background",
                    "url('img/map-expander.png') 100% 0% no-repeat");
                $('.expander').removeClass("fadeIn");
                $('.expander').addClass("fadeOut");
            } else {
                $('.content').css("width", "100%");
                $('.expander').css("right", "0");
                $('.expander').css("background",
                    "url('img/map-expander.png') 35% 0% no-repeat");
                $('.expander').removeClass("fadeOut");
                $('.expander').addClass("fadeIn");
            }
        }
        
    }
})

function getMapInfoBySelectDetail(){
	hasSelect = true;
	var layindex = layer.load(1, {
	  shade: [0.8,'#fff'] //0.1透明度的白色背景
	});
	var jsonparam = JSON.stringify(vm.cascaderData);
	vm.cascaderStatus = false;
	vm.firstIndex = '';
	vm.secondIndex = '';
    $.post(path+"/webctrl/getMapInfo/", 
	{
    	jsonIds:jsonparam
	},
	function(result){
//		console.log(result);
		if(result.success == true){//登陆成功
			//TODO 解析坐标点到地图上
			var data = result.data;
//			initMap();
//			generateCluster(data);
			generateMarker(data,11);
			layer.close(layindex); 
		}else {
		}
	},'json');
}

/*
function showDetail(title,subhead,imgSrc,detail1,detail2,detail3,detail4,detail5,detail6){
	$("#detailimg").attr("src",imgSrc);
	$("#detailtitle").html(title);
	$("#detailsubhead").html(subhead);
	if("null：null" != detail1 && "undefined：undefined"!= detail1){
		$("#detailitem1").html(detail1);
	}
	if("null：null" != detail2 && "undefined：undefined"!= detail2){
		$("#detailitem2").html(detail2);
	}
	if("null：null" != detail3 && "undefined：undefined"!= detail3){
		$("#detailitem3").html(detail3);
	}
	if("null：null" != detail4 && "undefined：undefined"!= detail4){
		$("#detailitem4").html(detail4);
	}
	if("null：null" != detail5 && "undefined：undefined"!= detail5){
		$("#detailitem5").html(detail5);
	}
	if("null：null" != detail6&& "undefined：undefined"!= detail6){
		$("#detailitem6").html(detail6);
	}
//	$('#imgbox').removeClass("hide");
    layer.open({
        type: 1,
        title: false,
        closeBtn: 0,
        area: ['40rem', '32rem'],
        shadeClose: true,
        scrollbar: false, 
        content: $('#imgbox')
    });
}
*/

function showDetail(title,subhead,imgSrc,detail1,detail2,detail3,detail4,detail5,detail6){
	clearBoxImg();
	var htm = "<li class=\"feature\"><span class=\"label\"></span><span class=\"desc\">#detail</span></li>";
	$("#boximage").attr("src",imgSrc);
	$("#boximagehide").attr("src",imgSrc);
	$("#boximagehide").show();
	$("#download").attr("href",imgSrc);
	$("#download").attr("download",title+".jpg");
	
//	$("#boximage").load(function(){
//		console.log($(this).width());    
//		console.log($(this).width());    
//	});


	$(".box-title").html(title);
//	$("#detailsubhead").html(subhead);
	
	if("null：null" != detail1 && "undefined：undefined"!= detail1){
		$(".box-content").append(htm.replace("#detail", detail1));
	}
	if("null：null" != detail2 && "undefined：undefined"!= detail2){
		$(".box-content").append(htm.replace("#detail", detail2));
	}
	if("null：null" != detail3 && "undefined：undefined"!= detail3){
		$(".box-content").append(htm.replace("#detail", detail3));
	}
	if("null：null" != detail4 && "undefined：undefined"!= detail4){
		$(".box-content").append(htm.replace("#detail", detail4));
	}
	if("null：null" != detail5 && "undefined：undefined"!= detail5){
		$(".box-content").append(htm.replace("#detail", detail5));
	}
	if("null：null" != detail6&& "undefined：undefined"!= detail6){
		$(".box-content").append(htm.replace("#detail", detail6));
	}
	
	$("#boximagehide")[0].onload=function(){
		var that = this;
		console.log($(that)[0].offsetWidth);
		$(".imgbox").css("width", $(that)[0].offsetWidth);
		$("#boximagehide").hide();
		$(".modal-suspend").show();
		$("#imgbox").show(300);
		if($(".imgtext").is(":hidden")){
	          //当前是hide状态
			$(".imgtext").slideToggle(100);
	    }else{
	        //当前是show状态
	    }
	}
//	showImg();
//	document.getElementById('boximage').onload=function(){
//        // 加载完成 
//		console.log($(this));
//		console.log($(this)["0"].clientWidth);
//		
//		$(".imgbox").css("width", this.width);
//		$(".modal-suspend").show();
//		$("#imgbox").show(300);
//	};
}


var detailData = null;
var detailIndex = 0;

function showInfo(ids){
//	if ($('.expander').hasClass("fadeIn")) {
//		$('#autoShowList').trigger("click");
//	}
	$(".item-wrap").empty();
	$.post(path+"/webctrl/getCoordinateInfo/", 
	{
    	ids:ids
	},
	function(result){
		if(result.success == true){//登陆成功
			var data = result.data;
//			console.log(data);
			var itemlength =  data.length;
			if(itemlength){
				$('#finditemlength').html(itemlength);
			}
			detailData = data;
			foreachData(data,0);
//			viewer = new Viewer(document.getElementById('list-container-id'), {
//				url: 'data-original'
//			});
		}else {
		}
	},'json');
}

function showNextPageInfo(){
	if(detailData){
		if(detailData.length >= detailIndex+1){
//			$(".item-wrap").empty();
			foreachData(detailData,detailIndex);
		}
	}
}

function foreachData(curdata,curidx){
//	console.log();
	$(".item-wrap").children().last().remove();
	$.each(curdata, function (index, obj) {
		if(index >= curidx && index < curidx+10){
		   var htm = generateRightItem(obj.detail_1_value, 
				   '详情',
				   	basePath+'app/getImgBydetailId?id='+obj.id,
				   	basePath+'app/getImgBydetailId?id='+obj.id+"&type=thumb",
				   	obj.detail_2_key+"："+obj.detail_2_value,
				   	obj.detail_3_key+"："+obj.detail_3_value,
				   	obj.detail_4_key+"："+obj.detail_4_value,
				   	obj.detail_5_key+"："+obj.detail_5_value,
				   	obj.detail_6_key+"："+obj.detail_6_value,
				   	obj.detail_7_key+"："+obj.detail_7_value
				   	);
           $(".item-wrap").append(htm);
           detailIndex = index+1;
		}
		/*else{
		   detailIndex = index;
		   return false;
		}*/
    });
	var loadhtm = "";
	if(curdata.length <= curidx+10){
		loadhtm = "<div class=\"loadmore\" onClick=\"showNextPageInfo();\">已全部加载完毕</div>";
	}else{
		loadhtm = "<div class=\"loadmore\" onClick=\"showNextPageInfo();\">加载更多</div>";
	}
	$(".item-wrap").append(loadhtm);
	
//	viewer = new Viewer(document.getElementById('list-container-id'), {
//		url: 'data-original'
//	});
}

function generateRightItem(title,subhead,imgSrc,imgThumbSrc,detail1,detail2,detail3,detail4,detail5,detail6){
	var html = "";
	html += "<div class=\"list-item\" style='cursor: pointer;' onClick=\"showDetail('"+title+"','"+subhead+"','"+imgSrc
	+"','"+detail1+"','"+detail2+"','"+detail3+"','"+detail4+"','"+detail5+"','"+detail6+"')\" >";
	html += "	<img alt=\""+title+"\" class=\"nullclass\" onerror=\"this.src='./img/white1.png';this.onerror=null;\" data-original=\""+imgSrc+"\"	src=\""+imgThumbSrc+"\">";
	html += "	<div class=\"right-info\">";
	html += "		<div >";
	html += "			<span class=\"title\"> <a>"+title+"</a>";
	html += "			</span> <span class=\"villa-name\" >"+subhead+"</span>";
//	html += "			<span class=\"sale-status\" >正常</span>";
	html += "			<i class=\"iconfont favor-icon\" style=\"display: none;\"";
	html += "				data-dianji=\"favor/图片详情\"></i>";
	html += "		</div>";
	html += "		<div>";
	html += "			<span>"+detail1+"</span> <span class=\"price\"></span>";
	html += "		</div>";
	html += "		<div>";
	html += "			<span>"+detail2+"</span>";
	html += "		</div>";
	html += "		<div>";
	html += "			<span>"+detail3+"</span>";
	html += "		</div>";
	html += "	</div>";
	html += "	<hr>";
	html += "</div>";
	return html;
}


function turnback(){
//	console.log(vm.cascaderData);
	if(!_key){
		return null;
	}else{
//		console.log("_currentLevel="+_currentLevel);
		if(_currentLevel >1){
			showPreLevel(_level, _key, _cacheKey, _currentLevel);
		}else{//返回到第一级时，改为初始化
			if(!hasSelect){
				initProjectMarker();
			}else{
				getMapInfoBySelectDetail();
			}
		}
	}
}


function changelabel(e){
	e.stopPropagation;
}


function showImg(w){
	const width = $(".imgbox img").width();
//	console.log(w);
	$(".imgbox").css("width", width);
	$(".modal-suspend").show();
	$("#imgbox").show(300);
}
function hideImg(){
	$(".modal-suspend").hide();
	$("#imgbox").hide(300);
}

function clearBoxImg(){
	$("#boximage").attr("src","");
	$(".box-title").html("");
	$(".box-content").empty();
}