package com.xz.controller.weixin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
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
import com.xz.model.json.AppJsonModel;
import com.xz.service.SmartMemberService;
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
    public AppJsonModel getCarParkInfoByCode(@ApiParam(name = "authCode", value = "用户同意授权，获取code", required = true) @RequestParam("authCode") String authCode
    		){
    	String msg = null;
		int code = 0;
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,String> respMap = new HashMap<String, String>();
		respMap = WeixinHelper.getWebAuthOpenIdAndAccessToken(customConfig.getAppid(), customConfig.getSecret(), authCode);
		try {
			String openId = respMap.get(WeixinConstants.WEIXIN_OPEN_ID);
			System.out.println("openId="+openId);
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
		System.out.println("map="+map);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), map);
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
