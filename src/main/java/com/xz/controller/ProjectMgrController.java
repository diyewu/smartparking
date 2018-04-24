package com.xz.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xz.common.Page;
import com.xz.entity.CustomConfig;
import com.xz.entity.ModuleStoreBean;
import com.xz.service.AppService;
import com.xz.service.OperateHistoryService;
import com.xz.service.ProjectServices;

@RequestMapping("projectmgr")
@Controller
public class ProjectMgrController extends BaseController {
	@Autowired  
    private CustomConfig customConfig; 
	
	@Autowired
	private ProjectServices projectServices;
	
	@Autowired
	private OperateHistoryService operateHistoryService;
	
	@Autowired
	private AppService appService;
	
	ExecutorService threadPool = Executors.newCachedThreadPool();

	private ObjectMapper mapper;
	class RecCallable implements Callable<Object>{
		private HttpSession session;
		private File xlsFile;
		private String title;
		private String createUser;
		private File zipFile;
		private String desPath;
		private String webProjectId;
		
		RecCallable(HttpSession session,File xlsFile,String title,String createUser,File zipFile,String desPath,String webProjectId) {
			this.session =session;
	    	this.xlsFile = xlsFile;
	    	this.title = title;
	    	this.createUser = createUser;
	    	this.zipFile = zipFile;
	    	this.desPath = desPath;
	    	this.webProjectId = webProjectId;
	    }
	    @Override
	    public Object call() throws Exception {
	    	String resp = "";
	    	try {
	    		if(zipFile != null && StringUtils.isNotBlank(webProjectId)){
	    			projectServices.addRelateImg(session,webProjectId, zipFile, desPath);;
	    		}
	    		if(xlsFile != null){
	    			try {
						projectServices.importProjectData(session, xlsFile, title, createUser);
					} catch (Exception e) {
						projectServices.insertOperateHistory(session, "5", e.getMessage());
					}
	    		}
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	return resp;
	    }
	}
	class ReadCallable implements Callable<Object>{
		private HttpSession session;
		private File xlsFile;
		
