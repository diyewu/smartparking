package com.xz.controller.weixin.pay;

import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.xz.config.weixin.WeixinConfig;

public class PayOrderQueryProcess extends Thread implements ApplicationContextAware{
	private boolean isSandbox ;
	private Map<String, String> queryMap ;
	private WeixinConfig config ;
	private static ApplicationContext applicationContext;
	
	PayOrderQueryProcess(WeixinConfig config,Map<String, String> queryMap,boolean isSandbox){
		super();
		this.config = config;
		this.queryMap = queryMap;
		this.isSandbox = isSandbox;
	}
	/**
	 * 查询订单任务
	 */
	@Override
	public void run(){
		System.out.println("___________in____________");
		Map<String, String> resultQueryMap = WeixinPayHelper.orderQuery(config, queryMap, isSandbox);
		System.out.println("resultQueryMap="+resultQueryMap);
		if(resultQueryMap != null){
			if("SUCCESS".equalsIgnoreCase(resultQueryMap.get("return_code"))){
				if("SUCCESS".equalsIgnoreCase(resultQueryMap.get("result_code"))){
					/**
					 * SUCCESS—支付成功
						REFUND—转入退款
						NOTPAY—未支付
						CLOSED—已关闭
						REVOKED—已撤销（刷卡支付）
						USERPAYING--用户支付中
						PAYERROR--支付失败(其他原因，如银行返回失败)
					 */
					if("SUCCESS".equalsIgnoreCase(resultQueryMap.get("trade_state"))){
						//校验sign
						if(WeixinPayHelper.isPayResultNotifySignatureValid(config, isSandbox, resultQueryMap)){
							// TODO 更新订单状态，通知用户支付状态,先查询订单状态再更新，防止重复更新
							// TODO 校验订单金额是否一致
							
						}else{
							System.out.println("sign校验失败！");
						}
					}
				}else{
					System.out.println("查询订单失败："+resultQueryMap);
				}
			}else{
				System.out.println("查询订单失败："+resultQueryMap);
			}
			throw new RuntimeException("查询订单结束");
		}
	}
	
	@Override
	public void setApplicationContext(ApplicationContext arg0) throws BeansException {
		// TODO Auto-generated method stub
		
	}
	
	/*数据库更新操作
	@Override
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		DataProgress.applicationContext = applicationContext;
	}
    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }
    /**
     * 获取对象 这里重写了bean方法，起主要作用
     */
	/*
    public static Object getBean(String beanId) throws BeansException {
        return applicationContext.getBean(beanId);
    }
    */

}
