package com.xz.controller;

import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xz.entity.UserLogin;
import com.xz.model.json.JsonModel;
import com.xz.service.UserLoginService;

@RequestMapping("userlogin")
@Controller
public class UserLoginController {
	
	@Autowired
	private UserLoginService userLoginService;
	/**
	 * 测试地址： http://localhost:8080/userlogin/getUser?id=1
	 * @param id
	 * @return
	 */
	@RequestMapping("getUser")
	@ResponseBody
	public UserLogin getUser(String id) {
		return userLoginService.getUserById(id);
	}
	
	@RequestMapping("checkUser")
	@ResponseBody
	public JsonModel checkUser(HttpServletRequest request,HttpServletResponse response) {
		String msg = null;
		HttpSession session=request.getSession();
		String name = request.getParameter("userName");
		String pwd = request.getParameter("userPwd");
		if(StringUtils.isBlank(name) || StringUtils.isBlank(pwd)){
			msg = "用户名或密码参数有误！";
		}
		UserLogin user = new UserLogin();
		if(msg == null){
			user.setUserName(name);
			user.setUserPassword(pwd);
			UserLogin userLogin = userLoginService.checkUserExist(user);
			if(userLogin != null){
				session.setAttribute("isLogin", "0");
				session.setAttribute("userName", userLogin.getUserName());
				Map<String, String> condition = new HashMap<String, String>();
				condition.put("userName", userLogin.getUserName());
				condition.put("userPwd", userLogin.getUserPassword());
				session.setAttribute("userRole", userLogin.getUserRole());
				session.setAttribute("userRoleId", userLogin.getUserRole());
				session.setAttribute("userId", userLogin.getId());
			}else{
				msg = "用户名或密码错误！";
			}
		}
		return new JsonModel(msg == null,msg);
	}
	
	
	/**
	 * 功能：公共方法用于响应前台请求
	 * 
	 * @param response
	 * @param data
	 */
	private void printData(HttpServletResponse response, String data) {
		try {
			// System.out.println(data);
			response.setContentType("text/html;charset=utf-8");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = new PrintWriter(new OutputStreamWriter(
					response.getOutputStream(), "UTF-8"));
			out.println(data);
			out.close();
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
