package com.xz.controller.weixin.pay;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.github.wxpay.sdk.WXPay;
import com.github.wxpay.sdk.WXPayConstants.SignType;
import com.xz.config.weixin.WeixinConfig;

public class WeixinPayHelper {

	/**
	 * 统一下单
	 */
	public static Map<String, String> unifiedOrder(String body, String orderNo, String totalFee, String spbillCreateIp,
			String notifyUrl, String openId) {
		WeixinConfig config = new WeixinConfig();
//		config.getKey();
		//沙箱测试，正式环境需要把 useSandbox 改为false
		WXPay wxpay = new WXPay(config,SignType.MD5,true);
		Map<String, String> data = new HashMap<String, String>();
		data.put("body", body);// "停车缴费订单支付"
		data.put("out_trade_no", orderNo);// 商户订单号
		data.put("device_info", "WEB");// 自定义参数，可以为终端设备号(门店号或收银设备ID)，PC网页或公众号内支付可以传"WEB"
		data.put("fee_type", "CNY");
		data.put("total_fee", totalFee);// 订单总金额，单位为分
		data.put("spbill_create_ip", spbillCreateIp);// APP和网页支付提交用户端ip
		data.put("notify_url", notifyUrl);// 异步接收微信支付结果通知的回调地址，通知url必须为外网可访问的url，不能携带参数。
		data.put("trade_type", "JSAPI"); // 此处指定为扫码支付
		data.put("openid", openId);
		
		Map<String, String> resp = new HashMap<String, String>();
		try {
			resp = wxpay.unifiedOrder(data);
			System.out.println(resp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resp;
	}

	/**
	 * 获取客户端IP
	 * @param request
	 * @return
	 */
	public static String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}
