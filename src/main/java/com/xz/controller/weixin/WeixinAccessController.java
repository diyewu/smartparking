package com.xz.controller.weixin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xz.controller.BaseController;
import com.xz.entity.CustomConfig;
import com.xz.utils.SignUtil;

@RequestMapping("wechat")
@Controller
public class WeixinAccessController extends BaseController{
	
	@Autowired  
    private CustomConfig customConfig; 
	
    private static final Logger LOGGER = LoggerFactory.getLogger(WeixinAccessController.class);
	/**
	 * weixin绑定服务器
	 * @param request
	 * @return
	 * @throws IOException 
	 */
    @RequestMapping(value="access",method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void bindWeixinServer(HttpServletRequest request, HttpServletResponse response) throws IOException{
//        PrintWriter out = response.getWriter();
        try {
                String signature = request.getParameter("signature");// 微信加密签名  
                String timestamp = request.getParameter("timestamp");// 时间戳  
                String nonce = request.getParameter("nonce");// 随机数  
                String echostr = request.getParameter("echostr");//随机字符串  
                if(SignUtil.checkSignature(customConfig.getWeixintoken(), signature, timestamp, nonce)){
                // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败    
                    LOGGER.info("Connect the weixin server successful.");
//                    response.getWriter().write(echostr);
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
    
    
    
    
    
}
