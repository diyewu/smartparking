    Ext.QuickTips.init();
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
   		
//   	var qrUrl = path + "/setting!";
   		var order;
   		var _pageSize = 20;
   		var reader = new Ext.data.JsonReader({
   			idProperty : 'id',
   			root : 'data',
   			fields : [ {
   				name : 'id',
   				type : 'string'
   			},  {
   				name : 'project_name',
   				type : 'string'
   			}, {
   				name : 'create_time',
   				type : 'string'
   			}, {
   				name : 'real_name',
   				type : 'string'
   			}]
   		});
        store = new Ext.data.Store({
			url : path +"/projectmgr/listImport",
			reader : reader
		});
		store.load({params:{start:0,limit:20}})
//				callback: function(records, options, success){  
//			         //该数组存放将要勾选的行的record  
//			         var arr = [];  
//			         for (var i = 0; i < records.length; i++) {
//			        	 if(records.data.is_checked == 0){
//			        		 arr.push(records[i]);  
//			        	 }
//			         }  
//			         grid.getSelectionModel().select(arr);//选中指定行  
//	            } 
//		);
		
//		store.load({  
//	        callback: function(records, options, success){   
//	        	 //该数组存放将要勾选的行的record  
//		         var arr = [];  
//		         for (var i = 0; i < records.length; i++) {
//		        	 if(records[i].data.is_checked == 0){
//		        		 arr.push(i);  
//		        	 }
//		         }  
//		         grid.getSelectionModel().selectRows(arr);
//	        }     
//	    });  
		
		var pagingBar = new Ext.PagingToolbar({
			store : store,
			displayInfo : true,
			pageSize : _pageSize,
			beforePageText : '第',
			afterPageText : '页，共{0}页',
			displayMsg : '第{0}到{1}条记录，共{2}条',
			emptyMsg : "没有记录"
		});
		var sm = new Ext.grid.CheckboxSelectionModel();
        var column=new Ext.grid.ColumnModel( 
            [ 
            	new Ext.grid.RowNumberer(),
            	sm,
            	{header:"项目名称",align:'center',dataIndex:"project_name",sortable:true}, 
	            {header:"创建时间",align:'center',dataIndex:"create_time",sortable:true},
	            {header:"创建人",align:'center',dataIndex:"real_name",sortable:true},
	            {header:"操作",align:'center',dataIndex:"id",
	            renderer: function (value, meta, record) {
			              var setBtn = "<input id = 'bt_set_" + record.get('id')
			            	+ "' onclick=\"showAttrWin('" + record.get('id')
			            	+ "');\" type='button' value='设置' width ='15px'/>&nbsp;&nbsp;";
			              var upImfBtn = "<input id = 'bt_upload_" + record.get('id')
			              + "' onclick=\"showEditRom('" + record.get('id')
			              + "');\" type='button' value='上传图片' width ='15px'/>&nbsp;&nbsp;";
						  var deleteBtn = "<input id = 'bt_delete_" + record.get('id')
							+ "' onclick=\"deleteProject('" + record.get('id')
							+ "');\" type='button' value='删除' width ='15px'/>";
										            			
//            				var resultStr = String.format(formatStr);
            				return "<div>" + setBtn+upImfBtn+deleteBtn + "</div>";
        				  } .createDelegate(this)
	            } 
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
    		width : 160,
    		//fieldLabel : '创建时间',
    	}); 
    	this.beginTimeField = beginTimeField;
    	
    	this.endTimeField = endTimeField;
    	beginTimeField.on('change', function(o, v) {
    		// if (v) {
    		// endTimeField.setMinValue(v);
    		// var max = new Date();
    		// max.setFullYear(v.getFullYear());
    		// max.setMonth(v.getMonth() + 1);
    		// max.setDate(0);
    		// endTimeField.setMaxValue(max);
    		// }
    	});
    	beginTimeField.fireEvent('change', beginTimeField, initDate);
    	endTimeField.on('change', function(o, v) {
    		// beginTimeField.setMaxValue(v);
    		// var min = new Date();
    		// min.setFullYear(v.getFullYear());
    		// min.setMonth(v.getMonth());
    		// min.setDate(1);
    		// beginTimeField.setMinValue(min);
    	});
    	
    	
        
        var tbar = new Ext.Toolbar({  
            renderTo : Ext.grid.GridPanel.tbar,// 其中grid是上边创建的grid容器  
            items :['项目名称：', {
//		  		  id : 'searchMonth',
		  		  id : 'searchProjectName',
//		  		  emptyText : "请输入年月，6位数字",
		  		  xtype : 'textfield',
		  		  width : 115,
		  		  listeners : {
		  			  specialkey : function(f, e) {
		  				  if (e.getKey() == e.ENTER) {
//		  					  self.searchItem(f);
		  				  }
		  			  }
		  		  }
		  	},'&nbsp;&nbsp;创建时间：',
		  	beginTimeField,'至',
		  	endTimeField, {
				text : '查询',
				iconCls : 'Magnifier',
				handler : function() {
					reloadData();
				}
			}, {
				text : '重置',
				iconCls : 'Reload',
				handler : function() {
					Ext.getCmp('searchProjectName').setValue("");
					Ext.getCmp('createDateStart').setValue("");
					Ext.getCmp('createDateEnd').setValue("");
				}
			},{
				text : '导入新数据',
				iconCls : 'Add',
				handler : function() {
					showEditRom();
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
            bbar:pagingBar
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
		var beginTime = this.beginTimeField.getValue();
		var endTime = this.endTimeField.getValue();
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
		var beginTimeStr = '', endTimeStr = '';
		if (beginTime)
			beginTimeStr = beginTime.format('Y-m-d H:i:s');
		if (endTime)
			endTimeStr = endTime.format('Y-m-d H:i:s');
		
		var searchProjectName = document.getElementById('searchProjectName').value ;
		var createDateStart = document.getElementById('createDateStart').value ;
		var createDateEnd = document.getElementById('createDateEnd').value ;
		store.baseParams['projectName'] = searchProjectName;
		store.baseParams['createDateStart'] = createDateStart;
		store.baseParams['createDateEnd'] = createDateEnd;
		store.reload({
			params: {start:0,limit:10},
//			callback: function(records, options, success){
////				console.log(records);
//				//该数组存放将要勾选的行的record  
//		         var arr = [];  
//		         for (var i = 0; i < records.length; i++) {
//		        	 if(records[i].data.is_checked == 0){
//		        		 arr.push(i);  
//		        	 }
//		         }  
//		         grid.getSelectionModel().selectRows(arr);
//			},
			scope: store
		});
	}
	
	
	
	function deleteProject(id){
		Ext.Msg.confirm('删除数据', '确认?',function (button,text){if(button == 'yes'){
			Ext.Ajax.request( {
				  url : path + "/projectmgr/deleteProjectById",
				  method : 'post',
				  params : {
					  id:id
				  },
				  success : function(response, options) {
				   var o = Ext.util.JSON.decode(response.responseText);
				   //alert(o.i_type);
				   if(o.i_type && "success"== o.i_type){
//					   Ext.Msg.alert('提示', '删除成功'); 
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
	
    function showEditRom(projrctId){
    	var winHeight='';
    	var isHid =null;
    	var imisHid =null;
    	if(typeof(projrctId) == "undefined" || projrctId  == ""){
    		isHid = true;
    		imisHid = false;
    		winHeight = 350;
    	}else{
    		winHeight = 200;
    		isHid = false;
    		imisHid = true;
    	}
    	var uxfile = new Ext.ux.form.FileUploadField({
    		width: 200,
//    		hidden:imisHid,
//			hideLabel:imisHid,
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
    			}/*,{
    				id : 'sampleZipUploadFile',
    				name : 'zipUploadFile',
    				xtype : "textfield",
    				fieldLabel : 'ZIP图片包',
    				inputType : 'file',
    				anchor : '96%',
					hidden:isHid,
					hideLabel:isHid 
    			}*/]
    		}, {
    			xtype : 'fieldset',
    			title : '设置参数',
    			autoHeight : true,
    			hidden:imisHid,
				hideLabel:imisHid,
    			items : [{
    				width:150,
    				xtype : 'textfield',
    				id:'importTitle',
    				name : 'importTitle',
    				fieldLabel : '标题'//,
//    				regex : /^\d{8}$/, //正则表达式在/...../之间
//    				regexText:"版本号只能填写8位数字，如20150101", //正则表达式错误提示  
//    				value:_romVersion,
    			}/*,co,co1*/,{
    				id:'_romCommentEdit',
    				width:400,
    				height:70,
    				xtype : 'textarea',
    				name : 'importComment',
    				anchor: "96.7%",
    				value:typeof(_romComment) == "undefined"?"":_romComment.replace(/<br>/ig, "\n"),
    				fieldLabel : '说明',
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
    				var vers = document.getElementById('importTitle').value ;
//    		        var reg = /^\d{8}$/;     
//    				if(vers.match(reg) == null){  
//    					Ext.Msg.alert("error", "版本号只能填写8位数字，如20150101");
//    					return;
//    				}
    					var upval = Ext.getCmp("sampleUploadFileId").getValue();
    					console.log(upval);
	    				if (!upval) {
	    					Ext.Msg.alert("error", "请选择你要上传的文件");
	    					return;
	    				} else {
	    					if(typeof(projrctId) == "undefined" || projrctId  == ""){
	    						if(upval.indexOf('.xls') < 0 && upval.indexOf('.xlsx') < 0){
	    							Ext.Msg.alert("error", "请选择正确的EXCEl文件");
	    							return;
	    						}
	    					}else{
	    						if(upval.indexOf('.zip') < 0){
	    							Ext.Msg.alert("error", "请选择正确的zip文件");
	    							return;
	    						}
    						}
	    					this.disable();
	    					var btn = this;
	    					// 开始上传
	    					var sampleForm = _fileForm.getForm();
	    					sampleForm.submit({
	    						url : path +'/projectmgr/uploadFile',
	    						params : {  
	    							projrctId : projrctId
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
    			hidden:imisHid,
    			handler : function() {
    				window.location= path+"/example/proje_date_example.xlsx"; 
    			}
    		}]
    	});
    	
    	newWin = new Ext.Window({
    		width : 520,
    		title : '导入项目数据',
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
    function showAttrWin(projectId){
    	var sa_pageSize = 100;
    	var sareader = new Ext.data.JsonReader({
   			idProperty : 'id',
   			root : 'data',
   			fields : [ {
   				name : 'id',
   				type : 'string'
   			},  {
   				name : 'project_name',
   				type : 'string'
   			}, {
   				name : 'attribute_name',
   				type : 'string'
   			}, {
   				name : 'type_name',
   				type : 'string'
   			}, {
   				name : 'info_type_name',
   				type : 'string'
   			}, {
   				name : 'attribute_type',
   				type : 'string'
   			}, {
   				name : 'attribute_active',
   				type : 'string'
   			}, {
   				name : 'project_id',
   				type : 'string'
   			}]
   		});
       var sasm = new Ext.grid.CheckboxSelectionModel();
       var sastore = new Ext.data.Store({
			url : path +"/projectmgr/listAttr",
			reader : sareader,
			listeners:{
				load:function(){
			       var records=[];//存放选中记录  
			       for(var i=0;i<sastore.getCount();i++){  
			        var record = sastore.getAt(i);  
//			        console.log(record);
			        if(record.data.attribute_active==1){//根据后台数据判断那些记录默认选中  
			          records.push(record);  
			        }  
			       }  
			       sasm.selectRecords(records);//执行选中记录  
				}
			} 
		});

       sastore.load({params:{start:0,limit:sa_pageSize,projectId : projectId}})
		
       var satbar = new Ext.Toolbar({  
            renderTo : Ext.grid.GridPanel.tbar,// 其中grid是上边创建的grid容器  
            items :[{
				text : '设置勾选筛选条件',
				iconCls : 'Accept',
				handler : function() {
					var arr = [];//声明空数组  
					var rows= sagrid_.getSelectionModel().getSelections();
//					arr.push(rows.data);
					if (rows === undefined || rows.length == 0) {
						Ext.Msg.alert('提示', '没有勾选数据，请确认。');
						return;
					}
					var projectId = rows[0].data.project_id;
					Ext.each(rows,function(row){//遍历行数据数组  
					    arr.push(row.data);
					});
					var json=JSON.stringify(arr);
					Ext.Msg.confirm('tip', '设置筛选条件后会重置前端项目权限，确认设置吗?',function (button,text){if(button == 'yes'){
						Ext.Ajax.request( {
							  url : path + "/projectmgr/setAttrActive",
							  method : 'post',
							  params : {
								 json : json,
								 projectId:projectId
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
			},{
				text : '保存属性信息',
				iconCls : 'Disk',
				handler : function() {
					var arr = [];//声明空数组  
					var records = sastore.getModifiedRecords();  
					Ext.each(records,function(record){//遍历行数据数组  
					    arr.push(record.data);
					});
					if (arr === undefined || arr.length == 0) {
						Ext.Msg.alert('提示', '数据没有改动，请确认。');
						return;
					}
					var json=JSON.stringify(arr);
					Ext.Ajax.request( {
						  url : path + "/projectmgr/saveAttrType",
						  method : 'post',
						  params : {
							 json : json
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
				}
			}]

        });  
       
		var sapagingBar = new Ext.PagingToolbar({
			store : sastore,
			displayInfo : true,
			pageSize : sa_pageSize,
			beforePageText : '第',
			afterPageText : '页，共{0}页',
			displayMsg : '第{0}到{1}条记录，共{2}条',
			emptyMsg : "没有记录"
		});
		
		//数据库动态取下拉框数据
		var typeStore = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
				url : path + "/projectmgr/getAttrType?type=0"
			}),
			reader: new Ext.data.JsonReader({
				root : 'data',
				fields:['value','text']
			})
		});
		typeStore.load();
		//数据库动态取下拉框数据
		var infoTypeStore = new Ext.data.Store({
			proxy: new Ext.data.HttpProxy({
				url : path + "/projectmgr/getAttrType?type=1"
			}),
			reader: new Ext.data.JsonReader({
				root : 'data',
				fields:['value','text']
			})
		});
		infoTypeStore.load();
		
        var sacolumn=new Ext.grid.ColumnModel( 
            [ 
            	new Ext.grid.RowNumberer(),
            	sasm,
            	{header:"项目名称",align:'center',dataIndex:"project_name",sortable:true}, 
	            {header:"属性名称",align:'center',dataIndex:"attribute_name",sortable:true},
	            {header:"设置必要属性信息(双击)",align:'center',dataIndex:"type_name",
	            	editor : new Ext.form.ComboBox({//编辑的时候变成下拉框。
	                    triggerAction : "all",
	                    editable: false,
//	                    valueField:'value',
	        			displayField:'text',
//	                    store : ["无","经度","维度","详细地址","图片编号"],
	                    store : typeStore,
	                    resizable : true,
	                    mode : 'local',
	                    selectOnFocus:true,//用户不能自己输入,只能选择列表中有的记录
	                    lazyRender : true,
	                    width : 12
	                   })
	            },
	            {header:"设置显示属性信息(双击)",align:'center',dataIndex:"info_type_name",
	            	editor : new Ext.form.ComboBox({//编辑的时候变成下拉框。
	            		triggerAction : "all",
	            		editable: false,
//	                    valueField:'value',
	            		displayField:'text',
//	                    store : ["无","经度","维度","详细地址","图片编号"],
	            		store : infoTypeStore,
	            		resizable : true,
	            		mode : 'local',
	            		selectOnFocus:true,//用户不能自己输入,只能选择列表中有的记录
	            		lazyRender : true,
	            		width : 12
	            	})
	            } 
            ] 
        ); 
    	
        
        var sagrid_ = new Ext.grid.EditorGridPanel({ 
			border:false,
			stripeRows:true,
			viewConfig: {
	            forceFit: true, //让grid的列自动填满grid的整个宽度，不用一列一列的设定宽度。
	            emptyText: '系统中还没有任务'
	        },
	        sm:sasm,
            cm:sacolumn, 
            store:sastore, 
            autoExpandColumn:0, 
            loadMask:true, 
            frame:true, 
            autoScroll:true, 
            tbar:satbar,
            bbar:sapagingBar
        });
    	
    	
    	var sanewWin = new Ext.Window({
    		layout : "fit",
    		width : 800,
    		title : '设置项目属性',
    		height : 600,
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
    		items : [sagrid_]
    	});
    	sanewWin.show();
    }
