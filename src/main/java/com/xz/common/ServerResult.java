package com.xz.common;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

/**
 *  0：成功
    1：未知服务器错误
    10000：缺少token参数
    10001：token超时，请重新登陆
    10002：非法token
    20000：登陆名或密码错误
    20001：当前设备不允许登陆
    20002：当前设备没有登陆用户
    20003:当前账户已经失效
    30000:参数校验失败
    40000:微信绑定失败
    
    -----------------------smartparking----------------------
    50000:车主信息不能为空
    50001:场地管理员或后台操作管理员不能同时为空
    50002：车辆信息未注册
    50003：未查询到停车状态中的订单
    
 * @author 吴迪叶
 *
 */
public class ServerResult {
	public final static int RESULT_SUCCESS = 0;// success
	public final static int RESULT_SERVER_ERROR = 1;//未知服务器错误
	
	public final static String RESULT_SERVER_ERROR_MSG = "未知服务器错误";
	
	public final static int RESULT_MISSSING_TOKEN = 10000;
	public final static String RESULT_MISSSING_TOKEN_MSG = "缺少token参数";
	
	public final static int RESULT_TOKEN_OVERTIME = 10001;
	public final static String RESULT_TOKEN_OVERTIME_MSG = "token超时或者没有登陆，请重新登陆";
	
	public final static int RESULT_TOKEN_CHECK_ERROR = 10002;
	public final static String RESULT_TOKEN_CHECK_ERROR_MSG = "非法token";
	
	public final static int RESULT_ERROE_USER_LOGIN = 20000;
	public final static String RESULT_ERROE_USER_LOGIN_MSG = "登陆名或密码错误";
	
	public final static int RESULT_CHECK_PHONE_ERROE = 20001;
	public final static String RESULT_CHECK_PHONE_ERROE_MSG = "当前设备不允许登陆";
	
	public final static int RESULT_CHECK_PHONE_USER_ERROE = 20002;
	public final static String RESULT_CHECK_PHONE_USER_ERROE_MSG = "当前设备没有登陆用户";
	
	public final static int RESULT_CHECK_USER_EXPIRY_DATE_ERROE = 20003;
	public final static String RESULT_CHECK_USER_EXPIRY_DATE_ERROE_MSG = "当前账户已经失效";
	
	public final static int RESULT_ERROE_PARAM = 30000;
	public final static String RESULT_ERROE_PARAM_MSG = "参数校验失败";
	
	public final static int RESULT_GETWXINFO_ERROR = 40000;
	public final static String RESULT_GETWXINFO_ERROR_MSG = "微信绑定失败";
	
	public final static int RESULT_OWNERINFO_ERROR = 50000;
	public final static String RESULT_OWNERINFO_ERROR_MSG = "车主信息不能为空";
	
	public final static int RESULT_PARK_BLANK_ERROR = 50001;
	public final static String RESULT_PARK_BLANK_ERROR_MSG = "场地管理员或后台操作管理员不能同时为空";
	
	public final static int RESULT_CAR_NOT_REGIST_ERROR = 50002;
	public final static String RESULT_CAR_NOT_REGIST_ERROR_MSG = "车辆信息未注册";
	
	public final static int RESULT_ORDER_DONOT_EXSIT_ERROR = 50003;
	public final static String RESULT_ORDER_DONOT_EXSIT_ERROR_MSG = "未查询到停车状态中的订单";
	
	public static Map<Integer,String> ServerResultMap = new HashMap<Integer, String>();
	static{
		ServerResultMap.put(RESULT_SUCCESS, "success");
		ServerResultMap.put(RESULT_MISSSING_TOKEN, RESULT_MISSSING_TOKEN_MSG);
		ServerResultMap.put(RESULT_TOKEN_OVERTIME, RESULT_TOKEN_OVERTIME_MSG);
		ServerResultMap.put(RESULT_TOKEN_CHECK_ERROR, RESULT_TOKEN_CHECK_ERROR_MSG);
		ServerResultMap.put(RESULT_ERROE_USER_LOGIN, RESULT_ERROE_USER_LOGIN_MSG);
		ServerResultMap.put(RESULT_CHECK_PHONE_ERROE, RESULT_CHECK_PHONE_ERROE_MSG);
		ServerResultMap.put(RESULT_CHECK_PHONE_USER_ERROE, RESULT_CHECK_PHONE_USER_ERROE_MSG);
		ServerResultMap.put(RESULT_ERROE_PARAM, RESULT_ERROE_PARAM_MSG);
		ServerResultMap.put(RESULT_CHECK_USER_EXPIRY_DATE_ERROE, RESULT_CHECK_USER_EXPIRY_DATE_ERROE_MSG);
		ServerResultMap.put(RESULT_GETWXINFO_ERROR, RESULT_GETWXINFO_ERROR_MSG);
		//-----------------------------------------------------------------------
		ServerResultMap.put(RESULT_OWNERINFO_ERROR, RESULT_OWNERINFO_ERROR_MSG);
		ServerResultMap.put(RESULT_PARK_BLANK_ERROR, RESULT_PARK_BLANK_ERROR_MSG);
		ServerResultMap.put(RESULT_CAR_NOT_REGIST_ERROR, RESULT_CAR_NOT_REGIST_ERROR_MSG);
		ServerResultMap.put(RESULT_ORDER_DONOT_EXSIT_ERROR, RESULT_ORDER_DONOT_EXSIT_ERROR_MSG);
	}
	
	
	public static String getCodeMsg(int code,String defaultValue){
		String msg = null;
		msg = ServerResultMap.get(code);
		if(StringUtils.isBlank(msg)){
			msg = defaultValue;
		}
		return msg;
	}
}
