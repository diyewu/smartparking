package com.xz.controller;

import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;

import com.xz.common.ServerResult;
import com.xz.common.Simp2TranUtils;
import com.xz.entity.AppLoginBean;
import com.xz.utils.AgingCache;


public class BaseController {
	protected void writeJson(Object obj,HttpServletResponse response) {
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		try {
			mapper.writeValue(response.getOutputStream(), obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 功能：公共方法用于响应前台请求
	 * 
	 * @param response
	 * @param data
	 */
	protected void printData(HttpServletResponse response, String data) {
		try {
			// System.out.println(data);
			response.setContentType("text/html;charset=utf-8");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = new PrintWriter(new OutputStreamWriter(
					response.getOutputStream(), "UTF-8"));
			out.println(data);
			out.close();
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 功能：公共方法用于响应前台请求
	 * 
	 * @param response
	 * @param data
	 */
	protected void printData(HttpServletResponse response, Object data) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			// System.out.println(data);
			response.setContentType("text/html;charset=utf-8");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = new PrintWriter(new OutputStreamWriter(response.getOutputStream(), "UTF-8"));
			out.println(mapper.writeValueAsString(data));
			out.close();
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void resultSuccess(String message, Object data, long total,HttpServletResponse response) {
		Result result = new Result();
		result.setSuccess(true);
		result.setMessage(Simp2TranUtils.simp2tran(message));
		result.setData(data);
		result.setTotal((int) total);
		writeJson(result,response);
	}
	
	protected int globalCheck(List<String> paramList,String token,String phoneId,AppLoginBean appLoginBean) {
		int code = 0;
		if(paramList != null && paramList.size()>0){
			for(String param:paramList){
				if(StringUtils.isBlank(param)){
					code = ServerResult.RESULT_ERROE_PARAM;
					break;
				}
			}
		}
		if(code == 0){
			String lastToken = "";
			try {
				AppLoginBean appLoginBeanTemp = (AppLoginBean) AgingCache.getCacheInfo(phoneId).getValue();
				appLoginBean.setUserId(appLoginBeanTemp.getUserId());
				appLoginBean.setToken(appLoginBeanTemp.getToken());
				appLoginBean.setUserRoleId(appLoginBeanTemp.getUserRoleId());
			} catch (Exception e) {
				code = ServerResult.RESULT_TOKEN_OVERTIME;
			}
			if (code == 0) {
				AgingCache.updateCacheTimeOut(phoneId);
				lastToken = appLoginBean.getToken();
				if(!token.equals(lastToken)){
					code = ServerResult.RESULT_TOKEN_CHECK_ERROR;
				}
			}
		}
		
		return code;
		
	}
	protected int miniGlobalCheck(List<String> paramList,String token,String randomKey,AppLoginBean appLoginBean) {
		System.out.println("miniGlobalCheck__token="+token);
		int code = 0;
		if(paramList != null && paramList.size()>0){
			for(String param:paramList){
				if(StringUtils.isBlank(param)){
					code = ServerResult.RESULT_ERROE_PARAM;
					break;
				}
			}
		}
		if(code == 0){
			String lastToken = "";
			try {
				AppLoginBean appLoginBeanTemp = (AppLoginBean) AgingCache.getCacheInfo(randomKey).getValue();
				appLoginBean.setUserId(appLoginBeanTemp.getUserId());
				appLoginBean.setToken(appLoginBeanTemp.getToken());
				appLoginBean.setUserRoleId(appLoginBeanTemp.getUserRoleId());
			} catch (Exception e) {
				code = ServerResult.RESULT_TOKEN_OVERTIME;
			}
			if (code == 0) {
				AgingCache.updateCacheTimeOut(randomKey);
				lastToken = appLoginBean.getToken();
				if(!token.equals(lastToken)){
					code = ServerResult.RESULT_TOKEN_CHECK_ERROR;
				}
			}
		}
		
		return code;
		
	}
	
	
	
	public static class Result {
		private boolean success;

		private String message;

		private String multilineMsg;

		public String getMultilineMsg() {
			return multilineMsg;
		}

		public void setMultilineMsg(String multilineMsg) {
			this.multilineMsg = multilineMsg;
		}

		private Object data;

		private int total;

		private Object attachment;

		public Object getAttachment() {
			return attachment;
		}

		public void setAttachment(Object attachment) {
			this.attachment = attachment;
		}

		public boolean isSuccess() {
			return success;
		}

		public void setSuccess(boolean success) {
			this.success = success;
		}

		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}

		public Object getData() {
			return data;
		}

		public void setData(Object data) {
			this.data = data;
		}

		public int getTotal() {
			return total;
		}

		public void setTotal(int total) {
			this.total = total;
		}
	}
}
