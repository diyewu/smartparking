package com.xz.controller.weixin;

import java.util.TreeMap;

import org.codehaus.jackson.map.ObjectMapper;

import com.xz.controller.weixin.message.response.TemplateMsgResult;
import com.xz.utils.HttpsUtil;

public class MessageHandler {
	private final static String tempLateUrl = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
	public static String processMsg(String content){
		String resp = "如果停留在首页等待，则表示当前为调试时间段，如需测试完整功能，请联系管理员：18936483081 进行开放处理！";
		if("connectus".equals(content)){
			resp = "电话：021-0000000\n地址：上海市黄浦区南苏州路1305号3号门";
		}
		return resp;
	}
	
	/** 
     * 发送模板消息
     * @param accessToken
     * @param data 
     * @return 状态 
     */  
    public static TemplateMsgResult sendTemplate(String accessToken, String data) {  
        TemplateMsgResult templateMsgResult = null;  
        TreeMap<String,String> params = new TreeMap<String,String>();  
        params.put("access_token", accessToken); 
        String url = tempLateUrl.replace("ACCESS_TOKEN", accessToken);
        String resp = HttpsUtil.doPostSSL(url, data);
//        String result = HttpReqUtil.HttpsDefaultExecute(HttpReqUtil.POST_METHOD, WechatConfig.SEND_TEMPLATE_MESSAGE, params, data);  
//        templateMsgResult = JsonUtil.fromJson(result, TemplateMsgResult.class);  
        ObjectMapper objectMapper = new ObjectMapper();
        try {
        	templateMsgResult = objectMapper.readValue(resp, TemplateMsgResult.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return templateMsgResult;  
    }  
}
