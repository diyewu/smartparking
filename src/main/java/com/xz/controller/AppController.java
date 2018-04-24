package com.xz.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xz.common.ServerResult;
import com.xz.entity.AppLoginBean;
import com.xz.entity.AppMenu;
import com.xz.model.json.AppJsonModel;
import com.xz.service.AppService;
import com.xz.service.OperateHistoryService;
import com.xz.utils.AgingCache;



/**
 *
 * @author dean
 */
@RequestMapping("app")
@Controller
public class AppController extends BaseController{
	@Autowired
	private AppService appService;
	
	@Autowired
	private OperateHistoryService operateHistoryService;
	
	/**
	 * APP 用户登陆
	 * @param request
	 * @return
	 */
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
		//验证phone是否允许登陆
		if(code == 0){
			int allowSize = list.get(0).get("allow_phone_size") ==null?1:Integer.parseInt(list.get(0).get("allow_phone_size")+"");
			String webUserId = list.get(0).get("id")+"";
			try {
				code = appService.checkPhoneId(phoneId, allowSize, webUserId);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
				code = ServerResult.RESULT_SERVER_ERROR;
			}
		}
		//TODO  判断当前是否已经登陆
		AppLoginBean appLoginBean = new AppLoginBean();
		if(code == 0){
			token = UUID.randomUUID().toString().replaceAll("-", "");
			String userId = list.get(0).get("id")+"";
			String roleId = list.get(0).get("user_role")+"";
			String realName = list.get(0).get("real_name")+"";
			resultMap.put("token", token);
			resultMap.put("real_name", realName);
			appLoginBean.setToken(token);
			appLoginBean.setUserId(userId);
			appLoginBean.setUserRoleId(roleId);
			AgingCache.putCacheInfo(phoneId, appLoginBean,30);
		}
		operateHistoryService.insertOHAPP(request,appLoginBean.getUserId() ,"28", ServerResult.getCodeMsg(code, msg)+",phoneId="+phoneId, "success".equals(msg)?1:0, 2);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), resultMap);
	}
	
	/**
	 * APP 根据登陆用户获取菜单
	 * @param request
	 * @return
	 */
	@RequestMapping("getMenu")
	@ResponseBody
	public AppJsonModel getMenu(HttpServletRequest request){
		String token = request.getHeader("token");
		String phoneId = request.getHeader("phoneId");
		String msg = "success";
		int code = 0;
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(phoneId);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = globalCheck(paramList, token, phoneId,appLoginBean);
		List<AppMenu> newList = new ArrayList<AppMenu>();
		if(code == 0){
			newList = appService.getMenulist(appLoginBean.getUserRoleId());
		}
//		operateHistoryService.insertOH(request, "29", ServerResult.getCodeMsg(code, msg), "success".equals(msg)?1:0, 2);
		operateHistoryService.insertOHAPP(request,appLoginBean.getUserId() ,"29", ServerResult.getCodeMsg(code, msg)+",phoneId="+phoneId, "success".equals(msg)?1:0, 2);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), newList);
	}
