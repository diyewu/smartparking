package com.xz.controller.weixin.pay;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.github.wxpay.sdk.WXPayUtil;
import com.xz.common.ServerResult;
import com.xz.config.weixin.WeixinConfig;
import com.xz.controller.BaseController;
import com.xz.controller.weixin.WeixinConstants;
import com.xz.entity.CustomConfig;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartOrderService;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RequestMapping("wepay")
@RestController
public class WeixinPayController extends BaseController{
	
	@Autowired
	private SmartOrderService smartOrderService;
	
	@Autowired  
    private CustomConfig customConfig; 
	
	@Autowired  
	private WeixinConfig config;  
	
	@ApiOperation(value = "调用接口在微信支付服务后台生成预支付交易单", notes = "根据订单编号获取订单信息，发送到微信服务器获取预支付交易单", httpMethod = "POST")
	@RequestMapping("getWePayPrepayId")
	@ResponseBody
	public JsonModel getWePayPrepayId(
			@ApiParam(name = "orderNo", value = "订单编号", required = true) @RequestParam(value = "orderNo", required = true) String orderNo
			){
		String msg = null;
		int code = 0;
		Map<String,String> respMap = new HashMap<String, String>();
		try {
			//step 1 校验权限
			HttpSession session = getRequest().getSession();
			String openId = (String)session.getAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID);
			String body = "停车缴费订单支付";
			String totalFee = "";
			String spbillCreateIp = WeixinPayHelper.getIpAddress(getRequest());
			double totalFeeD = 0;
			int totalFeeInt = 0;
			String prepayId = "";
			if(StringUtils.isBlank(openId)){
				code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
			}
			//step 2 根据orderNo 获取订单信息
			if(code == 0){
				List<Map<String, Object>> list = smartOrderService.getOrderInfoById(orderNo);
				if(list == null || list.size() == 0){
					code = ServerResult.RESULT_ORDER_ID_ERROR;
				}else{
					totalFee = String.valueOf(list.get(0).get("receivable_amount"));
				}
				try {
					totalFeeD = Double.parseDouble(totalFee);
					totalFeeD = totalFeeD * 100;
					totalFeeInt = (int)totalFeeD;
				} catch (Exception e) {
					code = ServerResult.RESULT_ORDER_FEE_ERROR;
					e.printStackTrace();
				}
			}
			//发起获取   微信支付服务后台生成预支付交易单  请求
			if(code == 0){
				Map<String, String> payRespMap = WeixinPayHelper.unifiedOrder(config,body, orderNo, totalFeeInt+"", spbillCreateIp, customConfig.getNotifyurl(), openId);
				if(payRespMap != null && !payRespMap.isEmpty()){
					String returnCode = payRespMap.get("return_code");
					if("SUCCESS".equals(returnCode)){//调用成功，通信标识
						String resultCode = payRespMap.get("result_code");
						if("SUCCESS".equals(resultCode)){
							prepayId = payRespMap.get("prepay_id");
						}else{
							code = ServerResult.RESULT_GET_PREPAY_ID_ERROR;
							msg = payRespMap.get("err_code_des");
						}
					}else{
						code = ServerResult.RESULT_GET_PREPAY_ID_ERROR;
						msg = payRespMap.get("return_msg");
					}
				}else{
					code = ServerResult.RESULT_GET_PREPAY_ID_ERROR;
				}
			}
			if(code == 0 && StringUtils.isNotBlank(prepayId)){
//				WeixinConfig config = new WeixinConfig();
				respMap.put("appId", config.getAppID());
				respMap.put("timeStamp", (System.currentTimeMillis()/1000)+"");
				respMap.put("nonceStr", WXPayUtil.generateNonceStr());//随机字符串
				respMap.put("package", "prepay_id="+prepayId);//订单详情扩展字符串
				respMap.put("signType", "MD5");//签名方式
				String paySign = "";
				paySign = WXPayUtil.generateSignature(respMap, config.getKey());//生成签名
				respMap.put("paySign", paySign);//签名
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
	
	@ApiOperation(value = "异步接收微信支付结果通知的回调地址", notes = "通知url必须为外网可访问的url，不能携带参数", httpMethod = "POST")
	@RequestMapping("accessWePayNotify")
	@ResponseBody
	public void accessWePayNotify(HttpServletRequest request, HttpServletResponse response){
		System.out.println("____收到微信通知————————————————————————");
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		try {
			
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
	}
	
}
