    Ext.QuickTips.init();
    var _cob;
   	Ext.onReady(function(){
   		Ext.override(Ext.menu.DateMenu, {  
   		    render : function() {  
   		        Ext.menu.DateMenu.superclass.render.call(this);  
   		        if (Ext.isGecko || Ext.isSafari || Ext.isChrome) {  
   		            this.picker.el.dom.childNodes[0].style.width = '178px';  
   		            this.picker.el.dom.style.width = '178px';  
   		        }  
   		    }  
   		}); 
   		
   		var qrUrl = path + "/operate/";
   		var order;
        store = new Ext.data.Store({
			url : qrUrl+"list/",
			reader : new Ext.data.JsonReader({
				root : 'products',
				totalProperty : 'totalCount',
				id : 'querydate',
				fields : [
					{name:  'operateUserId'},
					{name : 'opereteTypeId'},
					{name : 'createTime'},
					{name : 'operateUserIp'},
					{name : 'isSuccess'},
					{name : 'operateSummary'},
					{name : 'id'}
				]
			})//,
//			remoteSort : true
		});
		store.load({params:{start:0,limit:100}});
        
        var column=new Ext.grid.ColumnModel( 
            [ 
            	new Ext.grid.RowNumberer(),
            	{header:"操作用户名",align:'center',dataIndex:"operateUserId",sortable:true}, 
            	{header:"操作类型",align:'center',dataIndex:"opereteTypeId",sortable:true}, 
            	{header:"操作时间",align:'center',dataIndex:"createTime",sortable:true}, 
	            {header:"操作结果",align:'center',dataIndex:"isSuccess",sortable:true,renderer:function(value, cellmeta, record, rowIndex, columnIndex, store){    
                    if(value=='0'){
                        return '失败';
                      } else {
                        return '成功';
                      }
	            }},
//	            {header:"操作用户IP",align:'center',dataIndex:"operateUserIp",sortable:true},
	            {header:"操作详情",align:'center',dataIndex:"id",renderer: function (value, meta, record) {
	            	var msg = 	(record.get('operateSummary')+'').replace(/\'/g,  '\\\'').replace(/\"/g,"“");
	            	;
	            	var resultStr = "";
	            	
        			var formatStr = "<input id = 'bt_edit_" + record.get('id')
					+ "'onclick=\"showErrInfo('" + 
					msg
					+ "');\" type='button' value='查看' width ='15px'/>&nbsp;&nbsp;"; 
        			
        			if(record.get('opereteTypeId') == '导入项目图片数据'){
	        			var downloadExcel = "<input id = 'bt_downloadexcel_" + record.get('id')
	        			+ "'onclick=\"downloadExcel('" + 
	        			record.get('id')
	        			+ "');\" type='button' value='下载EXCEL' width ='15px'/>&nbsp;&nbsp;"; 
									            			
	    				resultStr = String.format(formatStr+downloadExcel);
        			}else{
        				resultStr = String.format(formatStr);
        			}
    				return "<div>" + resultStr + "</div>";
				  } .createDelegate(this)}
            ] 
        ); 
        
        var initDate = new Date();
    	initDate.setDate(1);
    	initDate.setHours(0, 0, 0, 0);
    	
    	var endTimeField = new ClearableDateTimeField({
    		id:"createDateEnd",
    		editable : false,
    		width : 160
    	});
    	
    	var beginTimeField = new ClearableDateTimeField({
    		id:"createDateStart",
    		editable : false,
//    		value : initDate,
    		width : 160
    		//fieldLabel : '创建时间',
    	}); 
    	this.beginTimeField = beginTimeField;
    	
    	this.endTimeField = endTimeField;
    	beginTimeField.on('change', function(o, v) {
    	});
    	beginTimeField.fireEvent('change', beginTimeField, initDate);
    	endTimeField.on('change', function(o, v) {
    	});
        
    	
    	var comstore = new Ext.data.SimpleStore({
    	    fields : ['value', 'text'],
    	    data : [['3', '全部'],['1', '前端'], ['2', 'APP'],['0', '后台']]
    	});
    	_cob = new Ext.form.ComboBox({
			id:'shUserRole',
			width:150,
			forceSelection: true,
			store:comstore,
			mode : 'local',
			valueField:'value',
			displayField:'text',
			typeAhead: true,
			triggerAction: 'all',
			selectOnFocus:true,//用户不能自己输入,只能选择列表中有的记录
			allowBlank:false,
			editable:false
		});
		_cob.setValue("全部");
    	
        var tbar = new Ext.Toolbar({  
            renderTo : Ext.grid.GridPanel.tbar,// 其中grid是上边创建的grid容器  
            items :['类型：',_cob,'操作用户名：', {
		  		  id : 'operateUser',
		  		  xtype : 'textfield',
		  		  width : 115
		  	}, '&nbsp;&nbsp;创建时间：',
		  	beginTimeField,'至',
		  	endTimeField,{
				text : '查询',
				iconCls : 'Magnifier',
				handler : function() {
					reloadData();
				}
			}, {
				text : '重置',
				iconCls : 'Reload',
				handler : function() {
					Ext.getCmp('operateUser').setValue("");
					Ext.getCmp('createDateStart').setValue("");
					Ext.getCmp('createDateEnd').setValue("");
				}
			}]

        });  
        var grid = new Ext.grid.EditorGridPanel({ 
			region:'center',
			border:false,
//			autoHeight:true,
			viewConfig: {
	            forceFit: true, //让grid的列自动填满grid的整个宽度，不用一列一列的设定宽度。
	            emptyText: '系统中还没有任务'
	        },
            cm:column, 
            store:store, 
            autoExpandColumn:0, 
            loadMask:true, 
            frame:true, 
            autoScroll:true, 
            tbar:tbar,
            bbar:new Ext.PagingToolbar({
					store : store,
					displayInfo : true,
					pageSize : 100,
					prependButtons : true,
					beforePageText : '第',
					afterPageText : '页，共{0}页',
					displayMsg : '第{0}到{1}条记录，共{2}条',
					emptyMsg : "没有记录"
				})
        });
        
	
      
  	var mainPanel = new Ext.Panel({
  		region:"center",
		layout:'border',
		border:false,
		items:[grid]
	});
	
   var viewport=new Ext.Viewport({
       //enableTabScroll:true,
       layout:"border",
       items:[
           mainPanel
   	   ]
   });
   });
   
   function reloadData(){
	    var beginTime = this.beginTimeField.getValue();
		var endTime = this.endTimeField.getValue();
		var type = _cob.getValue();
		if (!beginTime && !endTime) {
			var _bt = new Date();
			_bt.setDate(1);
			_bt.setHours(0, 0, 0, 0);
//			this.beginTimeField.setValue(_bt);
			beginTime = _bt;
		}
		if (beginTime && endTime) {
			if (beginTime.getTime() >= endTime.getTime()) {
				Ext.Msg.alert('提示', '创建开始时间不能晚于结束时间');
				return false;
			}
		}
		
		var userName = document.getElementById('operateUser').value ;
		store.baseParams['operateUser'] = userName;
		store.baseParams['createDateStart'] = beginTime;
		store.baseParams['createDateEnd'] = endTime;
		store.baseParams['type'] = type;
		store.reload({
			params: {start:0,limit:100},
			callback: function(records, options, success){
//				console.log(records);
			},
			scope: store
		});
	}
   
   function showErrInfo(msg){
	   console.log(msg);
    	var _importPanel = new Ext.Panel({
    		layout : "fit",
//    		layoutConfig : {
//    			animate : true
//    		},
    		defaults:{
    			height : '100%',
    			readOnly: true
    		},
    		items : [{xtype:"textarea",value:msg}],
    	});
    	
    	newWin = new Ext.Window({
    		width : 520,
    		height:200,
    		title : '详情',
    		defaults : {// 表示该窗口中所有子元素的特性
    			border : false
    			// 表示所有子元素都不要边框
    		},
    		plain : true,// 方角 默认
    		modal : true,
    		shim : true,
    		collapsible : true,// 折叠
    		closable : true, // 关闭
    		closeAction: 'close',
    		resizable : false,// 改变大小
    		draggable : true,// 拖动
    		minimizable : false,// 最小化
    		maximizable : false,// 最大化
    		animCollapse : true,
    		constrainHeader : true,
    		autoHeight : false,
    		items : [_importPanel]
    	});
		newWin.show();
   }

   function downloadExcel(id){
	   Ext.Ajax.request( {
			  url : path + "/operate/"+"checkDownloadExcelByid/",
			  method : 'post',
			  params : {
				  id:id
			  },
			  success : function(response, options) {
				   var o = Ext.util.JSON.decode(response.responseText);
				   if(o.i_type && "success"== o.i_type){
					   var form=$("<form>");//定义一个form表单
					   form.attr("style","display:none");
					   form.attr("target","");
					   form.attr("method","post");
					   form.attr("action",path + "/operate/"+"downloadExcelByid?id="+id);
					   var input1=$("<input>");
					   input1.attr("type","hidden");
					   input1.attr("name","exportData");
					   input1.attr("value",(new Date()).getMilliseconds());
					   $("body").append(form);//将表单放置在web中
					   form.append(input1);
					   form.submit();//表单提交 
				   }else{
				   	   Ext.Msg.alert('提示', o.i_msg); 
				   }
			  },
			  failure : function() {
				  console.log(2133333);
			  }
		});
	   
	   
   }