//	@RequestMapping("getMenu")
//	@ResponseBody
	public AppJsonModel getMenu_bak(HttpServletRequest request){
		String token = request.getHeader("token");
		String phoneId = request.getHeader("phoneId");
		String msg = "success";
		int code = 0;
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(phoneId);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = globalCheck(paramList, token, phoneId,appLoginBean);
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(code == 0){
			try {
//				list = webAndAppService.getMenu(appLoginBean.getUserRoleId());
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
				code = ServerResult.RESULT_SERVER_ERROR;
			}
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	
	/**
	 * APP 根据用不选择菜单获取地图点信息
	 * @param request
	 * @return
	 */
	@RequestMapping("getMapInfo")
	@ResponseBody
	public AppJsonModel getMapInfoByMenu(HttpServletRequest request){
		String token = request.getHeader("token");
		String phoneId = request.getHeader("phoneId");
		String jsonIds = request.getParameter("jsonIds");
		String msg = "success";
		int code = 0;
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(phoneId);
		paramList.add(jsonIds);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = globalCheck(paramList, token, phoneId,appLoginBean);
		
		List<Map<String, Object>> info = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		if(code == 0){
			//TODO 根据jsonIds解析树形json
//			String json = "[{\"attributes\":[{\"attribute_id\":\"00151280833338700003\",\"conditions\":[{\"condition_id\":\"442\"},{\"condition_id\":\"443\"}]},{\"attribute_id\":\"00151280833339000011\",\"conditions\":[{\"condition_id\":\"448\"},{\"condition_id\":\"449\"}]}],\"project_id\":\"00151280833337500000\"}]";
//			String json = "[{\"attributes\":[{\"attribute_id\":\"00151324042913000013005056c00001\",\"conditions\":[{\"condition_id\":\"1765\"}]}],\"project_id\":\"00151324042911900000005056c00001\"}]";
			JSONArray projectArray = JSONArray.parseArray(jsonIds);
			String projectId = "";
			Map<String,List<String>> param = new HashMap<String, List<String>>();
			List<String> conditionList = new ArrayList<String>();
			for (int k = 0; k < projectArray.size(); k++) {
				param = new HashMap<String, List<String>>();
				JSONObject jsonObject = projectArray.getJSONObject(k);
				projectId = jsonObject.get("project_id")+"";
				JSONArray array = jsonObject.getJSONArray("attributes");
				if(array != null && array.size()>0){
					for (int i = 0; i < array.size(); i++) {
						conditionList = new ArrayList<String>();
						JSONObject attrObject = array.getJSONObject(i);
						String AttriId = attrObject.getString("attribute_id");
						JSONArray conditionArray = attrObject.getJSONArray("conditions");
						for(int m =0;m<conditionArray.size();m++){
							JSONObject conditionObject = conditionArray.getJSONObject(m);
							conditionList.add(conditionObject.get("condition_id")+"");
						}
						param.put(AttriId, conditionList);
					}
				}
				list = appService.getMapInfo(projectId, param,null,"0",null);
				if (list != null && list.size() > 0) {
					info.addAll(list);
				}
			}
		}
//		operateHistoryService.insertOH(request, "30", ServerResult.getCodeMsg(code, msg), "success".equals(msg)?1:0, 2);
		operateHistoryService.insertOHAPP(request,appLoginBean.getUserId() ,"30", ServerResult.getCodeMsg(code, msg)+",phoneId="+phoneId, "success".equals(msg)?1:0, 2);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), info);
	}
	
	/**
	 * APP 根据当前点击坐标点获取下一级坐标
	 * @param request
	 * @return
	 */
	@RequestMapping("getNextMapInfoByKey")
	@ResponseBody
	public AppJsonModel getNextMapInfoByKey(HttpServletRequest request){
		String token = request.getHeader("token");
		String phoneId = request.getHeader("phoneId");
		
		String cacheKey = request.getParameter("cacheKey");
		String key = request.getParameter("key");
		String currentLevel = request.getParameter("currentLevel");
		
		String msg = "success";
		int code = 0;
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(phoneId);
		paramList.add(cacheKey);
		paramList.add(key);
		paramList.add(currentLevel);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = globalCheck(paramList, token, phoneId,appLoginBean);
		
		List<Map<String, Object>> info = new ArrayList<Map<String,Object>>();
		if(code == 0){
			List<Map<String, Object>> tlist = (List<Map<String, Object>>)AgingCache.getCacheInfo(cacheKey).getValue();
			info = appService.generateCod(key,tlist, cacheKey,currentLevel,null);
		}
//		operateHistoryService.insertOH(request, "31", ServerResult.getCodeMsg(code, msg), "success".equals(msg)?1:0, 2);
		operateHistoryService.insertOHAPP(request,appLoginBean.getUserId() ,"31", ServerResult.getCodeMsg(code, msg)+",phoneId="+phoneId, "success".equals(msg)?1:0, 2);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), info);
	}
	
	/**
	 * APP 根据用户点击坐标获取坐标点详细信息
	 * @param request
	 * @return
	 */
	@RequestMapping("getCoordinateInfo")
	@ResponseBody
	public AppJsonModel getCoordinateInfo(HttpServletRequest request){
		String token = request.getHeader("token");
		String phoneId = request.getHeader("phoneId");
		String coordinateId = request.getParameter("coordinateId");
		String msg = "success";
		int code = 0;
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(phoneId);
		paramList.add(coordinateId);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = globalCheck(paramList, token, phoneId,appLoginBean);
		List<Map<String, Object>> resplist = new ArrayList<Map<String,Object>>();
		if(code == 0){
			try {
				resplist = appService.getCoordinateInfoByIds(coordinateId);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
				code = ServerResult.RESULT_SERVER_ERROR;
			}
		}
//		operateHistoryService.insertOH(request, "32", ServerResult.getCodeMsg(code, msg), "success".equals(msg)?1:0, 2);
		operateHistoryService.insertOHAPP(request,appLoginBean.getUserId() ,"32", ServerResult.getCodeMsg(code, msg)+",phoneId="+phoneId, "success".equals(msg)?1:0, 2);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), resplist);
	}
	
	
	
