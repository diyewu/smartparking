package com.xz.controller.weixin.pay;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
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
import com.xz.controller.weixin.WeixinHelper;
import com.xz.entity.CustomConfig;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartOrderService;
import com.xz.utils.DateHelper;

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
				Map<String, String> payRespMap = WeixinPayHelper.unifiedOrder(config,body, orderNo, totalFeeInt+"", spbillCreateIp, customConfig.getNotifyurl(), openId,customConfig.isSandbox());
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
				System.out.println(DateHelper.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
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
	
	/**
	 * API  地址 ：https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_4
	 * @param orderNo
	 * TODO 测试阶段，直接可以发送退款请求到微信，正式环境下先提交退款申请，待操作员同意后在发送请求到微信，退款成功后，微信通知用户
	 */
	@ApiOperation(value = "申请退款", notes = "根据订单编号申请退款", httpMethod = "POST")
	@RequestMapping("refund")
	@ResponseBody
	public void refund(
			@ApiParam(name = "orderNo", value = "订单编号", required = true) @RequestParam(value = "orderNo", required = true) String orderNo
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		String totalFee = "";//订单总费用
		double totalFeeD = 0;
		int totalFeeInt = 0;
		//step 1 校验权限
		HttpSession session = getRequest().getSession();
		String openId = (String)session.getAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID);
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
		
		//step 3 生成退款信息，调用微信API
//		String outRefundNo
		
		
	}
	/**
	 * API  地址 ：https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_7&index=8
	 * queryorder :https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_2
	 * @param request
	 * @param response
	 */
	@ApiOperation(value = "异步接收微信支付结果通知的回调地址", notes = "通知url必须为外网可访问的url，不能携带参数", httpMethod = "POST")
	@RequestMapping("accessWePayNotify")
	@ResponseBody
	public void accessWePayNotify(HttpServletRequest request, HttpServletResponse response){
		System.out.println("____收到微信通知————————————————————————");
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		String resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"  
                + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
		InputStream inStream = null;
		ByteArrayOutputStream outSteam = null;
		try {
            inStream = request.getInputStream();  
            outSteam = new ByteArrayOutputStream();  
            byte[] buffer = new byte[1024];  
            int len = 0;  
            while ((len = inStream.read(buffer)) != -1) {  
                outSteam.write(buffer, 0, len);  
            }
            String result = new String(outSteam.toByteArray(), "utf-8");// 获取微信调用我们notify_url的返回信息  
            System.out.println("notify-result="+result);
            Map<String, String> map = WXPayUtil.xmlToMap(result);
            if ("SUCCESS".equalsIgnoreCase(map.get("return_code"))) {//微信支付----返回成功,验证参数，回复微信服务器
            	if("SUCCESS".equalsIgnoreCase(map.get("result_code"))){
            		//校验签名
            		boolean signatureValid = WXPayUtil.isSignatureValid(result, customConfig.getAeskeycode());
            		if(signatureValid){//校验成功,通知微信

            			//查询订单，通过查询订单接口主动查询订单状态，完成下一步的业务逻辑。
            			String transaction_id = map.get("transaction_id");//微信支付订单号
            			String out_trade_no = map.get("out_trade_no");//订单号
            			System.out.println("out_trade_no="+out_trade_no);
            			Map<String, String> queryMap = new HashMap<String, String>();
//            			queryMap.put("transaction_id", transaction_id);
            			queryMap.put("out_trade_no", out_trade_no);
            			Map<String, String> resultQueryMap = WeixinPayHelper.orderQuery(config, queryMap, customConfig.isSandbox());
            			System.out.println("resultQueryMap="+resultQueryMap);
            			if("SUCCESS".equalsIgnoreCase(resultQueryMap.get("return_code"))){
            				if("SUCCESS".equalsIgnoreCase(map.get("result_code"))){
            					/**
            					 * SUCCESS—支付成功
									REFUND—转入退款
									NOTPAY—未支付
									CLOSED—已关闭
									REVOKED—已撤销（刷卡支付）
									USERPAYING--用户支付中
									PAYERROR--支付失败(其他原因，如银行返回失败)
            					 */
            					if("SUCCESS".equalsIgnoreCase(map.get("trade_state"))){
            						//TODO  更新订单状态，通知用户支付状态
            					}
            				}else{
            					System.out.println("查询订单失败："+resultQueryMap);
            				}
            			}else{
            				System.out.println("查询订单失败："+resultQueryMap);
            			}
            			//通知微信
            		}else{
            			System.out.println("____sign___校验失败");
            		}
            	}
            }else{//微信支付----返回失败
            	System.out.println("微信支付----返回失败："+map);
            }
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}finally{
			this.printData(response, resXml);
            try {
            	outSteam.close();  
				inStream.close();
			} catch (IOException e) {
			}  
		}
	}
	
}
