package com.xz.controller.weixin;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;

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
	
	
	
}
