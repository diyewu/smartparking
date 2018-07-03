package com.xh.mgr.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.github.wxpay.sdk.WXPay;
import com.github.wxpay.sdk.WXPayUtil;
import com.google.common.base.Joiner;
import com.xz.config.weixin.WeixinConfig;
import com.xz.utils.DateHelper;
import com.xz.utils.HttpUtil;

public class MainTest {
	public static void main(String[] args) throws UnsupportedEncodingException, ParseException, InterruptedException {
		urlEncode();
//		timecha();
//		testDownloadBill();
//		System.out.println(Double.parseDouble("1")/100);
	}
	
	public static void testDownloadBill(){
		String url  = "https://zhonglestudio.cn/smartparking/wepay/downloadBill/";
		HttpUtil.httpPostRequest(url);
	}
	
	
	/**
	 * 获取沙箱验证码
	 */
	public static void getSandBoxKey(){
		String url = "https://api.mch.weixin.qq.com/sandboxnew/pay/getsignkey";
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("mch_id", "1505894581");
		data.put("nonce_str", WXPayUtil.generateNonceStr());
		try {
			data.put("sign", WXPayUtil.generateSignature(data, "sJTfkjIzdiBHndKASC8V3fFbqm1o7LDp"));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			System.out.println(requestWithoutCert(url, data, 10*1000, 10*1000));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String requestWithoutCert(String strUrl, Map<String, String> reqData, int connectTimeoutMs,
			int readTimeoutMs) throws Exception {
		String UTF8 = "UTF-8";
		String reqBody = WXPayUtil.mapToXml(reqData);
		URL httpUrl = new URL(strUrl);
		HttpURLConnection httpURLConnection = (HttpURLConnection) httpUrl.openConnection();
		httpURLConnection.setDoOutput(true);
		httpURLConnection.setRequestMethod("POST");
		httpURLConnection.setConnectTimeout(connectTimeoutMs);
		httpURLConnection.setReadTimeout(readTimeoutMs);
		httpURLConnection.connect();
		OutputStream outputStream = httpURLConnection.getOutputStream();
		outputStream.write(reqBody.getBytes(UTF8));

		// if (httpURLConnection.getResponseCode()!= 200) {
		// throw new Exception(String.format("HTTP response code is %d, not
		// 200", httpURLConnection.getResponseCode()));
		// }

		// 获取内容
		InputStream inputStream = httpURLConnection.getInputStream();
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream, UTF8));
		final StringBuffer stringBuffer = new StringBuffer();
		String line = null;
		while ((line = bufferedReader.readLine()) != null) {
			stringBuffer.append(line);
		}
		String resp = stringBuffer.toString();
		if (stringBuffer != null) {
			try {
				bufferedReader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (inputStream != null) {
			try {
				inputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (outputStream != null) {
			try {
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// if (httpURLConnection!=null) {
		// httpURLConnection.disconnect();
		// }

		return resp;
	}
	
	public static void timecha() throws InterruptedException{
		Date beginTime = new Date();
		Thread.sleep(3000);
		Date endTime = new Date();
		long between=(endTime.getTime()-beginTime.getTime())/1000;//除以1000是为了转换成秒
		long min=between/60;//获取分钟数
		double hour = min/60;
		long yushu = min%60;//取整数小时候，余 分钟数,不满30分钟，按照0.5小时计算，大于30分钟按1小时计算
		if(yushu <= 30){
			hour = hour+0.5;
		}else{
			hour = hour + 1;
		}
		System.out.println(hour);
	}
	
	public static void time( ) throws ParseException{
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    try  
	    {  
	      Date d1 = df.parse("2018-03-26 13:31:40");  
	      Date d2 = df.parse("2018-03-26 11:30:24");  
	      long diff = d1.getTime() - d2.getTime();//这样得到的差值是微秒级别  
	      long days = diff / (1000 * 60 * 60 * 24);  
	   
	      long hours = (diff)/(1000* 60 * 60);  
	      long minutes = (diff-hours*(1000* 60 * 60))/(1000* 60);  
	      System.out.println(hours+"小时"+minutes+"分");  
	    }catch (Exception e)  
	    {  
	    }  
	}
	public static void joinList(){
		List<String> list = new ArrayList<String>();  
		list.add("a");  
		list.add("b");  
		list.add("c");  
		System.out.println(Joiner.on(",").join(list));
	}
	
	public static void urlEncode() throws UnsupportedEncodingException{
		 System.out.println(java.net.URLEncoder.encode("https://zhonglestudio.cn/smartparking/weixin/index.html",   "utf-8"));   
		 System.out.println(java.net.URLEncoder.encode("https://zhonglestudio.cn/qlvip/weixin/index.html",   "utf-8"));   
	}
	
	public static void formatTest(){
		DecimalFormat df = new DecimalFormat("#.00000");
		double longitudeF = 121.411;
		double latitudeF = 30.803;
		String key = df.format(longitudeF) + df.format(longitudeF);
		System.out.println(key);
		
	}
	
	public static void splitTest(){
//		String s = "310000000000";
//		String zero = "00";
//		String resp = s.substring(0, s.length()-zero.length());
//		System.out.println(resp);
		String s = "3100000000000013BZ";
		int a =12;
		int b =16;
		
	}
	public static void listTest(){
		List<String> list = new ArrayList<String>();
		list.add("1");
		list.add("1");
		list.add("1");
		System.out.println(StringUtils.join(list.toArray(), "','"));
	}
}