		ReadCallable(HttpSession session,File xlsFile) {
			this.session =session;
			this.xlsFile = xlsFile;
		}
		@Override
		public Object call() throws Exception {
			String resp = "";
			try {
				projectServices.importResearchInfo(xlsFile, session);
				appService.initResearchNo();
			} catch (Exception e) {
				e.printStackTrace();
				operateHistoryService.insertOH(session, "20", e.getMessage(),0);
			}
			return resp;
		}
	}
	class GeoCallable implements Callable<Object>{
		private String attrId;
		private HttpSession session;
		private String key;
		GeoCallable(String attrId,HttpSession session,String key) {
			this.attrId = attrId;
			this.session =session;
			this.key =key;
		}
		@Override
		public Object call() throws Exception {
			String resp = "";
			try {
				projectServices.geoDetailAddr(attrId,session,key);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return resp;
		}
	}
	/*
	 * 采用spring提供的上传文件的方法
	 */
	@RequestMapping("uploadFile")
	public void uploadFile(HttpServletRequest request,HttpServletResponse response) throws IllegalStateException, IOException {
    	String msg = null;
    	HttpSession session=request.getSession();
    	String userId = session.getAttribute("userId")+"";
    	Map<String, String> map = new HashMap<String, String>();
    	mapper = new ObjectMapper();
		String webProjectId = request.getParameter("projrctId");
		String title = request.getParameter("importTitle");
		String comment = request.getParameter("importComment");
		try{
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
			if (multipartResolver.isMultipart(request)) {
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				Iterator iter = multiRequest.getFileNames();
				File xlsFile = null;
				String xlsPath = "";
				File zipFile = null;
				String zipPath = "";
				String desPath = "";//解压路径
				while (iter.hasNext()) {
					// 一次遍历所有文件
					MultipartFile file = multiRequest.getFile(iter.next().toString());
					if (file != null) {
	//					String path = "E:/springUpload" + file.getOriginalFilename();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						Date d = new Date();  
				        String dateNowStr = sdf.format(d);
				        String uploadPath = customConfig.getClientFileUpladPath()+File.separator+dateNowStr;
				        File uploadPathFile =new File(uploadPath);
						if(!uploadPathFile.exists() && !uploadPathFile.isDirectory() ){
							uploadPathFile.mkdir();
						}
						//xls
						String path=customConfig.getClientFileUpladPath()+File.separator+dateNowStr+File.separator+new Date().getTime()+file.getOriginalFilename();
						// 上传
						file.transferTo(new File(path));
						if(StringUtils.isNotBlank(webProjectId)){
							if((file.getOriginalFilename()).contains(".zip")){
								zipFile = new File(path);
								desPath = uploadPath+File.separator+zipFile.getName();
							}
						}else{
							if((file.getOriginalFilename()).contains(".xls")){//上传EXCEL文件
								xlsFile = new File(path);
								xlsPath = path;
							}
						}
					}
	
				}
				if(xlsFile != null || zipFile != null){
					if(zipFile != null){
						if(StringUtils.isBlank(webProjectId)){
							msg = "项目参数有误！";
						}else{
							if(!projectServices.checkSetImg(webProjectId)){
								msg = "请先设置项目图片属性，再提交图片数据！";
							}
						}
					}
					if(msg == null){
						//线程处理
						RecCallable cb = new RecCallable(session, xlsFile, title, userId,zipFile,desPath,webProjectId);
						threadPool.submit(cb);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			msg = e.getMessage();
		}
		map.put("success", "true");
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "保存失败：" + msg);
		}
//		printData(response, mapper.writeValueAsString(map));
		writeJson(map, response);
	}
    
    @RequestMapping("listImport")
    public void listImport(HttpServletRequest request,HttpServletResponse response){
		String startParam = request.getParameter("start");
		String limitParam = request.getParameter("limit");
		String projectName = request.getParameter("projectName");
		String startDate = request.getParameter("createDateStart");
		String endDate = request.getParameter("createDateEnd");
		int start = 0;
		int limit = 20;
		if(StringUtils.isNotBlank(startParam)){
			start = Integer.parseInt(startParam);
		}
		if(StringUtils.isNotBlank(limitParam)){
			limit = Integer.parseInt(limitParam);
		}
		Page<Map<String, Object>> page = projectServices.getProjectMain(projectName, start, limit, startDate, endDate);
		resultSuccess(null, page.getResult(), page.getTotalCount(),response);
	}
    @RequestMapping("listAttr")
    public void listAttr(HttpServletRequest request,HttpServletResponse response){
    	String startParam = request.getParameter("start");
    	String limitParam = request.getParameter("limit");
    	String projectId = request.getParameter("projectId");
    	int start = 0;
    	int limit = 100;
    	if(StringUtils.isNotBlank(startParam)){
    		start = Integer.parseInt(startParam);
    	}
    	if(StringUtils.isNotBlank(limitParam)){
    		limit = Integer.parseInt(limitParam);
    	}
    	Page<Map<String, Object>> page = projectServices.getProjectAttr(projectId, start, limit);
    	resultSuccess(null, page.getResult(), page.getTotalCount(),response);
    }
    
    @RequestMapping("saveAttrType")
    public void saveAttrType(HttpServletRequest request,HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException{
    	HttpSession session=request.getSession();
    	String msg = null;
    	Map<String, String> map = new HashMap<String, String>();
    	mapper = new ObjectMapper();
		String json = request.getParameter("json");
		if(StringUtils.isNotBlank(json)){
			List<Map<String, Object>> paramList = mapper.readValue(json, List.class);
			Map<String, Object> pMap = new HashMap<String, Object>();
			String id = "";
			String typeName = "";
			String infoTypeName = "";
			if(paramList != null && paramList.size() > 0){
				for(int i=0;i<paramList.size();i++){
					pMap = paramList.get(i);
					id = pMap.get("id")+"";
					typeName = pMap.get("type_name")+"";
					infoTypeName = pMap.get("info_type_name")+"";
					projectServices.updateAttrType(id, typeName,infoTypeName);
					if("详细地址".equals(typeName)){//进行地址解析
						String key = customConfig.getBaiduapikey();
						GeoCallable gc = new GeoCallable(id,session,key);
						threadPool.submit(gc);
					}
				}
			}
		}else{
			msg = "没有更改数据";
		}
		
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "保存失败：" + msg);
		}
		writeJson(map, response);
	}
    
