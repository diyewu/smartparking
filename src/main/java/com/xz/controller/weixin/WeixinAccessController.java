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
import com.xz.entity.SmartMember;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartMemberService;
import com.xz.utils.DateHelper;
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
    	System.out.println("authCode="+authCode);
//    	return null;
    	String msg = null;
		int code = 0;
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,String> respMap = new HashMap<String, String>();
		try {
			String openId = "";
			HttpSession session = getRequest().getSession(); 
			if(StringUtils.isNotBlank(authCode)){
				respMap = WeixinHelper.getWebAuthOpenIdAndAccessToken(customConfig.getAppid(), customConfig.getSecret(), authCode);
				openId = respMap.get(WeixinConstants.WEIXIN_OPEN_ID);
			}
			if(StringUtils.isBlank(openId) && StringUtils.isBlank(authCode)){
				openId = (String)session.getAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID);
			}
			System.out.println("openId="+openId);
			if(StringUtils.isBlank(openId)){
				code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
			}else{
				session.setAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID, openId);
			}
			if(code == 0){
				// 得到openid走业务逻辑，如果数据库中存在则查询数据，如果没有绑定手机号
				List<Map<String, Object>> list = smartMemberService.checkMemberByOpenId(openId);
				if(list != null && list.size()>0){//存在,查询当前停车信息，展示出来
					map.put("state", "1");
					String memberId = (String)list.get(0).get("id");
					session.setAttribute(WeixinConstants.SESSION_MEMBER_ID, memberId);
					List<Map<String, Object>> carParkList = smartMemberService.getCarParkStateByMemId(memberId);
					List<Map<String, Object>> respList = new ArrayList<Map<String,Object>>();
					if(carParkList != null && carParkList.size()>0){
						Map<String, Object> tmap = new HashMap<String, Object>();
						for(int i=0;i<carParkList.size();i++){
							tmap = new HashMap<String, Object>();
							tmap = carParkList.get(i);
							String begin_time = (String)tmap.get("begin_time");
							tmap.put("diff_time", "0小时0分钟");
							if(StringUtils.isNotBlank(begin_time)){
								String DateDiff = DateHelper.getDateDiffengt(begin_time);
								tmap.put("diff_time", DateDiff);
							}
							respList.add(tmap);
						}
					}
					map.put("carstate", respList);
				}else{//不存在，跳转到手机注册页面
					map.put("state", "0");
				}
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), map);
    }
    
    
    
    
    /**
     * 发送手机验证码
     * @param request
     * @return
     * @throws IOException 
     */
    @ApiOperation(value = "发送手机验证码", notes = "发送手机验证码", httpMethod = "POST")
    @RequestMapping(value="sendValidateMobileCode",method = RequestMethod.POST)
    @ResponseBody
    public JsonModel sendValidateMobileCode(
    		@ApiParam(name = "mobileNumber", value = "手机号码", required = true) @RequestParam("mobileNumber") String mobileNumber
    		) throws IOException{
    	String msg = null;
		int code = 0;
		Map<String,Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		HttpSession session = getRequest().getSession();
    	try {
			//校验手机号码
			boolean isMobile = isMobile(mobileNumber);
			int mobileCode = (int) ((Math.random() * 9 + 1) * 100000);
			if (!isMobile) {
				code = ServerResult.RESULT_MOBILE_VALIDATE_ERROR;
			}
			//校验是否有 openId
			if (code == 0) {
				String openId = (String)session.getAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID);
				if(StringUtils.isBlank(openId)){
					code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
				}
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
								long second = diff / 1000;
								if (second > 120) {//2分钟之后才能继续发送验证码
									//TODO  发送验证码
									String content="尊敬的用户：<br/>您的验证码为："+mobileCode+"（60分钟内有效，区分大小写），为了保证您的账户安全，请勿向任何人提供此验证码。";
									try {
										//插入数据库
										smartMemberService.updateMobileCodeSend(mobileNumber, mobileCode);
//										MailSam.send(customConfig.getSmtp(), customConfig.getPort(), customConfig.getUser(), customConfig.getPwd(), "930725713@qq.com", "测试手机验证码", content);
										map.put("code", mobileCode);
										session.setAttribute(WeixinConstants.SESSION_WEIXIN_USER_MOBILE, mobileNumber);
										session.setAttribute(WeixinConstants.SESSION_MOBILE_VALIDATE_CODE, mobileCode);
									} catch (Exception e) {
										code = ServerResult.RESULT_SERVER_ERROR;
										msg = e.getMessage();
										e.printStackTrace();
									}
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
//						MailSam.send(customConfig.getSmtp(), customConfig.getPort(), customConfig.getUser(), customConfig.getPwd(), "930725713@qq.com", "测试手机验证码", content);
						map.put("code", mobileCode);
					} catch (Exception e) {
						e.printStackTrace();
					}
					smartMemberService.insertMobileCodeSend(mobileNumber, mobileCode, 9);
				}
			} 
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
    	return new JsonModel(code, ServerResult.getCodeMsg(code, msg), map);
    }
    
    
    @ApiOperation(value = "检查手机验证码", notes = "检查手机验证码", httpMethod = "POST")
    @RequestMapping(value="checkMobileCode",method = RequestMethod.POST)
    @ResponseBody
    public JsonModel checkMobileCode(
    		@ApiParam(name = "mobileValidateCode", value = "手机验证码", required = true) @RequestParam("mobileValidateCode") String mobileValidateCode
    		) throws IOException{
    	String msg = null;
		int code = 0;
		Map<String,Object> map = new HashMap<String, Object>();
    	HttpSession session = getRequest().getSession();
    	try {
			String mobile = (String) session.getAttribute(WeixinConstants.SESSION_WEIXIN_USER_MOBILE);
			String openId = (String) session.getAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID);
			String sessionValidateCode = session.getAttribute(WeixinConstants.SESSION_MOBILE_VALIDATE_CODE)+"";
			session.setAttribute(WeixinConstants.SESSION_MOBILE_VALIDATE_CODE, "");
			String memberId = "";
			if (StringUtils.isBlank(sessionValidateCode)) {
				code = ServerResult.RESULT_MOBILE_CODE_VALIDATE_ERROR;
			}
			if (code == 0) {
				if (StringUtils.isNotBlank(mobile)) {
					if (!sessionValidateCode.equals(mobileValidateCode)) {
						code = ServerResult.RESULT_MOBILE_CODE_VALIDATE_ERROR;
					}
				} else {
					code = ServerResult.RESULT_SESSION_MOBILE_CHECK_ERROR;
				}
			}
			//手机验证码验证成功之后，插入会员信息
			if (code == 0) {
				//根据openid获取会员信息
				List<Map<String, Object>> list = smartMemberService.getMemberINfoByOpenId(openId);
				if(list != null && list.size()>0){
					memberId = (String)list.get(0).get("id");
				}
				SmartMember smartMember = new SmartMember();
				if(StringUtils.isNotBlank(memberId)){//验证手机验证码，如果是已存在的会员，则无需更新
//					smartMember.setId(memberId);
//					SESSION_MEMBER_ID
					session.setAttribute(WeixinConstants.SESSION_MEMBER_ID, memberId);
				}else{
					smartMember.setMobile(mobile);
					smartMember.setOpenId(openId);
					smartMemberService.updateMember(smartMember);
				}
			} 
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), map);
    }
    
    /**
     * weixin连接服务器
     * @param request
     * @return
     * @throws IOException 
     */
    @ApiOperation(value = "TEST", notes = "TEST", httpMethod = "POST")
    @RequestMapping(value="console",method = RequestMethod.POST)
    @ResponseBody
    public void consoleLog() throws IOException{
    	try {
    		SmartMember sm = new SmartMember();
    		String id = getRequest().getParameter("id");
    		String member_name = getRequest().getParameter("member_name");
    		String member_sex = getRequest().getParameter("member_sex");
    		String open_id = getRequest().getParameter("open_id");
    		String mobile = getRequest().getParameter("mobile");
    		if(StringUtils.isNotBlank(id)){
    			sm.setId(id);
    		}
    		if(StringUtils.isNotBlank(member_name)){
    			sm.setMemberName(member_name);
    		}
    		if(StringUtils.isNotBlank(member_sex)){
    			sm.setMemberSex(member_sex);
    		}
    		if(StringUtils.isNotBlank(open_id)){
    			sm.setOpenId(open_id);
    		}
    		if(StringUtils.isNotBlank(mobile)){
    			sm.setMobile(mobile);
    		}
    		smartMemberService.updateMember(sm);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}finally{
    		
    	}
    }
    
    
    
    
    
    
    
}
