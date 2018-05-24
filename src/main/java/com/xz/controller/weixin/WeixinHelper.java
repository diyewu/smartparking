package com.xz.controller.weixin;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.thoughtworks.xstream.XStream;
import com.xz.controller.weixin.message.response.TextMessage;
import com.xz.utils.AgingCache;
import com.xz.utils.HttpsUtil;

public class WeixinHelper {

	public static void main(String[] args) {
		System.out.println(getAccessToken("wxc03cad31c1ceb8f3", "d4624c36b6795d1d99dcf0547af5443d"));
	}
	/**
	 * 
	 * @param appId
	 * @param appSecret
	 * @return
	 */
	public static String getAccessToken(String appId,String appSecret){
		ObjectMapper mapper = new ObjectMapper();
		String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxc03cad31c1ceb8f3&secret=d4624c36b6795d1d99dcf0547af5443d";
//		String url = "https://api.weixin.qq.com/cgi-bin/token?";
		String accessToken = "";
		try {
			accessToken = AgingCache.getCacheInfo(WeixinConstants.WEIXIN_TOKEN) != null
					? (String) AgingCache.getCacheInfo(WeixinConstants.WEIXIN_TOKEN).getValue() : null;
			if (StringUtils.isBlank(accessToken)) {
				//到接口中获取
				Map<String, Object> params = new HashMap<String, Object>();
//				params.put("appid", appId);
//				params.put("secret", appSecret);
//				params.put("grant_type", "client_credential");
				String resp = HttpsUtil.doPostSSL(url, params);
				Map<String, Object> map = mapper.readValue(resp, Map.class);
				if (map.containsKey("access_token")) {
					accessToken = (String) map.get("access_token");
					int expiresIn = (Integer) map.get("expires_in");
					AgingCache.putCacheInfo(WeixinConstants.WEIXIN_TOKEN, accessToken, expiresIn / 60 - 1);
				}
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return accessToken;
	}
    /**
     * 将xml转化为Map集合
     * 
     * @param request
     * @return
     */
    public static Map<String, String> xmlToMap(HttpServletRequest request) {
        Map<String, String> map = new HashMap<String, String>();
        SAXReader reader = new SAXReader();
        InputStream ins = null;
        try {
            ins = request.getInputStream();
        } catch (IOException e1) {
            e1.printStackTrace();
        }
        Document doc = null;
        try {
            doc = reader.read(ins);
        } catch (DocumentException e1) {
            e1.printStackTrace();
        }
        Element root = doc.getRootElement();
        @SuppressWarnings("unchecked")
        List<Element> list = root.elements();
        for (Element e : list) {
            map.put(e.getName(), e.getText());
        }
        try {
            ins.close();
        } catch (IOException e1) {
            e1.printStackTrace();
        }
        return map;
    }	
    
    public String processRequest(HttpServletRequest request) {
        Map<String, String> map = xmlToMap(request);
        // 发送方帐号（一个OpenID）
        String fromUserName = map.get("FromUserName");
        // 开发者微信号
        String toUserName = map.get("ToUserName");
        // 消息类型
        String msgType = map.get("MsgType");
        
        
        // 默认回复一个"success"
        String responseMessage = "success";
        // 对消息进行处理
        if (WeixinConstants.MESSAGE_TEXT.equals(msgType)) {// 文本消息
            TextMessage textMessage = new TextMessage();
            textMessage.setMsgType(WeixinConstants.MESSAGE_TEXT);
            textMessage.setToUserName(fromUserName);
            textMessage.setFromUserName(toUserName);
            textMessage.setCreateTime(System.currentTimeMillis());
            textMessage.setContent("我已经受到你发来的消息了");
            responseMessage = textMessageToXml(textMessage);
        }
        return responseMessage;

    }
    
    /**
     * 文本消息转化为xml
     * 
     * @param textMessage
     * @return
     */
    public static String textMessageToXml(TextMessage textMessage) {
        XStream xstream = new XStream();
        xstream.alias("xml", textMessage.getClass());
        return xstream.toXML(textMessage);

    }
	
}