//	@RequestMapping("getCoordinateInfo")
//	@ResponseBody
	public AppJsonModel getCoordinateInfo_bak(HttpServletRequest request){
		String token = request.getHeader("token");
		String phoneId = request.getHeader("phoneId");
		String coordinateId = request.getParameter("coordinateId");
		String msg = "success";
		int code = 0;
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(phoneId);
		paramList.add(coordinateId);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = globalCheck(paramList, token, phoneId,appLoginBean);
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(code == 0){
			try {
				list = appService.getCoordinateInfo(coordinateId);
			} catch (Exception e) {
				e.printStackTrace();
				msg = e.getMessage();
				code = ServerResult.RESULT_SERVER_ERROR;
			}
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	/**
	 * APP 根据详细信息ID获取图片信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("getImgBydetailId")
	@ResponseBody
	public void getImgBydetailId(HttpServletRequest request,HttpServletResponse response){
        response.setHeader("Pragma", "No-cache"); 
        response.setHeader("Cache-Control", "no-cache"); 
        response.setDateHeader("Expires", 0); 
        response.setContentType("image/jpeg"); 
        String detailId = request.getParameter("id");
        String type = request.getParameter("type");
        if(StringUtils.isBlank(detailId)){
        	return;
        }
        List<Map<String, Object>> list = appService.getImgPath(detailId);
        File imgfile = null;
        if(list != null && list.size()>0){
        	String path = list.get(0).get("img_path")==null?"":list.get(0).get("img_path")+"";
        	if(StringUtils.isNotBlank(path)){
        		if("thumb".equals(type)){
        			String[] imgs = StringUtils.split(path, ".");
        			imgfile = new File(imgs[0]+"_thumb."+imgs[1]);
        		}else{
        			imgfile = new File(path);
        		}
        	}
        }
        if(imgfile != null){
            OutputStream os = null;
            FileInputStream fos = null;
			try {
				os = response.getOutputStream();
				byte[] buffer = new byte[2048];
				fos = new FileInputStream(imgfile.getPath());// 打开图片文件
				int count;
				while ((count = fos.read(buffer)) > 0) {
					os.write(buffer, 0, count);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally{
				try {
					if (os != null)
						os.close();
					if (fos != null)
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
        }
//        operateHistoryService.insertOH(request, "32", ServerResult.getCodeMsg(code, msg), "success".equals(msg)?1:0, 2);
	}
	/**
	 * APP 根据详细信息ID获取图片信息
	 * @param request
	 * @param response
	 */
	@RequestMapping("getImgBydetailIdIo")
	@ResponseBody
	public void getImgBydetailIdIo(HttpServletRequest request,HttpServletResponse response){
		response.setHeader("Pragma", "No-cache"); 
		response.setHeader("Cache-Control", "no-cache"); 
		response.setDateHeader("Expires", 0); 
		response.setContentType("image/jpeg"); 
		String detailId = request.getParameter("id");
		String type = request.getParameter("type");
		if(StringUtils.isBlank(detailId)){
			return;
		}
		List<Map<String, Object>> list = appService.getImgPath(detailId);
		File imgfile = null;
		if(list != null && list.size()>0){
			String path = list.get(0).get("img_path")==null?"":list.get(0).get("img_path")+"";
			if(StringUtils.isNotBlank(path)){
				if("thumb".equals(type)){
					String[] imgs = StringUtils.split(path, ".");
					imgfile = new File(imgs[0]+"_thumb."+imgs[1]);
				}else{
					imgfile = new File(path);
				}
			}
		}
		if(imgfile != null){
			OutputStream os = null;
			FileInputStream fos = null;
			try {
				os = response.getOutputStream();
				byte[] buffer = new byte[2048];
				fos = new FileInputStream(imgfile.getPath());// 打开图片文件
				int count;
				while ((count = fos.read(buffer)) > 0) {
					os.write(buffer, 0, count);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally{
				try {
					if (os != null)
						os.close();
					if (fos != null)
						fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
//        operateHistoryService.insertOH(request, "32", ServerResult.getCodeMsg(code, msg), "success".equals(msg)?1:0, 2);
	}
	
	/**
	 * APP 根据当前级别获取上一级信息
	 * @param request
	 * @return
	 */
	@RequestMapping("getPreMapInfoByKey")
	@ResponseBody
	public AppJsonModel getPreMapInfoByKey(HttpServletRequest request){
		String token = request.getHeader("token");
		String phoneId = request.getHeader("phoneId");
		
		String cacheKey = request.getParameter("cacheKey");
		String key = request.getParameter("key");
		String currentLevel = request.getParameter("currentLevel");
		String msg = "success";
		int code = 0;
		List<String> paramList = new ArrayList<String>();
		paramList.add(token);
		paramList.add(phoneId);
		paramList.add(cacheKey);
		paramList.add(key);
		paramList.add(currentLevel);
		AppLoginBean appLoginBean = new AppLoginBean();
		code = globalCheck(paramList, token, phoneId,appLoginBean);
		
		List<Map<String, Object>> info = new ArrayList<Map<String,Object>>();
		if(code == 0){
			info = appService.turnback(cacheKey, key, currentLevel,null);
		}
//		operateHistoryService.insertOH(request, "34", ServerResult.getCodeMsg(code, msg), "success".equals(msg)?1:0, 2);
		operateHistoryService.insertOHAPP(request,appLoginBean.getUserId() ,"34", ServerResult.getCodeMsg(code, msg)+",phoneId="+phoneId, "success".equals(msg)?1:0, 2);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), info);
	}
	
	
	
	
	//TODO 增加心跳包接口
}