    @RequestMapping("getAttrType")
    public void getAttrType(HttpServletRequest request,HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException{
    	String type = request.getParameter("type");
    	int typeInt = type == null?0:Integer.parseInt(type);
    	Page<Map<String, Object>> page = projectServices.getAttrType(typeInt);
    	resultSuccess(null, page.getResult(), page.getTotalCount(),response);
    }
    @RequestMapping("setAttrActive")
    public void setAttrActive(HttpServletRequest request,HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException{
    	//TODO 重选之后筛选权限失效BUG getMapInfo
    	String msg = null;
    	Map<String, String> map = new HashMap<String, String>();
    	mapper = new ObjectMapper();
    	String json = request.getParameter("json");
    	String projectId = request.getParameter("projectId");
    	if(StringUtils.isNotBlank(json)){
    		List<Map<String, Object>> olist = projectServices.getAttrInfoByProjectId(projectId);
    		List<Map<String, Object>> paramList = mapper.readValue(json, List.class);
    		Map<String, Object> pMap = new HashMap<String, Object>();
    		List<String> addList = new ArrayList<String>();
    		String id = "";
    		if(paramList != null && paramList.size() > 0 && olist != null && olist.size() > 0){
    			//有更改，先全部删除项目相关condition，并把attribute初始化,再添加新选择condition
    			projectServices.delConditionByProjectId(projectId);
    			for(int i=0;i<paramList.size();i++){
    				pMap = paramList.get(i);
    				id = pMap.get("id")+"";
    				addList.add(id);
    			}
    			if(addList != null && addList.size()>0){
    				for(String attrId:addList){
    					projectServices.setAttrActive(attrId,1);
    				}
    				projectServices.addCondition(addList,projectId);
    			}
    		}
    	}else{
    		msg = "没有待更改数据";
    	}
    	
    	if (msg == null) {
    		map.put("i_type", "success");
    		map.put("i_msg", "");
    	} else {
    		map.put("i_type", "error");
    		map.put("i_msg", "保存失败：" + msg);
    	}
    	writeJson(map, response);
    }
    @RequestMapping("setAttrActive_bak")
    public void setAttrActive_bak(HttpServletRequest request,HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException{
    	String msg = null;
    	Map<String, String> map = new HashMap<String, String>();
    	mapper = new ObjectMapper();
    	String json = request.getParameter("json");
    	String projectId = request.getParameter("projectId");
    	if(StringUtils.isNotBlank(json)){
    		List<Map<String, Object>> olist = projectServices.getAttrInfoByProjectId(projectId);
    		List<Map<String, Object>> paramList = mapper.readValue(json, List.class);
    		Map<String, Object> pMap = new HashMap<String, Object>();
    		String id = "";
    		if(paramList != null && paramList.size() > 0 && olist != null && olist.size() > 0){
    			List<String> addList = new ArrayList<String>();//attrId
    			List<String> delList = new ArrayList<String>();
    			String oid = "";
    			String oactive = "";
    			Map<String,String> oMap = new HashMap<String, String>();
    			Map<String,String> sMap = new HashMap<String, String>();
    			//生成两个map或者list再进行对比
    			for(int k=0;k<olist.size();k++){//生成筛选条件，判断之前是否已经生成，或者之前生成的现在要删除
    				pMap = olist.get(k);
    				oid = pMap.get("id")+"";
    				oactive = pMap.get("attribute_active")+"";
    				oMap.put(oid, oactive);
    			}
    			for(int i=0;i<paramList.size();i++){
    				pMap = paramList.get(i);
    				id = pMap.get("id")+"";
    				sMap.put(id, "1");
    			}
    			for (Map.Entry<String,String> entry : oMap.entrySet()) {  
//				    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
    				if("0".equals(entry.getValue())){//之前没有设置筛选
    					if(sMap.containsKey(entry.getKey())){//本次设置筛选
    						addList.add(entry.getKey());
    					}
    				}else{//之前设置筛选
    					if(sMap.containsKey(entry.getKey())){//本次设置筛选
//							addList.add(entry.getKey());
    					}else{
    						delList.add(entry.getKey());
    					}
    				}
    			} 
    			if(addList != null && addList.size()>0){
    				for(int i=0;i<addList.size();i++){//添加筛选条件
    					projectServices.setAttrActive(addList.get(i),1);
    				}
    				projectServices.addCondition(addList,projectId);
    			}
    			if(delList != null && delList.size()>0){
    				for(int i=0;i<delList.size();i++){//删除筛选条件
    					projectServices.setAttrActive(delList.get(i),0);
    				}
    				projectServices.delCondition(delList);
    			}
    		}
    	}else{
    		msg = "没有待更改数据";
    	}
    	
    	if (msg == null) {
    		map.put("i_type", "success");
    		map.put("i_msg", "");
    	} else {
    		map.put("i_type", "error");
    		map.put("i_msg", "保存失败：" + msg);
    	}
    	writeJson(map, response);
    }
    
    @RequestMapping("deleteProjectById")
    public void deleteProjectById(HttpServletRequest request,HttpServletResponse response) throws JsonParseException, JsonMappingException, IOException{
    	String msg = null;
    	Map<String, String> map = new HashMap<String, String>();
    	String projectId = request.getParameter("id");
    	if(StringUtils.isNotBlank(projectId)){
    		try {
				projectServices.deleteProjectById(projectId);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			}
    	}else{
    		msg = "id参数为空";
    	}
    	if (msg == null) {
    		map.put("i_type", "success");
    		map.put("i_msg", "");
    	} else {
    		map.put("i_type", "error");
    		map.put("i_msg", "操作失败：" + msg);
    	}
    	writeJson(map, response);
    }
    
    
    @RequestMapping("listSearchNo")
	@ResponseBody
	public void listSearchNo(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		Map<String,String> condition = new HashMap<String, String>();
		String searchNo = request.getParameter("searchNo");
		String searchName = request.getParameter("searchName");
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		
		String msg = null;
		if(StringUtils.isNotBlank(searchNo)){
			condition.put("searchNo", searchNo);
		}
		if(StringUtils.isNotBlank(searchName)){
			condition.put("searchName", searchName);
		}
		if (StringUtils.isNotBlank(start)) {
			condition.put("start", start);
		}
		if (StringUtils.isNotBlank(limit)) {
			condition.put("limit", limit);
		}
		Page<Map<String, Object>> page = new Page<Map<String,Object>>();
		try {
			page = projectServices.getSearchNoDictionary(condition);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		resultSuccess("", page.getResult(), page.getTotalCount(),response);
	}
    @RequestMapping("editReachInfo")
	@ResponseBody
	public void editReachInfo(HttpServletRequest request,HttpServletResponse response){
    	String id = request.getParameter("id");
    	String no = request.getParameter("no");
    	String name = request.getParameter("name");
    	String msg = null;
    	try {
			if (StringUtils.isNotBlank(id)) {//编辑
				projectServices.updateResearchInfoById(id, no, name);
			} else {//新增
				projectServices.addResearchInfo(no, name);
			} 
			appService.initResearchNo();
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
    	Map<String, String> map = new HashMap<String, String>();
    	if (msg == null) {
    		map.put("i_type", "success");
    		map.put("i_msg", "");
    	} else {
    		map.put("i_type", "error");
    		map.put("i_msg", "操作失败：" + msg);
    	}
    	writeJson(map, response);
    }
    
    @RequestMapping("deleteResearchInfo")
    @ResponseBody
    public void deleteResearchInfo(HttpServletRequest request,HttpServletResponse response){
    	String id = request.getParameter("id");
    	String msg = null;
    	try {
    		if (StringUtils.isNotBlank(id)) {//编辑
    			projectServices.deleteResearchInfoById(id);
    			appService.initResearchNo();
    		}else{
    			msg = "参数异常";
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    		msg = e.getMessage();
    	}
    	Map<String, String> map = new HashMap<String, String>();
    	if (msg == null) {
    		map.put("i_type", "success");
    		map.put("i_msg", "");
    	} else {
    		map.put("i_type", "error");
    		map.put("i_msg", "操作失败：" + msg);
    	}
    	writeJson(map, response);
    }
    
    /*
	 * 采用spring提供的上传文件的方法
	 */
	@RequestMapping("uploadSearchNoInfoFile")
	public void uploadSearchNoInfoFile(HttpServletRequest request,HttpServletResponse response) throws IllegalStateException, IOException {
    	String msg = null;
    	HttpSession session=request.getSession();
    	Map<String, String> map = new HashMap<String, String>();
    	mapper = new ObjectMapper();
		try{
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
			if (multipartResolver.isMultipart(request)) {
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				Iterator iter = multiRequest.getFileNames();
				File xlsFile = null;
				while (iter.hasNext()) {
					// 一次遍历所有文件
					MultipartFile file = multiRequest.getFile(iter.next().toString());
					if (file != null) {
	//					String path = "E:/springUpload" + file.getOriginalFilename();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						Date d = new Date();  
				        String dateNowStr = sdf.format(d);
				        String uploadPath = customConfig.getClientFileUpladPath()+File.separator+dateNowStr;
				        File uploadPathFile =new File(uploadPath);
						if(!uploadPathFile.exists() && !uploadPathFile.isDirectory() ){
							uploadPathFile.mkdir();
						}
						//xls
						String path=customConfig.getClientFileUpladPath()+File.separator+dateNowStr+File.separator+new Date().getTime()+file.getOriginalFilename();
						// 上传
						file.transferTo(new File(path));
						if((file.getOriginalFilename()).contains(".xls")){//上传EXCEL文件
							xlsFile = new File(path);
							ReadCallable rc = new ReadCallable(session, xlsFile);
							threadPool.submit(rc);
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			msg = e.getMessage();
		}
		map.put("success", "true");
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "操作失败：" + msg);
		}
		writeJson(map, response);
	}
   
	@RequestMapping("listQuestionTypeColor")
	@ResponseBody
	public void listQuestionTypeColor(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		Map<String,String> condition = new HashMap<String, String>();
		String questionType = request.getParameter("questionType");
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		
		String msg = null;
		if(StringUtils.isNotBlank(questionType)){
			condition.put("questionType", questionType);
		}
		if (StringUtils.isNotBlank(start)) {
			condition.put("start", start);
		}
		if (StringUtils.isNotBlank(limit)) {
			condition.put("limit", limit);
		}
		Page<Map<String, Object>> page = new Page<Map<String,Object>>();
		try {
			page = projectServices.getQuestionType(condition);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		resultSuccess("", page.getResult(), page.getTotalCount(),response);
	}
	
	
	@RequestMapping("getColor")
	@ResponseBody
	public void getColor(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		String msg = null;
		String isAll = request.getParameter("all");
		ObjectMapper mapper = new ObjectMapper();
		List<ModuleStoreBean> list = new ArrayList<ModuleStoreBean>();
		list = projectServices.getColor();
		StringBuffer sb = new StringBuffer("");
		ModuleStoreBean dv = new ModuleStoreBean();
		dv.setText("全部");
		dv.setValue("0");
		sb.append("{'totalCount':'" + list.size()+ "','products':[");
		if ("1".equals(isAll)) {
			sb.append(mapper.writeValueAsString(dv));
		}
		if(list != null){
			if ("1".equals(isAll)) {
				sb.append(",");
			}
			for(int i=0;i<list.size();i++){
				sb.append(mapper.writeValueAsString(list.get(i)));
				if((i+1) == list.size()){
				}else{
					sb.append(",");
				}
			}
		}
		sb.append("]}");
		printData(response, sb.toString());
	}
	
	@RequestMapping("editQuestionColor")
	@ResponseBody
	public void editQuestionColor(HttpServletRequest request,HttpServletResponse response){
    	String id = request.getParameter("id");
    	String question = request.getParameter("question");
    	String color = request.getParameter("color");
    	String msg = null;
    	try {
			if (StringUtils.isNotBlank(id)) {//编辑
				projectServices.updateQuestionColorById(id, question, color);
			} else {//新增
				projectServices.addQuestionColorById(question, color);
			} 
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
    	Map<String, String> map = new HashMap<String, String>();
    	if (msg == null) {
    		map.put("i_type", "success");
    		map.put("i_msg", "");
    	} else {
    		map.put("i_type", "error");
    		map.put("i_msg", "操作失败：" + msg);
    	}
    	writeJson(map, response);
    }
	
	 @RequestMapping("deleteQuestionTypeById")
	    @ResponseBody
	    public void deleteQuestionTypeById(HttpServletRequest request,HttpServletResponse response){
	    	String id = request.getParameter("id");
	    	String msg = null;
	    	try {
	    		if (StringUtils.isNotBlank(id)) {//编辑
	    			projectServices.deleteQuestionTypeById(id);
	    		}else{
	    			msg = "参数异常";
	    		}
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    		msg = e.getMessage();
	    	}
	    	Map<String, String> map = new HashMap<String, String>();
	    	if (msg == null) {
	    		map.put("i_type", "success");
	    		map.put("i_msg", "");
	    	} else {
	    		map.put("i_type", "error");
	    		map.put("i_msg", "操作失败：" + msg);
	    	}
	    	writeJson(map, response);
	    }
}
