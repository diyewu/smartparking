package com.xz.controller.weixin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.codehaus.jackson.map.ObjectMapper;

import com.xz.controller.weixin.message.response.TemplateMsgResult;
import com.xz.controller.weixin.message.response.WechatTemplateMsg;

/**
 * 
 * 线程
 *
 */
public class WeiXinSendTemplateThread extends Thread {
	private List<Map<String, Object>> list;

	public WeiXinSendTemplateThread(List<Map<String, Object>> list) {
		this.list = list;
	}

	public void run() {
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {// 根据openid发送模板消息
				String orderNo = list.get(i).get("order_no") + "";// 订单编号
				String actuallypaid = list.get(i).get("actuallypaid") + "";// 实际支付
				String deposit = list.get(i).get("deposit") + "";// 余额
				String memberNo = list.get(i).get("member_no") + "";// 会员编号
				String phone = list.get(i).get("phone") + "";// 手机号
				String openId = list.get(i).get("open_id") + "";// 微信关注的open_id
				String date = list.get(i).get("inputdatetime") + "";// date
				WeixinSendTeleplate.sendUnpaidInfo(openId, "", memberNo, date, actuallypaid, deposit);
			}
		}
	}
	

	public static void main(String[] args) {
		Thread thread = new WeiXinSendTemplateThread(new ArrayList<Map<String, Object>>());
		thread.start();
	}
}