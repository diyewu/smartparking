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
			url : qrUrl+"listSearchNo",
			reader : new Ext.data.JsonReader({
				root : 'data',
				fields : [
					{name:  'search_no'},
					{name : 'search_name'},
					{name : 'create_date'},
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
            	{header:"编号",align:'center',dataIndex:"search_no",sortable:true}, 
	            {header:"名称",align:'center',dataIndex:"search_name",sortable:true},
	            {header:"操作",align:'center',dataIndex:"id",width:50,
	            renderer: function (value, meta, record) {
//	            	console.log(record);
					            			var formatStr = "<input id = 'bt_edit_" + record.get('id')
							+ "' onclick=\"showEditUser('" + record.get('id') + "','"
							+ record.get('search_no') + "','"
							+ record.get('search_name')
							+ "');\" type='button' value='编辑' width ='15px'/>&nbsp;&nbsp;"; 

										     var deleteBtn = "<input id = 'bt_delete_" + record.get('id')
							+ "' onclick=\"deleteUser('" + record.get('id')
							+ "');\" type='button' value='删除' width ='15px'/>";
										            			
            				var resultStr = String.format(formatStr);
            				if(loginUserId != record.id){
            					return "<div>" + resultStr+deleteBtn + "</div>";
            				}else{
            					return "";
            				}
        				  } .createDelegate(this)
	            } 
            ] 
        ); 
        var tbar = new Ext.Toolbar({  
            renderTo : Ext.grid.GridPanel.tbar,// 其中grid是上边创建的grid容器  
            items :['编号：', {
		  		  id : 'researchNo',
		  		  xtype : 'textfield',
		  		  width : 115,
		  	},'名称：',  {
		  		  id : 'researchName',
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
					Ext.getCmp('researchNo').setValue("");
					Ext.getCmp('researchName').setValue("");
				}
			},{
				text : '添加数据',
				iconCls : 'Add',
				handler : function() {
					showEditUser();
				}
			},{
				text : '导入Excel',
				iconCls : 'Add',
				handler : function() {
					showUploadExcel();
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
       //enableTabScroll:true,
       layout:"border",
       items:[
           mainPanel
   	   ]
   });
   });
   
   function reloadData(){
		var researchNo = document.getElementById('researchNo').value ;
		var researchName = document.getElementById('researchName').value ;;
		store.baseParams['searchNo'] = researchNo;
		store.baseParams['searchName'] = researchName;
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
				  url : path + "/projectmgr/deleteResearchInfo",
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
    function showEditUser(_id,_searchNo,_searchName){
    	if(typeof(_id) == "undefined" || _id  == ""){
    		_id ="";
    	}
    	var _fileForm =  new Ext.form.FormPanel({
            frame: true,
            autoHeight: true,
            labelWidth: 80,
            labelAlign: "right",
            bodyStyle:"text-align:left",
            border : false,
            items: [
               {xtype:"textfield", width:180,id: "eSearchNo",name: "eUserName", fieldLabel: "编号",value:_searchNo},
               {xtype:"textfield", width:180,id: "eSearchName",name: "enewpwd", fieldLabel: "名称",value:_searchName}
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
    				var no = Ext.getCmp('eSearchNo').getValue();
    				var name = Ext.getCmp('eSearchName').getValue();
    				if(typeof(no) == "undefined" || no  == ""){
    					Ext.Msg.alert('提示', '请填写编号');
    					return;
    				}
    				if(typeof(name) == "undefined" || name  == ""){
    					Ext.Msg.alert('提示', '请填写名称');
    					return;
    				}
    				Ext.Ajax.request({
    					  url : path + "/projectmgr/editReachInfo",
    					  method : 'post',
    					  params : {
    						  id:_id,
    						  name:name,
    						  no:no
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
    
    function showUploadExcel(projrctId){
    	var winHeight='';
    	var isHid =null;
    	var imisHid =null;
    	if(typeof(projrctId) == "undefined" || projrctId  == ""){
    		isHid = true;
    		imisHid = false;
    		winHeight = 200;
    	}else{
    		winHeight = 200;
    		isHid = false;
    		imisHid = true;
    	}
    	var uxfile = new Ext.ux.form.FileUploadField({
    		width: 200,
			id : 'showFileName',
			name : 'uploadFile',
			fieldLabel : '文件名'
    	});
    	uxfile.setValue();
    	
    	var _fileForm = new Ext.FormPanel({
    		layout : "fit",
    		frame : true,
    		border : false,
    		autoHeight : true,
    		waitMsgTarget : true,
    		defaults : {
    			bodyStyle : 'padding:10px'
    		},
    		margins : '0 0 0 0',
    		labelAlign : "left",
    		labelWidth : 80,
    		fileUpload : true,
    		items : [{  
                xtype:'hidden',  
                fieldLabel: 'id',  
                name: 'id'//,  
//                value: '' 
            },{
    			xtype : 'fieldset',
    			title : '选择文件',
    			autoHeight : true,
    			//hidden:isHid,
    			items : [{
    				id : 'sampleUploadFileId',
    				name : 'uploadFile',
    				xtype : "textfield",
    				fieldLabel : '选择文件',
    				inputType : 'file',
    				anchor : '96%'//,
//					hidden:isHid,
//					hideLabel:isHid 
    			}]
    		}]
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
//    				var vers = document.getElementById('importTitle').value ;
//    		        var reg = /^\d{8}$/;     
//    				if(vers.match(reg) == null){  
//    					Ext.Msg.alert("error", "版本号只能填写8位数字，如20150101");
//    					return;
//    				}
    					var upval = Ext.getCmp("sampleUploadFileId").getValue();
	    				if (!upval) {
	    					Ext.Msg.alert("error", "请选择你要上传的文件");
	    					return;
	    				} else {
	    					if(typeof(projrctId) == "undefined" || projrctId  == ""){
	    						if(upval.indexOf('.xls') < 0 && upval.indexOf('.xlsx') < 0){
	    							Ext.Msg.alert("error", "请选择正确的EXCEl文件");
	    							return;
	    						}
	    					}
	    					this.disable();
	    					var btn = this;
	    					// 开始上传
	    					var sampleForm = _fileForm.getForm();
	    					sampleForm.submit({
	    						url : path +'/projectmgr/uploadSearchNoInfoFile',
	    						params : {  
	    		                },  
	    						success : function(form, action) {
	    							btn.enable();
	    							var data = Ext.decode(action.response.responseText);
//	    							console.log(data);
	    							if(data.i_type == "success"){
	    								Ext.Msg.alert("success",'上传成功！请耐心等待导入结果，详情请查询“操作记录”信息',function(){  
		    								newWin.close();
		    								reloadData();
	    								});
	    							}else{
	    								Ext.Msg.alert("Error",data.i_msg,function(){  
	    						            //关闭后执行  
	    									newWin.close();
		    								reloadData();
	    						        });  
	    								
	    							}
	    						},
	    						failure : function(form, action) {
	    							var data = Ext.decode(action.response.responseText);
	    							Ext.Msg.alert("Error",data.msg,function(){  
		    							newWin.close();
		    							reloadData();
	    							});
	    						}
	    					});
	    				}
    			}
    		},{
    			id : "btn_import_wordclass_down",
    			text : "下载示例文件",
    			handler : function() {
    				window.location= path+"/example/research_no_dictionary_example.xlsx"; 
    			}
    		}]
    	});
    	
    	newWin = new Ext.Window({
    		width : 520,
    		title : '导入数据',
    		height : winHeight,
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
    
