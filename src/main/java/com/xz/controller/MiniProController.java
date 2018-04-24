package com.xz.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.xz.common.ServerResult;
import com.xz.entity.AppLoginBean;
import com.xz.entity.AppMenu;
import com.xz.entity.CustomConfig;
import com.xz.model.json.AppJsonModel;
import com.xz.model.json.JsonModel;
import com.xz.service.AppService;
import com.xz.service.OperateHistoryService;
import com.xz.service.ProjectServices;
import com.xz.service.WebService;
import com.xz.utils.AgingCache;
import com.xz.utils.HttpUtil;  
/**
*
* @author dean
*/
@RequestMapping("mini")
@Controller
public class MiniProController extends BaseController{
	@Autowired
	private AppService appService;
	
	@Autowired
	private WebService webService;

	@Autowired
	private ProjectServices projectServices;
	
	@Autowired  
    private CustomConfig customConfig; 
	
	@Autowired
	private OperateHistoryService operateHistoryService;
	
	/**
	 * mini 用户登陆
	 * @param request
	 * @return
	 */
	@RequestMapping("login")
	@ResponseBody
	public AppJsonModel login(HttpServletRequest request){
		String userName = request.getParameter("userName");
		String userPwd = request.getParameter("userPwd");
//		String openId = request.getHeader("openId");
		String token = "";
		String msg = null;
		int code = 0;
		Map<String,String> resultMap = new HashMap<String, String>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(StringUtils.isBlank(userName) || StringUtils.isBlank(userPwd)){
			code = ServerResult.RESULT_ERROE_PARAM;
			msg = ServerResult.RESULT_ERROE_PARAM_MSG;
		}
		String userId = "";
		if(code == 0){
			try {
				list = appService.getUserInfoByNameandPwd(userName, userPwd);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
				code = ServerResult.RESULT_SERVER_ERROR;
			}
		}
		// 服务器无异常
		if(code == 0){
			if(list == null || list.size()==0){
				code = ServerResult.RESULT_ERROE_USER_LOGIN;
			}
		}
		//验证账户是否失效
		if(code == 0){
			userId = list.get(0).get("id")+"";
			String enableTime = list.get(0).get("enable_time")+"";
			String disableTime = list.get(0).get("disable_time")+"";
			if(StringUtils.isNotBlank(enableTime) && StringUtils.isNotBlank(disableTime)){
				Date d = new Date();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				try {
					df.parse(enableTime);
					df.parse(disableTime);
					if(d.getTime() < df.parse(enableTime).getTime() || d.getTime() > df.parse(disableTime).getTime() ){
//						msg = "您好，您的账户已经失效，如需继续使用，请联系管理员。";
						code = ServerResult.RESULT_CHECK_USER_EXPIRY_DATE_ERROE;
					}
				} catch (ParseException e) {
				}
			}else{
//				msg = "您好，您的账户已经失效，如需继续使用，请联系管理员。";
				code = ServerResult.RESULT_CHECK_USER_EXPIRY_DATE_ERROE;
			}
		}
		//绑定微信
		String wxcode = request.getParameter("code");
		String randomkey = request.getParameter("randomkey");
		System.out.println("wxcode="+wxcode);
		if(StringUtils.isNotBlank(wxcode)){
			String appid = customConfig.getAppid();
			String secret = customConfig.getSecret();
			String url = "https://api.weixin.qq.com/sns/jscode2session?appid="+appid+"&secret="+secret+"&js_code="+code+"&grant_type=authorization_code";
			String resp = "";
			try {
//				resp = HttpUtil.httpGetRequest(url , new HashMap<String, Object>());
				resp = HttpUtil.httpGetRequest(url);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> map = new HashMap<String, Object>();
			String openid = "";
			String session_key = "";
			String unionid = "";
			try {
				map = mapper.readValue(resp, Map.class);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(map.containsKey("errcode")){//错误时返回JSON数据包(示例为Code无效)
				code = ServerResult.RESULT_GETWXINFO_ERROR;
			}else{
				randomkey = (String)map.get("openid");
				session_key = (String)map.get("session_key");
				unionid = (String)map.get("unionid");
				//更新绑定信息到数据库
				appService.updateWxBind(userId, randomkey);
			}
		}

		//TODO  判断当前是否已经登陆
		AppLoginBean appLoginBean = new AppLoginBean();
		if(code == 0){
			token = UUID.randomUUID().toString().replaceAll("-", "");
			System.out.println("token="+token);
//			String userId = list.get(0).get("id")+"";
			String roleId = list.get(0).get("user_role")+"";
			String realName = list.get(0).get("real_name")+"";
			resultMap.put("token", token);
			resultMap.put("real_name", realName);
			appLoginBean.setToken(token);
			appLoginBean.setUserId(userId);
			appLoginBean.setUserRoleId(roleId);
			AgingCache.putCacheInfo(randomkey, appLoginBean,30);
		}
//		operateHistoryService.insertOHAPP(request,appLoginBean.getUserId() ,"28", ServerResult.getCodeMsg(code, msg)+",openId="+randomkey, "success".equals(msg)?1:0, 2);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), resultMap);
	}
	
	
	/**
	 * mini 获取菜单信息
	 * @param request
	 * @return
	 */
	@RequestMapping("getMenuByUserRole")
	@ResponseBody
	public AppJsonModel getMenuByUserRole(HttpServletRequest request){
		int code = 0;
		String msg = null;
		String randomKey = request.getParameter("randomkey");
		String token = request.getParameter("token");
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(randomKey);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = miniGlobalCheck(paramList, token, randomKey,appLoginBean);
		List<AppMenu> list = new ArrayList<AppMenu>();
		if(code == 0){
			list = appService.getMenulist(appLoginBean.getUserRoleId());
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	/**
	 * 根据登陆角色，获取初始化项目信息，数据信息为所有有权限项目数据
	 * @param request
	 * @return
	 */
	@RequestMapping("getMapInfoByuserRole")
	@ResponseBody
	public AppJsonModel getMapInfoByuserRole(HttpServletRequest request){
		int code = 0;
		String msg = null;
		String randomKey = request.getParameter("randomkey");
		String token = request.getParameter("token");
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(randomKey);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = miniGlobalCheck(paramList, token, randomKey,appLoginBean);
		List<AppMenu> list = new ArrayList<AppMenu>();
		if(code == 0){
			list = appService.getMenulist(appLoginBean.getUserRoleId());
		}
		List<Map<String, Object>> info = new ArrayList<Map<String,Object>>();
		if(list != null && list.size()>0){
			ObjectMapper mapper = new ObjectMapper();
			try {
				String jsonIds = mapper.writeValueAsString(list);
				if(StringUtils.isNotBlank(jsonIds)){
					JSONArray projectArray = JSONArray.parseArray(jsonIds);
					info = appService.analyzeJson(projectArray, "is_check","mini");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
//				msg = e.getMessage();
				code = ServerResult.RESULT_SERVER_ERROR;
			}
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), info);
	}
	/**
	 * 根据选择菜单获取项目数据信息
	 * @param request
	 * @return
	 */
	@RequestMapping("getMapInfoByMenuInfo")
	@ResponseBody
	public AppJsonModel getMapInfoByMenuInfo(HttpServletRequest request){
		int code = 0;
		String msg = null;
		String randomKey = request.getParameter("randomkey");
		String token = request.getParameter("token");
		String jsonIds = request.getParameter("jsonIds");
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(randomKey);
		paramList.add(jsonIds);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = miniGlobalCheck(paramList, token, randomKey,appLoginBean);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(code == 0){
			JSONArray projectArray = JSONArray.parseArray(jsonIds);
			list = appService.analyzeJson(projectArray, "status","mini");
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	/**
	 * 根据用户选择的坐标点，获取该坐标点的下一级坐标
	 * @param request
	 * @return
	 */
	@RequestMapping("getNextMapInfoByKey")
	@ResponseBody
	public AppJsonModel getNextMapInfoByKey(HttpServletRequest request){
		int code = 0;
		String msg = null;
		String randomKey = request.getParameter("randomkey");
		String token = request.getParameter("token");
		String cacheKey = request.getParameter("cacheKey");
		String key = request.getParameter("key");
		String currentLevel = request.getParameter("currentLevel");
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(randomKey);
		paramList.add(cacheKey);
		paramList.add(currentLevel);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = miniGlobalCheck(paramList, token, randomKey,appLoginBean);
		List<Map<String, Object>> info = new ArrayList<Map<String,Object>>();
		if(code == 0){
			List<Map<String, Object>> tlist = (List<Map<String, Object>>)AgingCache.getCacheInfo(cacheKey).getValue();
			info = appService.generateCod(key,tlist, cacheKey,currentLevel,"mini");
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), info);
	}
	
	/**
	 * 返回上一级坐标
	 * @param request
	 * @return
	 */
	@RequestMapping("getPreMapInfoByKey")
	@ResponseBody
	public AppJsonModel getPreMapInfoByKey(HttpServletRequest request){
		int code = 0;
		String msg = null;
		String randomKey = request.getParameter("randomkey");
		String token = request.getParameter("token");
		
		String cacheKey = request.getParameter("cacheKey");
		String key = request.getParameter("key");
		String currentLevel = request.getParameter("currentLevel");
		
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(randomKey);
		paramList.add(cacheKey);
		paramList.add(currentLevel);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = miniGlobalCheck(paramList, token, randomKey,appLoginBean);
		
		List<Map<String, Object>> info = new ArrayList<Map<String,Object>>();
		if(code == 0){
			info = appService.turnback(cacheKey, key, currentLevel,"mini");
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), info);
	}
	
	
	/**
	 * 根据用户点击地图的点传递project_detail的ID获取详细信息
	 * @param request
	 * @return
	 */
	@RequestMapping("getCoordinateInfo")
	@ResponseBody
	public AppJsonModel getCoordinateInfo(HttpServletRequest request){
		int code = 0;
		String msg = null;
		String randomKey = request.getParameter("randomkey");
		String token = request.getParameter("token");
		String coordinateId = request.getParameter("ids");
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(randomKey);
		paramList.add(coordinateId);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = miniGlobalCheck(paramList, token, randomKey,appLoginBean);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(code == 0){
			try {
				list = appService.getCoordinateInfoByIds(coordinateId);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			}
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	/**
	 * 根据用户输入信息搜索经纬度
	 * @param request
	 * @return
	 */
	@RequestMapping("getGeocoderLatitude")
	@ResponseBody
	public AppJsonModel getGeocoderLatitude(HttpServletRequest request){
		int code = 0;
		String msg = null;
		String randomKey = request.getParameter("randomkey");
		String token = request.getParameter("token");
		String address = request.getParameter("address");
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(randomKey);
		paramList.add(address);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = miniGlobalCheck(paramList, token, randomKey,appLoginBean);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, String> map = new HashMap<String, String>();
		if(code == 0){
			String key = customConfig.getBaiduapikey();
			try {
				map = projectServices.getGeocoderLatitude(address, key);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
			}
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	/**
	 * mini 获取微信信息
	 * @param request
	 * @return
	 */
	@RequestMapping("getUserInfo")
	@ResponseBody
	public AppJsonModel getUserInfo(HttpServletRequest request){
		String code = request.getParameter("code");
		String appid = customConfig.getAppid();
		String secret = customConfig.getSecret();
		
		String url = "https://api.weixin.qq.com/sns/jscode2session?appid="+appid+"&secret="+secret+"&js_code="+code+"&grant_type=authorization_code";
		String resp = "";
		try {
			resp = HttpUtil.httpGetRequest(url , new HashMap<String, Object>());
		} catch (URISyntaxException e1) {
			e1.printStackTrace();
		}
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<String, Object>();
		String openid = "";
		String session_key = "";
		String unionid = "";
		try {
			map = mapper.readValue(resp, Map.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(map.containsKey("errcode")){//错误时返回JSON数据包(示例为Code无效)
			
		}else{
			openid = (String)map.get("openid");
			session_key = (String)map.get("session_key");
			unionid = (String)map.get("unionid");
			
		}
		
		return null;
	}
	
	
	
}
