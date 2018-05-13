package com.xz.controller.api;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.xz.common.ServerResult;
import com.xz.controller.BaseController;
import com.xz.model.json.AppJsonModel;
import com.xz.service.SmartCarService;
import com.xz.service.SmartParkService;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
@RestController
@RequestMapping("demo")
public class DemoController extends BaseController{
	@Autowired
	private SmartParkService smartParkService;
	@Autowired
	private SmartCarService smartCarService;
	
	@ApiOperation(value = "汽车驶入或驶出停车场地", notes = "由客户端识别汽车牌照", httpMethod = "POST")
	@RequestMapping("parking")
	@ResponseBody
	public AppJsonModel parking(
			 @ApiParam(name = "carNumber", value = "准备驶入停车场汽车牌照编号，有客户端自动识别或手动填写", required = true) @RequestParam(value = "carNumber", required = false) String carNumber,
			 @ApiParam(name = "parkId", value = "停车场编号", required = true) @RequestParam(value = "parkId", required = true) String parkId,
			 @ApiParam(name = "spaceId", value = "停车位编号", required = true) @RequestParam(value = "spaceId", required = true) String spaceId,
			 @ApiParam(name = "parkingType", value = "停车类型，0：驶入 1：驶出", required = true) @RequestParam(value = "parkingType", required = true) String parkingType
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		if(code == 0){
			try {
				//TODO 进场，出场，产生订单
			} catch (Exception e) {
				msg = e.getMessage();
				e.printStackTrace();
			}
		}
		respMap.put("parkId", parkId);
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
}
