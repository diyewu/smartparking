package com.xz.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xz.common.Page;
import com.xz.entity.CategoryTreeBean;
import com.xz.entity.CategoryTreeBeanCk;
import com.xz.entity.ModuleStoreBean;
import com.xz.entity.UserLogin;
import com.xz.entity.UserRole;
import com.xz.service.OperateHistoryService;
import com.xz.service.WebUserService;

@RequestMapping("webuser")
@Controller
public class WebUserController extends BaseController {
	@Autowired
	private WebUserService webUserService;
	@Autowired
	private OperateHistoryService operateHistoryService;
	
	
	@RequestMapping("getAuthTree")
	@ResponseBody
	public void getAuthTree(HttpServletRequest request,HttpServletResponse response){
		String roleId = request.getParameter("roleId")+"";
		List<CategoryTreeBeanCk> l = new ArrayList<CategoryTreeBeanCk>();
		l = webUserService.getTreeCKListAuthDo(roleId);
		Map<String,CategoryTreeBeanCk> map = new LinkedHashMap<String,CategoryTreeBeanCk>(); 
		Map<String,CategoryTreeBeanCk> map1 = new LinkedHashMap<String,CategoryTreeBeanCk>(); 
		for(CategoryTreeBeanCk t:l){//list转换成map
			map.put(t.getId(), t);
			map1.put(t.getId(), t);
		}
		CategoryTreeBeanCk c1 = null;
		CategoryTreeBeanCk c2 = null;
		Iterator it = map.keySet().iterator();//遍历map
		while (it.hasNext()) {
			c1 = new CategoryTreeBeanCk();
			c1 = map.get(it.next());
			if(c1.getId() == null ||"null".equals(c1.getId())){//第一级节点
				
			}else{
				if(map1.containsKey(c1.getParent_id())){//
					c2 = new CategoryTreeBeanCk();
					c2 = map1.get(c1.getParent_id());
					if(c2.getChildren() != null){
						c2.getChildren().add(c1);
					}else{
						List<CategoryTreeBeanCk> childrens = new ArrayList<CategoryTreeBeanCk>();
						childrens.add(c1);
						c2.setChildren(childrens);
					}
					map1.remove(c1.getId());
				}
			}
		}
		List<CategoryTreeBeanCk> newList = new ArrayList<CategoryTreeBeanCk>();
		Iterator i = map1.keySet().iterator();
		while (i.hasNext()) {
			newList.add((CategoryTreeBeanCk)map.get(i.next()));
		}
		writeJson(newList, response);
	}
	
