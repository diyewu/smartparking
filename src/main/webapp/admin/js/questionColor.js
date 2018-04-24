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
   		
   		var qrUrl = path + "/projectmgr/";
   		var order;
        store = new Ext.data.Store({
			url : qrUrl+"listQuestionTypeColor",
			reader : new Ext.data.JsonReader({
				root : 'data',
				fields : [
					{name:  'question_type'},
					{name : 'color_name'},
					{name : 'id'}
				]
			})
//			remoteSort : true
		});
		store.load({params:{start:0,limit:20}});
		var sm = new Ext.grid.CheckboxSelectionModel();
        var column=new Ext.grid.ColumnModel( 
            [ 
            	new Ext.grid.RowNumberer(),
            	sm,
            	{header:"问题类型",align:'center',dataIndex:"question_type",sortable:true}, 
	            {header:"颜色",align:'center',dataIndex:"color_name",sortable:true},
	            {header:"操作",align:'center',dataIndex:"id",width:50,
	            renderer: function (value, meta, record) {
//	            	var formatStr = "<input id = 'bt_edit_" + record.get('id')
//							+ "' onclick=\"showEditQuestionType('" + record.get('id') + "','"
//							+ record.get('question_type') + "','"
//							+ record.get('color_name').replace(/'/g, '\"')
//							+ "');\" type='button' value='编辑' width ='15px'/>&nbsp;&nbsp;"; 

										     var deleteBtn = "<input id = 'bt_delete_" + record.get('id')
							+ "' onclick=\"deleteQuestionType('" + record.get('id')
							+ "');\" type='button' value='删除' width ='15px'/>";
										            			
//            				var resultStr = String.format(formatStr);
            				return "<div>" + deleteBtn + "</div>";
        				  } .createDelegate(this)
	            } 
            ] 
        ); 
        var tbar = new Ext.Toolbar({  
            renderTo : Ext.grid.GridPanel.tbar,// 其中grid是上边创建的grid容器  
            items :['问题类型：', {
		  		  id : 'shQuestion',
		  		  xtype : 'textfield',
		  		  width : 115,
		  	}, {
				text : '查询',
				iconCls : 'Magnifier',
				handler : function() {
					reloadData();
				}
			}, {
				text : '重置',
				iconCls : 'Reload',
				handler : function() {
					Ext.getCmp('shQuestion').setValue("");
					Ext.getCmp('shColor').setValue("全部");
				}
			},{
				text : '添加新问题类型',
				iconCls : 'Add',
				handler : function() {
					showEditQuestionType();
				}
			}]

        });  
        grid = new Ext.grid.EditorGridPanel({ 
			region:'center',
			border:false,
//			autoHeight:true,
			viewConfig: {
	            forceFit: true, //让grid的列自动填满grid的整个宽度，不用一列一列的设定宽度。
	            emptyText: '系统中还没有任务'
	        },
	        sm:sm,
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
					pageSize : 20,
					prependButtons : true,
					beforePageText : '第',
					afterPageText : '页，共{0}页',
					displayMsg : '第{0}到{1}条记录，共{2}条',
					emptyMsg : "没有记录"
				}),
        });
        
	
      
  	var mainPanel = new Ext.Panel({
  		region:"center",
		layout:'border',
		border:false,
		items:[grid],
	});
	
   var viewport=new Ext.Viewport({
       layout:"border",
       items:[
           mainPanel
   	   ]
   });
   });
   
   function reloadData(){
		var shQuestion = document.getElementById('shQuestion').value ;
		store.baseParams['questionType'] = shQuestion;
		store.reload({
			params: {start:0,limit:20},
			callback: function(records, options, success){
			},
			scope: store
		});
	}
	
	function deleteQuestionType(id){
		Ext.Msg.confirm('删除数据', '确认?',function (button,text){if(button == 'yes'){
			Ext.Ajax.request({
				  url : path + "/projectmgr/deleteQuestionTypeById",
				  method : 'post',
				  params : {
					  id:id
				  },
				  success : function(response, options) {
				   var o = Ext.util.JSON.decode(response.responseText);
				   if(o.i_type && "success"== o.i_type){
					   reloadData();
				   }else{
				   	   Ext.Msg.alert('提示', o.i_msg); 
				   }
				  },
				  failure : function() {
					  Ext.Msg.alert('提示', '删除失败'); 
				  }
	 		});
		}});
		
	}
    function showEditQuestionType(_id,_question,_color){
    	var isHidden = true;
    	if(typeof(_id) == "undefined" || _id  == ""){
    		isHidden = false;
    	}
    	//用户角色
		var _moduleStore = new Ext.data.Store({
	        proxy: new Ext.data.HttpProxy({
	            url: path + "/projectmgr/getColor.action?all="+0 //这里是参数可以顺便写,这个数据源是在第一个下拉框select的时候load的
	        }),
	        reader: new Ext.data.JsonReader({
        	root : 'products',
	        fields:['value','text']
	        })
	    });
		_moduleStore.load(); 
		var co = new Ext.form.ComboBox({
			id:'couserColor',
			hiddenName:"couserColor", //提交到后台的input的name   
			width:180,
			fieldLabel: '请选择颜色',
			forceSelection: true,
			store:_moduleStore,
			mode: 'local',
			valueField:'value',
			displayField:'text',
			typeAhead: true,
			triggerAction: 'all',
			selectOnFocus:true,//用户不能自己输入,只能选择列表中有的记录
			allowBlank:false,
			editable:false
		});
		_moduleStore.on('load', function() { //数据加载完成后设置下拉框值  
	        if (_color)  
	        	co.setValue(_color);  
	    }); 
    	var _fileForm =  new Ext.form.FormPanel({
            frame: true,
            autoHeight: true,
            labelWidth: 80,
            labelAlign: "right",
            bodyStyle:"text-align:left",
            border : false,
            items: [
               {xtype:"textfield", width:180,id: "eQuestionType",name: "eUserName", fieldLabel: "问题类型",value:_question},
               co
            ],
         });
    	
    	var _importPanel = new Ext.Panel({
    		layout : "fit",
    		layoutConfig : {
    			animate : true
    		},
    		items : [_fileForm],
    		buttons : [{
    			id : "btn_import_wordclass",
    			text : "保存",
    			handler : function() {
    				var question = Ext.getCmp('eQuestionType').getValue();
    				var color = co.getValue();
    				if(typeof(question) == "undefined" || question  == ""){
    					Ext.Msg.alert('提示', '请填写问题类型');
    					return;
    				}
    				if(typeof(color) == "undefined" || color  == ""){
    					Ext.Msg.alert('提示', '请选择颜色');
    					return;
    				}
    				Ext.Ajax.request({
    					  url : path + "/projectmgr/editQuestionColor",
    					  method : 'post',
    					  params : {
    						  id:_id,
    						  question:question,
    						  color:color
    					  },
    					  success : function(response, options) {
    					   var o = Ext.util.JSON.decode(response.responseText);
    					   if(o.i_type && "success"== o.i_type){
    						   Ext.Msg.alert("success",'保存成功！',function(){  
   								newWin.close();
   								reloadData();
    						   });
    					   }else{
    					   	   Ext.Msg.alert('提示', o.i_msg); 
    					   }
    					  },
    					  failure : function() {
    						  Ext.Msg.alert('提示', '操作失败'); 
    					  }
    		 		});
    			}
    		}]
    	});
    	
    	newWin = new Ext.Window({
    		width : 520,
    		height:140,
    		title : '问题类型编辑',
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
    
function setUserCanLogin(value){
	var gcm = grid.getSelectionModel();
	var dids = '';
	var rows = gcm.getSelections();
	var delectArray = new Array();
//	delectArray = grid.getStore().data.items;
	for(var i =0;i<grid.getStore().data.items.length;i++){
		delectArray.push(grid.getStore().data.items[i].data.id);
	}
    if (rows.length > 0) {
		for ( var i = 0; i < rows.length; i++) {
			var row = rows[i];
			dids = dids + row.data.id + ','; // 拼装ID串
//			removeByValue(delectArray,row.data.id);
		}
	}else{
		Ext.Msg.alert('提示', '请勾选要设置的记录');
		return;
	}
	Ext.Msg.confirm('确认设置', '确认?',function (button,text){if(button == 'yes'){
		Ext.Ajax.request( {
			  url : path + "/user/setConsoleUserAllowLogin.action",
			  method : 'post',
			  params : {
			   ids : dids,
			   val:value
			  },
			  success : function(response, options) {
			   var o = Ext.util.JSON.decode(response.responseText);
			   if(o.i_type && "success"== o.i_type){
				   Ext.Msg.alert('提示', '设置成功'); 
			   }else{
			   	   Ext.Msg.alert('提示', o.i_msg); 
			   }
			  },
			  failure : function() {
			  	
			  }
 		});
	}});
}