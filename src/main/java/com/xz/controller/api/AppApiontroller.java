package com.xz.controller.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xz.common.ServerResult;
import com.xz.controller.BaseController;
import com.xz.entity.AppLoginBean;
import com.xz.entity.AppMenu;
import com.xz.model.json.AppJsonModel;
import com.xz.service.AppService;
import com.xz.utils.AgingCache;

import io.swagger.annotations.ApiOperation;

/**
 *
 * @author dean
 */
@RestController
public class AppApiontroller extends BaseController{
	@Autowired
	private AppService webAndAppService;
	
	@ApiOperation(value = "登陆", notes = "测试地址：", httpMethod = "POST")
	@RequestMapping("login")
	@ResponseBody
	public AppJsonModel login(HttpServletRequest request){
		String userName = request.getParameter("userName");
		String userPwd = request.getParameter("userPwd");
		String phoneId = request.getHeader("phoneId");
		String token = "";
		String msg = "success";
		int code = 0;
		Map<String,String> resultMap = new HashMap<String, String>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(StringUtils.isBlank(userName) || StringUtils.isBlank(userPwd) || StringUtils.isBlank(phoneId)){
			code = ServerResult.RESULT_ERROE_PARAM;
			msg = ServerResult.RESULT_ERROE_PARAM_MSG;
		}
		if(code == 0){
			try {
				list = webAndAppService.getUserInfoByNameandPwd(userName, userPwd);
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
		//验证phone是否允许登陆
		if(code == 0){
			int allowSize = list.get(0).get("allow_phone_size") ==null?1:Integer.parseInt(list.get(0).get("allow_phone_size")+"");
			String webUserId = list.get(0).get("id")+"";
			try {
				code = webAndAppService.checkPhoneId(phoneId, allowSize, webUserId);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
				code = ServerResult.RESULT_SERVER_ERROR;
			}
		}
		//TODO  判断当前是否已经登陆
		if(code == 0){
			token = UUID.randomUUID().toString().replaceAll("-", "");
			String userId = list.get(0).get("id")+"";
			String roleId = list.get(0).get("user_role")+"";
			String realName = list.get(0).get("real_name")+"";
			resultMap.put("token", token);
			resultMap.put("real_name", realName);
			AppLoginBean appLoginBean = new AppLoginBean();
			appLoginBean.setToken(token);
			appLoginBean.setUserId(userId);
			appLoginBean.setUserRoleId(roleId);
			AgingCache.putCacheInfo(phoneId, appLoginBean,30);
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), resultMap);
	}
}
