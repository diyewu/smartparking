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
   		
   		var qrUrl = path + "/webuser/";
   		var order;
        store = new Ext.data.Store({
			url : qrUrl+"listUser",
			reader : new Ext.data.JsonReader({
				root : 'data',
				fields : [
					{name:  'user_name'},
					{name : 'user_role'},
					{name : 'user_role_id'},
					{name : 'real_name'},
					{name : 'allow_phone_size'},
					{name : 'use_phone_size'},
					{name : 'enable_time'},
					{name : 'disable_time'},
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
            	{header:"用户名",align:'center',dataIndex:"user_name",sortable:true}, 
	            {header:"角色类别",align:'center',dataIndex:"user_role",sortable:true},
	            {header:"用户别名",align:'center',dataIndex:"real_name",sortable:true},
	            {header:"启用时间",align:'center',dataIndex:"enable_time",sortable:true},
	            {header:"禁止时间",align:'center',dataIndex:"disable_time",sortable:true},
	            {header:"允许登陆手机数",align:'center',dataIndex:"allow_phone_size",width:50,sortable:true},
	            {header:"已用手机数",align:'center',dataIndex:"use_phone_size",width:50,sortable:true},
	            {header:"操作",align:'center',dataIndex:"id",width:50,
	            renderer: function (value, meta, record) {
//	            	console.log(record);
					            			var formatStr = "<input id = 'bt_edit_" + record.get('id')
							+ "' onclick=\"showEditUser('" + record.get('id') + "','"
							+ record.get('user_name') + "','"
							+ record.get('user_role') + "','"
							+ record.get('user_role_id') + "','"
							+ record.get('real_name') + "','"
							+ record.get('allow_phone_size')+ "','"
							+ record.get('enable_time')+ "','"
							+ record.get('disable_time')
							+ "');\" type='button' value='编辑' width ='15px'/>&nbsp;&nbsp;"; 

										     var deleteBtn = "<input id = 'bt_delete_" + record.get('id')
							+ "' onclick=\"deleteUser('" + record.get('id')
							+ "');\" type='button' value='删除' width ='15px'/>";
										            			
            				var resultStr = String.format(formatStr);
//            				if(loginUserId != record.id){
            					return "<div>" + resultStr+deleteBtn + "</div>";
//            				}else{
//            					return "";
//            				}
        				  } .createDelegate(this)
	            } 
            ] 
        ); 
		//用户角色
		var moduleStore = new Ext.data.Store({
	        proxy: new Ext.data.HttpProxy({
	            url: path + "/webuser/getRole?all="+1 //这里是参数可以顺便写,这个数据源是在第一个下拉框select的时候load的
	        }),
	        reader: new Ext.data.JsonReader({
        	root : 'products',
	        fields:['value','text']
	        })
	    });
		
		_cob = new Ext.form.ComboBox({
			id:'shUserRole',
			width:150,
			forceSelection: true,
			store:moduleStore,
			valueField:'value',
			displayField:'text',
			typeAhead: true,
			triggerAction: 'all',
			selectOnFocus:true,//用户不能自己输入,只能选择列表中有的记录
			allowBlank:false,
			editable:false
		});
		_cob.setValue("全部");
    	//------------------------
    	
    	
        var tbar = new Ext.Toolbar({  
            renderTo : Ext.grid.GridPanel.tbar,// 其中grid是上边创建的grid容器  
            items :['用户名：', {
		  		  id : 'shUserName',
		  		  xtype : 'textfield',
		  		  width : 115,
		  	},'用户角色：', _cob, {
				text : '查询',
				iconCls : 'Magnifier',
				handler : function() {
					reloadData();
				}
			}, {
				text : '重置',
				iconCls : 'Reload',
				handler : function() {
					Ext.getCmp('shUserName').setValue("");
					Ext.getCmp('shUserRole').setValue("全部");
				}
			},{
				text : '添加新用户',
				iconCls : 'Useradd',
				handler : function() {
					showEditUser();
				}
			}/*,{
				text : '设置前台登陆',
				iconCls : 'Cog',
				handler : function() {
					setUserCanLogin(0);
				}
			},{
				text : '取消前台登陆',
				iconCls : 'Cancel',
				handler : function() {
					setUserCanLogin(1);
				}
			}*/]

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
       //enableTabScroll:true,
       layout:"border",
       items:[
           mainPanel
   	   ]
   });
   });
   
   function reloadData(){
		var userName = document.getElementById('shUserName').value ;
		var shUserRole = _cob.getValue();
		store.baseParams['userName'] = userName;
		store.baseParams['userRole'] = shUserRole;
		store.reload({
			params: {start:0,limit:20},
			callback: function(records, options, success){
//				console.log(records);
			},
			scope: store
		});
	}
	
	function deleteUser(id){
		Ext.Msg.confirm('删除数据', '确认?',function (button,text){if(button == 'yes'){
			Ext.Ajax.request({
				  url : path + "/webuser/deleteUser",
				  method : 'post',
				  params : {
					  userId:id
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
    function showEditUser(_userId,_userName,_userRoleName,_userRole,_realName,_phoneval,_enableTime,_disableTime){
    	var isHidden = true;
    	var pwdval = "******";
    	if(typeof(_userId) == "undefined" || _userId  == ""){
    		isHidden = false;
    		pwdval ="";
    	}
    	//用户角色
		var _moduleStore = new Ext.data.Store({
	        proxy: new Ext.data.HttpProxy({
	            url: path + "/webuser/getRole?all="+0 //这里是参数可以顺便写,这个数据源是在第一个下拉框select的时候load的
	        }),
	        reader: new Ext.data.JsonReader({
        	root : 'products',
	        fields:['value','text']
	        })
	    });
		_moduleStore.load(); 
		var co = new Ext.form.ComboBox({
			id:'couserRole',
			hiddenName:"couserRole", //提交到后台的input的name   
			width:180,
			fieldLabel: '请选择角色',
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
	        if (_userRole)  
	        	co.setValue(_userRole);  
	    }); 
		//*******************启用禁用时间
		
		//*******************启用禁用时间
    	var _fileForm =  new Ext.form.FormPanel({
            frame: true,
            autoHeight: true,
            labelWidth: 90,
            labelAlign: "left",
            bodyStyle:"text-align:left",
            border : false,
            items: [
               {xtype:"textfield", width:180,id: "eUserName",name: "eUserName", fieldLabel: "用户名",value:_userName},
               {xtype:"textfield", width:180,id: "enewpwd",name: "enewpwd", fieldLabel: "用户密码",value:pwdval},
               {xtype:"textfield", width:180,id: "enrealName",name: "enrealName", fieldLabel: "用户别名",value:_realName},
               {xtype:"textfield", width:180,id: "phoneval",name: "phoneval", fieldLabel: "允许登录手机数",value:_phoneval},
               {
                   layout:'column', 
                   style:"margin-bottom:5px",
                   items:[  
                	   {  
                           columnWidth:.195,  
                           items:[
                        	   {
                                   xtype : 'label',
                                   text:"生效时间:"
                        	   }
                            ]  
                          },
                   {  
                    columnWidth:.35, 
                    items:[
                    	{
     					   xtype: "datefield",
     					   id: "startdate",
     					   name: "startdate",
     					   fieldLabel: "开始日期",
     					   editable: false,
     					   emptyText: "--请选择开始日期--",
     					   format: "Y-m-d",//日期的格式
     					   altFormats: "Y/m/d|Ymd",
     					   width: 150
                    	}
                     ]  
                   },{  
                       columnWidth:.35,  
                       items:[
                    	   {
        					   xtype: "datefield",
        					   id: "enddate",
        					   name: "enddate",
        					   fieldLabel: "结束日期",
        					   editable: false,
        					   emptyText: "--请选择结束日期--",
        					   format: "Y-m-d",//日期的格式
        					   altFormats: "Y/m/d|Ymd",
        					   width: 150
        				}
                        ]  
                      }  
                   ]  
                   },
               co
            ],
         });
    	if(typeof(_enableTime) != "undefined" && _enableTime  != ""){
    		Ext.getCmp('startdate').setValue(_enableTime);
    	}
    	if(typeof(_disableTime) != "undefined" && _disableTime  != ""){
    		Ext.getCmp('enddate').setValue(_disableTime);
    	}
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
    				var name = Ext.getCmp('eUserName').getValue();
    				var pwd = Ext.getCmp('enewpwd').getValue();
    				var realName = Ext.getCmp('enrealName').getValue();
    				var phone = Ext.getCmp('phoneval').getValue();
    				var beginTime = Ext.getCmp('startdate').getValue();
    				var endTime = Ext.getCmp('enddate').getValue();
    				console.log(beginTime);
    				var role = co.getValue();
    				if(typeof(beginTime) == "undefined" || beginTime  == ""){
    					Ext.Msg.alert('提示', '请选择生效时间');
    					return;
    				}
    				if(typeof(endTime) == "undefined" || endTime  == ""){
    					Ext.Msg.alert('提示', '请选择生效时间');
    					return;
    				}
    				
    				if (beginTime && endTime) {
	                    if(endTime < beginTime){
	                    	Ext.MessageBox.alert("提示","生效结束时间不能早于开始时间！");
	                    	return;
	                    }
    				}
    				
    				if(typeof(name) == "undefined" || name  == ""){
    					Ext.Msg.alert('提示', '请填写用户名');
    					return;
    				}
    				if(typeof(pwd) == "undefined" || pwd  == ""){
    					Ext.Msg.alert('提示', '请填写用户密码');
    					return;
    				}
    				if(typeof(realName) == "undefined" || realName  == ""){
    					Ext.Msg.alert('提示', '请填写用户别名');
    					return;
    				}
    				if(typeof(role) == "undefined" || role  == ""){
    					Ext.Msg.alert('提示', '请选择用户角色');
    					return;
    				}
    				if(typeof(phone) == "undefined" || phone  == ""){
    					Ext.Msg.alert('提示', '请填写允许登录手机数');
    					return;
    				}else{
        		        var reg = /^\d{1,10}$/;  
        		        
        				if(phone.match(reg) == null){  
        					Ext.Msg.alert("error", "允许登录手机数只能填写数字");
        					return;
        				}
    				}
//    				console.log(co);
    				Ext.Ajax.request({
    					  url : path + "/webuser/editUser",
    					  method : 'post',
    					  params : {
    						  userId:_userId,
    						  userName:name,
    						  userPwd:pwd,
    						  realName:realName,
    						  phoneSize:phone,
    						  beginTime:beginTime,
    						  endTime:endTime,
    						  userRole:role
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
    		height:250,
    		title : '用户编辑',
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
			  url : path + "/webuser/setConsoleUserAllowLogin",
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