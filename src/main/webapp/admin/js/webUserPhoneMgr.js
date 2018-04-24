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
			url : qrUrl+"listUserPhone",
			reader : new Ext.data.JsonReader({
				root : 'data',
				fields : [
					{name:  'user_name'},
					{name : 'real_name'},
					{name : 'phone_id'},
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
            	{header:"用户名",align:'center',dataIndex:"user_name",sortable:true}, 
	            {header:"用户别名",align:'center',dataIndex:"real_name",sortable:true},
	            {header:"手机标识码",align:'center',dataIndex:"phone_id",sortable:true},
	            {header:"创建时间",align:'center',dataIndex:"create_date",sortable:true},
	            {header:"操作",align:'center',dataIndex:"id",width:50,
	            renderer: function (value, meta, record) {
//	            	console.log(record);
						var deleteBtn = "<input id = 'bt_delete_" + record.get('id')
							+ "' onclick=\"deleteUserPhone('" + record.get('id')
							+ "');\" type='button' value='删除' width ='15px'/>";
										            			
//            				if(loginUserId != record.id){
            					return "<div>" +deleteBtn + "</div>";
//            				}else{
//            					return "";
//            				}
        				  } .createDelegate(this)
	            } 
            ] 
        ); 
    	
        var tbar = new Ext.Toolbar({  
            renderTo : Ext.grid.GridPanel.tbar,// 其中grid是上边创建的grid容器  
            items :['用户名：', {
		  		  id : 'shUserName',
		  		  xtype : 'textfield',
		  		  width : 115,
		  	},'用户别名：',  {
		  		  id : 'shUserRealName',
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
					Ext.getCmp('shUserName').setValue("");
					Ext.getCmp('shUserRealName').setValue("");
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
		var userName = document.getElementById('shUserName').value ;
		var shUserRealName = document.getElementById('shUserRealName').value ;
		store.baseParams['userRealName'] = shUserRealName;
		store.baseParams['userLoginName'] = userName;
		store.reload({
			params: {start:0,limit:20},
			callback: function(records, options, success){
//				console.log(records);
			},
			scope: store
		});
	}
	
	function deleteUserPhone(id){
		Ext.Msg.confirm('删除数据', '确认?',function (button,text){if(button == 'yes'){
			Ext.Ajax.request({
				  url : path + "/webuser/deleteUserPhone",
				  method : 'post',
				  params : {
					  userPhoneId:id
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
    
