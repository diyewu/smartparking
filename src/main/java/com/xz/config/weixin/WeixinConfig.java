package com.xz.config.weixin;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
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
//		String certPath = "E:\OnMyWay\微信公众号\qlvip\cert\cert";
        File file = new File(customConfig.getCertpath());
        InputStream certStream = null;
		try {
			certStream = new FileInputStream(file);
			certStream.close();	
		} catch (Exception e1) {
			e1.printStackTrace();
		}
        return certStream;
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