	@RequestMapping("listRole")
	@ResponseBody
	public void listRole(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper mapper = new ObjectMapper();
		Map<String,String> condition = new HashMap<String, String>();
		String roleName = request.getParameter("roleName");
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		
		String msg = null;
		if(StringUtils.isNotBlank(roleName)){
			condition.put("roleName", roleName);
		}
		if (StringUtils.isNotBlank(start)) {
			condition.put("start", start);
		}
		if (StringUtils.isNotBlank(limit)) {
			condition.put("limit", limit);
		}
		List<UserRole> list = null;
		StringBuilder sb = new StringBuilder();
		try {
			list = webUserService.getRoleList(condition, sb);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		StringBuffer sbs = new StringBuffer("");
		sbs.append("{'totalCount':'" + sb + "','products':[");
		if(list != null){
			for(int i=0;i<list.size();i++){
				sbs.append(mapper.writeValueAsString(list.get(i)));
				if((i+1) == list.size()){
				}else{
					sbs.append(",");
				}
			}
		}
		sbs.append("]}");
		printData(response, sbs.toString());
	}
	
	@RequestMapping("listUser")
	@ResponseBody
	public void listUser(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper mapper = new ObjectMapper();
		Map<String,String> condition = new HashMap<String, String>();
		String userName = request.getParameter("userName");
		String userRole = request.getParameter("userRole");
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		
		String msg = null;
		if(StringUtils.isNotBlank(userName)){
			condition.put("userName", userName);
		}
		if(StringUtils.isNotBlank(userRole)){
			if(!"0".equals(userRole) && !"全部".equals(userRole)){//2 :全部
				condition.put("userRole", userRole);
			}
		}
		if (StringUtils.isNotBlank(start)) {
			condition.put("start", start);
		}
		if (StringUtils.isNotBlank(limit)) {
			condition.put("limit", limit);
		}
		Page<Map<String, Object>> page = new Page<Map<String,Object>>();
		try {
			page = webUserService.getConsoleUserList(condition);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		resultSuccess("", page.getResult(), page.getTotalCount(),response);
	}
	
	@RequestMapping("getRole")
	public void getRole(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		String msg = null;
		String isAll = request.getParameter("all");
		ObjectMapper mapper = new ObjectMapper();
		List<ModuleStoreBean> list = new ArrayList<ModuleStoreBean>();
		list = webUserService.getRole();
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
//		System.out.println(sb);
		printData(response, sb.toString());
	}
	
	@RequestMapping("editUser")
	@ResponseBody
	public void editUser(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		HttpSession session=request.getSession();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String userPwd = request.getParameter("userPwd");
		String realName = request.getParameter("realName");
		String userRole = request.getParameter("userRole");
		String phoneSize = request.getParameter("phoneSize");
		
		String beginTime = request.getParameter("beginTime") == null?"":request.getParameter("beginTime").substring(0, 10);
		String endTime = request.getParameter("endTime")== null?"":request.getParameter("endTime").substring(0, 10);
		
		String msg = null;
		if(!StringUtils.isNotBlank(userName) || !StringUtils.isNotBlank(userPwd) || 
				!StringUtils.isNotBlank(userRole) || !StringUtils.isNotBlank(realName) 
				|| !StringUtils.isNotBlank(phoneSize) || StringUtils.isBlank(beginTime) || StringUtils.isBlank(endTime)){
			msg = "参数有误!";
		}
		int role = 1;
		int phoneSizeInt = 1;
		if(msg == null ){
			try {
				role = Integer.parseInt(userRole);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			}
		}
		if(msg == null ){
			try {
				phoneSizeInt = Integer.parseInt(phoneSize);
			} catch (Exception e) {
				e.printStackTrace();
				msg = "登录手机数 有误："+e.getMessage();
			}
		}
		if (msg == null) {
			if (!StringUtils.isNotBlank(userId) && !"null".equals(userId)) {//添加用户
				if (!webUserService.isExitUser(userName,"")) {//检查是否存在userName
					if (msg == null) {
						try {
//							userPwd = Md5Util.generatePassword(userPwd);
							webUserService.addUser(userName, userPwd, role,realName,phoneSizeInt,beginTime,endTime);
						} catch (Exception e) {
							e.printStackTrace();
							msg = e.getMessage();
						}
					}
				} else {
					msg = userName + "用户名已存在";
				}
				operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "10", msg,msg==null?1:0);
			} else {//编辑用户
				if (!webUserService.isExitUser(userName,userId)) {
					UserLogin user = new UserLogin();
					if ("******".equals(userPwd)) {//密码没有修改
					} else {
//						userPwd = Md5Util.generatePassword(userPwd);
						user.setUserPassword(userPwd);
					}
					user.setUserName(userName);
					user.setUserRole(role);
					user.setRealName(realName);
					user.setId(userId);
					user.setAllowPhoneSize(phoneSizeInt);
					user.setEnableTime(beginTime);
					user.setDisableTime(endTime);
					try {
						webUserService.editUser(user);
					} catch (Exception e) {
						e.printStackTrace();
						msg = e.getMessage();
					}
				}else{
					msg = userName + "用户名已存在";
				}
				operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "11", msg,msg==null?1:0);
			}
		}
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "保存失败：" + msg);
		}
		printData(response, mapper.writeValueAsString(map));
	}
	
	
	@RequestMapping("updateWebUserAuth")
	public void updateWebUserAuth(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();
		String params = request.getParameter("json");
//		System.out.println("_____"+params);
		String roleId = request.getParameter("roleId");
		
		List<String> paramList = new ArrayList<String>(Arrays.asList(params.split(",")));
		
		
		HttpSession session=request.getSession();
		String msg = null;
		
		if(StringUtils.isNotBlank(params) && StringUtils.isNotBlank(roleId)){
			try {
				webUserService.DeleteWebRoleAuth(roleId);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			}
			if (msg == null) {
				for (String temId : paramList) {
					try {
						webUserService.addWebRoleAuth(roleId, temId);
					} catch (Exception e) {
						e.printStackTrace();
						msg = e.getMessage();
					}
				}
			}
		}else{//没有任何权限
			msg = "参数有误";
		}
		if(msg == null){
			map.put("i_type", "success");
			map.put("i_msg", "");
		}else{
			map.put("i_type", "error");
			map.put("i_msg", msg);
		}
		operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "16", msg,msg==null?1:0);
		this.printData(response, mapper.writeValueAsString(map));
	}
	
	@RequestMapping("deleteRole")
	@ResponseBody
	public void deleteRole(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		HttpSession session=request.getSession();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();
		String roleId = request.getParameter("roleId");
		String sessionRoleId = session.getAttribute("userRole")+"";
		String msg = null;
		if(roleId.equals(sessionRoleId)){
			msg = "当前角色不能删除!";
		}
		if (msg  == null) {
			if (StringUtils.isNotBlank(roleId)) {
				try {
					webUserService.deleteRole(roleId);
				} catch (Exception e) {
					e.printStackTrace();
					msg = e.getMessage();
				}
				if (msg == null) {
					try {
						webUserService.deleteUserByRoleId(roleId);
					} catch (Exception e) {
						e.printStackTrace();
						msg = e.getMessage();
					}
				}
			} else {
				msg = "参数为空！";
			}
		}
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "操作失败：" + msg);
		}
		operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "15", msg,msg==null?1:0);
		this.printData(response, mapper.writeValueAsString(map));
	}
	
	@RequestMapping("editRole")
	@ResponseBody
	public void editRole(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		HttpSession session=request.getSession();
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();
		String roleId = request.getParameter("roleId");
		String roleName = request.getParameter("roleName");
		String msg = null;
		if(!StringUtils.isNotBlank(roleName)){
			msg = "参数有误!";
		}
		if(msg == null){
			if(StringUtils.isNotBlank(roleId)){//roleId 不为空，编辑角色
				if(!webUserService.isExitRole(roleName)){//检查是否存在重复角色名
					try {
						webUserService.editRole(roleId,roleName);
					} catch (Exception e) {
						e.printStackTrace();
						msg = e.getMessage();
					}
				}else{
					msg = roleName + "用户名已存在";
				}
				operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "13", msg,msg==null?1:0);
			}else{//添加用户
				if(!webUserService.isExitRole(roleName)){//检查是否存在重复角色名
					try {
						webUserService.addRole(roleName);
					} catch (Exception e) {
						e.printStackTrace();
						msg = e.getMessage();
					}
				}else{
					msg = roleName + "用户名已存在";
				}
				operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "14", msg,msg==null?1:0);
			}
		}
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "保存失败：" + msg);
		}
		this.printData(response, mapper.writeValueAsString(map));
	}
	
	@RequestMapping("deleteUser")
	@ResponseBody
	public void deleteUser(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		HttpSession session=request.getSession();
		String msg = null;
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();
		String userId = request.getParameter("userId");
		String sessionUserID = (String)session.getAttribute("userId");
		if(sessionUserID.equals(userId)){
			msg = "当前用户不能删除！";
		}
		if (msg == null) {
			if (StringUtils.isNotBlank(userId)) {
				try {
					webUserService.deleteUser(userId);
				} catch (Exception e) {
					e.printStackTrace();
					msg = e.getMessage();
				}
			} else {
				msg = "参数为空！";
			}
		}
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "删除失败：" + msg);
		}
		operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "12", msg,msg==null?1:0);
		this.printData(response, mapper.writeValueAsString(map));
	}
	@RequestMapping("deleteUserPhone")
	@ResponseBody
	public void deleteUserPhone(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		HttpSession session=request.getSession();
		String msg = null;
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();
		String userPhoneId = request.getParameter("userPhoneId");
		if (msg == null) {
			if (StringUtils.isNotBlank(userPhoneId)) {
				try {
					webUserService.deleteUserPhone(userPhoneId);
				} catch (Exception e) {
					e.printStackTrace();
					msg = e.getMessage();
				}
			} else {
				msg = "参数为空！";
			}
		}
		if (msg == null) {
			map.put("i_type", "success");
			map.put("i_msg", "");
		} else {
			map.put("i_type", "error");
			map.put("i_msg", "操作失败：" + msg);
		}
		operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , "19", msg,msg==null?1:0);
		this.printData(response, mapper.writeValueAsString(map));
	}
	
	@RequestMapping("listUserPhone")
	@ResponseBody
	public void listUserPhone(HttpServletRequest request,HttpServletResponse response) throws JsonGenerationException, JsonMappingException, IOException{
		ObjectMapper mapper = new ObjectMapper();
		Map<String,String> condition = new HashMap<String, String>();
		String userRealName = request.getParameter("userRealName");
		String userLoginName = request.getParameter("userLoginName");
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		
		String msg = null;
		if(StringUtils.isNotBlank(userRealName)){
			condition.put("userRealName", userRealName);
		}
		if(StringUtils.isNotBlank(userLoginName)){
			condition.put("userLoginName", userLoginName);
		}
		if (StringUtils.isNotBlank(start)) {
			condition.put("start", start);
		}
		if (StringUtils.isNotBlank(limit)) {
			condition.put("limit", limit);
		}
		Page<Map<String, Object>> page = new Page<Map<String,Object>>();
		try {
			page = webUserService.listUserPhone(condition);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		resultSuccess("", page.getResult(), page.getTotalCount(),response);
	}
}
