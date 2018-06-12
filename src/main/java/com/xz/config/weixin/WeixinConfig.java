package com.xz.config.weixin;

import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.github.wxpay.sdk.WXPayConfig;
import com.xz.entity.CustomConfig;

@Component
public class WeixinConfig implements WXPayConfig{
	
	@Autowired  
    private CustomConfig customConfig; 
	
	@Override
	public String getAppID() {
		return customConfig.getAppid();
	}

	@Override
	public String getMchID() {
		return customConfig.getMchid();
	}
	
	@Override
	public InputStream getCertStream() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getHttpConnectTimeoutMs() {
		return 10*1000;
	}

	@Override
	public int getHttpReadTimeoutMs() {
		return 10*1000;
	}

	@Override
	public String getKey() {
		return customConfig.getAeskeycode();
	}


}
