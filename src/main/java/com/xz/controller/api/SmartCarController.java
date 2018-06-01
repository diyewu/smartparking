package com.xz.controller.api;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.xz.common.ServerResult;
import com.xz.controller.BaseController;
import com.xz.controller.weixin.WeixinConstants;
import com.xz.model.json.AppJsonModel;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartCarService;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("smartCar")
public class SmartCarController extends BaseController{
	
	@Autowired
	private SmartCarService smartCarService;
	
	
	@ApiOperation(value = "车辆信息注册", notes = "填写车辆信息", httpMethod = "POST")
	@RequestMapping("carRegist")
	@ResponseBody
	public JsonModel carRegist(
//			 @ApiParam(name = "memberId", value = "会员编号", required = true) @RequestParam("memberId") String memberId,
			 @ApiParam(name = "carNumber", value = "车牌号码", required = true) @RequestParam("carNumber") String carNumber,
			 @ApiParam(name = "carType", value = "车辆类型", required = true) @RequestParam("carType") String carType,
			 @ApiParam(name = "isOwn", value = "车辆是否属于会员本人，0：不属于，1：属于", required = false) @RequestParam(value = "isOwn", required = false) String isOwn,
			 @ApiParam(name = "carOwnerName", value = "车主姓名", required = false) @RequestParam(value = "carOwnerName", required = false) String carOwnerName,
			 @ApiParam(name = "carOwnerAddress", value = "车主联系地址", required = false) @RequestParam(value = "carOwnerAddress", required = false) String carOwnerAddress,
			 @ApiParam(name = "carOwnerPhone", value = "车主联系方式", required = false) @RequestParam(value = "carOwnerPhone", required = false) String carOwnerPhone
			){
		String msg = null;
		int code = 0;
		Map<String,String> respMap = new HashMap<String, String>();
		/*
		if(StringUtils.isBlank(isOwn) && StringUtils.isBlank(carOwnerName)){
			code = ServerResult.RESULT_OWNERINFO_ERROR;
		}
		*/
		try {
			//TODO 统一检测参数 memberId
			HttpSession session = getRequest().getSession();
			String memberId = (String) session.getAttribute(WeixinConstants.SESSION_MEMBER_ID);
			if (StringUtils.isNotBlank(memberId)) {
				code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
			}
			//注册车主信息
			if (code == 0) {
				String ownerId = "";
				//会员即是车主
				if (StringUtils.isNotBlank(isOwn) && "1".equals(isOwn)) {
					ownerId = smartCarService.ownerIsMemberRegist(memberId);
				} else {
					ownerId = smartCarService.ownerRegist(carOwnerName, carOwnerAddress, carOwnerPhone);
				}
				if (StringUtils.isNotBlank(ownerId)) {
					int carTypeInt = Integer.parseInt(carType);
					String carId = smartCarService.carRegist(memberId, carNumber, ownerId, carTypeInt);
				}
			} 
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code == 0, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
}
