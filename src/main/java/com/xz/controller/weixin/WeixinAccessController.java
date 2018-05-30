package com.xz.controller.weixin;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.xz.common.ServerResult;
import com.xz.controller.BaseController;
import com.xz.entity.CustomConfig;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartMemberService;
import com.xz.utils.MailSam;
import com.xz.utils.SignUtil;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RequestMapping("wechat")
@RestController
public class WeixinAccessController extends BaseController{
	@Autowired
	private SmartMemberService smartMemberService;
	@Autowired  
    private CustomConfig customConfig; 
	
    private static final Logger LOGGER = LoggerFactory.getLogger(WeixinAccessController.class);
	/**
	 * weixin绑定服务器
	 * @param request
	 * @return
	 * @throws IOException 
	 */
    @RequestMapping(value="access",method = RequestMethod.GET)
	@ResponseBody
	public void bindWeixinServer(HttpServletRequest request, HttpServletResponse response) throws IOException{
	        try {
	                String signature = request.getParameter("signature");// 微信加密签名  
	                String timestamp = request.getParameter("timestamp");// 时间戳  
	                String nonce = request.getParameter("nonce");// 随机数  
	                String echostr = request.getParameter("echostr");//随机字符串  
	                if(SignUtil.checkSignature(customConfig.getWeixintoken(), signature, timestamp, nonce)){
	                // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败    
	                    LOGGER.info("Connect the weixin server successful.");
	                    this.printData(response, echostr);
	                } else {  
	                    LOGGER.error("Failed to verify the signature!"); 
	                    this.printData(response, "error!");
	                }
	        } catch (Exception e) {
	            LOGGER.error("Connect the weixin server error.");
	        }finally{
	//            out.close();
	        }
	}
    /**
     * weixin连接服务器
     * @param request
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="access",method = RequestMethod.POST)
    @ResponseBody
    public void weixinCommunicate(HttpServletRequest request, HttpServletResponse response) throws IOException{
    	try {
    		String resp = WeixinHelper.processRequest(request);
    		this.printData(response, resp);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}finally{
    		
    	}
    }
    
    /**
     * { "access_token":"ACCESS_TOKEN",
		"expires_in":7200,
		"refresh_token":"REFRESH_TOKEN",
		"openid":"OPENID",
		"scope":"SCOPE" }
     * @param authCode
     */
    @ApiOperation(value = "根据微信网页授权code获取openId", notes = "根据微信网页授权code获取openId", httpMethod = "POST")
    @RequestMapping(value="getCarParkInfoByCode",method = RequestMethod.POST)
    @ResponseBody
    public JsonModel getCarParkInfoByCode(@ApiParam(name = "authCode", value = "用户同意授权，获取code", required = true) @RequestParam("authCode") String authCode
    		){
    	String msg = null;
		int code = 0;
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,String> respMap = new HashMap<String, String>();
		respMap = WeixinHelper.getWebAuthOpenIdAndAccessToken(customConfig.getAppid(), customConfig.getSecret(), authCode);
		try {
			String openId = respMap.get(WeixinConstants.WEIXIN_OPEN_ID);
			System.out.println("openId="+openId);
			HttpSession session = getRequest().getSession(); 
			if(StringUtils.isNotBlank(openId)){
				session.setAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID, openId);
			}
			// 得到openid走业务逻辑，如果数据库中存在则查询数据，如果没有绑定手机号
			List<Map<String, Object>> list = smartMemberService.checkMemberByOpenId(openId);
			if(list != null && list.size()>0){//存在,查询当前停车信息，展示出来
				map.put("state", "1");
				String memberId = (String)list.get(0).get("id");
				List<Map<String, Object>> carParkList = smartMemberService.getCarParkStateByMemId(memberId);
				map.put("carstate", carParkList);
			}else{//不存在，跳转到手机注册页面
				map.put("state", "0");
			}
		} catch (Exception e) {
			code = 1;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code == 0, ServerResult.getCodeMsg(code, msg), map);
    }
    
    
    
    
    /**
     * 发送手机验证码
     * @param request
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="sendValidateMobileCode",method = RequestMethod.POST)
    @ResponseBody
    public JsonModel sendValidateMobileCode(
    		@ApiParam(name = "mobileNumber", value = "手机号码", required = true) @RequestParam("mobileNumber") String mobileNumber
    		) throws IOException{
    	String msg = null;
		int code = 0;
		Map<String,Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
    	try {
			//校验手机号码
			boolean isMobile = isMobile(mobileNumber);
			int mobileCode = (int) ((Math.random() * 9 + 1) * 100000);
			if (!isMobile) {
				code = ServerResult.RESULT_MOBILE_VALIDATE_ERROR;
			}
			//校验当天剩余次数
			if (code == 0) {
				list = smartMemberService.getLastSendCodeTime(mobileNumber);
				if (list != null && list.size() > 0) {//数据库中存在mobile数据
					int remainTimes = (Integer) list.get(0).get("remain_time");
					if (remainTimes > 0) {//剩余次数大于0，继续校验上一次发送时间
						String lastSendCodeTime = (String) list.get(0).get("last_send_time");
						if (StringUtils.isNotBlank(lastSendCodeTime)) {
							DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							try {
								Date d1 = df.parse(lastSendCodeTime);
								Date nowTiem = new Date();
								long diff = nowTiem.getTime() - d1.getTime();// 这样得到的差值是微秒级别
								long second = diff / (60 * 60 * 24);
								if (second > 120) {//2分钟之后才能继续发送验证码
									//TODO  发送验证码
									String content="尊敬的用户：<br/>您的验证码为："+mobileCode+"（60分钟内有效，区分大小写），为了保证您的账户安全，请勿向任何人提供此验证码。";
									try {
										MailSam.send(customConfig.getSmtp(), customConfig.getPort(), customConfig.getUser(), customConfig.getPwd(), "930725713@qq.com", "测试手机验证码", content);
									} catch (MessagingException e) {
										e.printStackTrace();
									}
									//插入数据库
									smartMemberService.updateMobileCodeSend(mobileNumber, mobileCode);
								} else {
									code = ServerResult.RESULT_MOBILE_CODE_SEND_INTERVAL_ERROR;
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					} else {
						code = ServerResult.RESULT_MOBILE_CODE_SEND_REMAINTIMES_ERROR;
					}
				} else {
					//TODO  第一次发送验证码，则直接发送，并存储数据库,存储次数为9
					String content="尊敬的用户：<br/>您的验证码为："+mobileCode+"（60分钟内有效，区分大小写），为了保证您的账户安全，请勿向任何人提供此验证码。";
					try {
						MailSam.send(customConfig.getSmtp(), customConfig.getPort(), customConfig.getUser(), customConfig.getPwd(), "930725713@qq.com", "测试手机验证码", content);
					} catch (MessagingException e) {
						e.printStackTrace();
					}
					smartMemberService.insertMobileCodeSend(mobileNumber, mobileCode, 9);
				}
			} 
		} catch (Exception e) {
			code = 1;
			msg = e.getMessage();
		}
    	return new JsonModel(code == 0, ServerResult.getCodeMsg(code, msg), map);
    }
    
    
    /**
     * weixin连接服务器
     * @param request
     * @return
     * @throws IOException 
     */
    @RequestMapping(value="console",method = RequestMethod.POST)
    @ResponseBody
    public void consoleLog(HttpServletRequest request, HttpServletResponse response) throws IOException{
    	try {
    		String data =  request.getParameter("data");
    		System.out.println("data="+data);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}finally{
    		
    	}
    }
    
    
    
    
    
    
    
}
