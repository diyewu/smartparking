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

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("smartPark")
public class SmartParkController extends BaseController{
	
	@Autowired
	private SmartCarService smartCarService;
	
	
	@ApiOperation(value = "场地信息注册", notes = "填写场地信息", httpMethod = "POST")
	@RequestMapping("parkRegist")
	@ResponseBody
	public AppJsonModel parkRegist(
			 @ApiParam(name = "memberId", value = "场地管理员编号，可不填", required = false) @RequestParam(value = "memberId", required = false) String memberId,
			 @ApiParam(name = "parkName", value = "停车场地名称", required = true) @RequestParam(value = "parkName", required = true) String parkName,
			 @ApiParam(name = "parkLongitude", value = "停车场地经度", required = true) @RequestParam(value ="parkLongitude", required = true) String parkLongitude,
			 @ApiParam(name = "parkLatitude", value = "停车场地维度", required = true) @RequestParam(value = "parkLatitude", required = false) String parkLatitude,
			 @ApiParam(name = "parkDescription", value = "停车场地描述", required = false) @RequestParam(value = "parkDescription", required = false) String parkDescription
			){
		String msg = null;
		int code = 0;
		Map<String,String> respMap = new HashMap<String, String>();
		//注册场地信息
		if(code == 0){
			
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
	@ApiOperation(value = "场地入口信息注册", notes = "填写场地入口信息", httpMethod = "POST")
	@RequestMapping("parkEntranceRegist")
	@ResponseBody
	public AppJsonModel parkEntranceRegist(
			@ApiParam(name = "memberId", value = "场地管理员编号，可不填", required = false) @RequestParam(value = "memberId", required = false) String memberId,
			@ApiParam(name = "parkId", value = "停车场地编号", required = true) @RequestParam(value = "parkId", required = true) String parkId,
			@ApiParam(name = "entranceName", value = "场地入口名称", required = true) @RequestParam(value ="entranceName", required = true) String entranceName,
			@ApiParam(name = "entranceLongitude", value = "停车场地入口经度", required = true) @RequestParam(value = "entranceLongitude", required = false) String entranceLongitude,
			@ApiParam(name = "entranceLatitude", value = "停车场地入口纬度", required = true) @RequestParam(value = "entranceLatitude", required = false) String entranceLatitude,
			@ApiParam(name = "entranceDescription", value = "停车场地入口描述", required = false) @RequestParam(value = "entranceDescription", required = false) String entranceDescription
			){
		String msg = null;
		int code = 0;
		Map<String,String> respMap = new HashMap<String, String>();
		//注册车主信息
		if(code == 0){
			
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
	@ApiOperation(value = "场地车位信息注册", notes = "填写场地入口信息", httpMethod = "POST")
	@RequestMapping("parkSpaceRegist")
	@ResponseBody
	public AppJsonModel parkSpaceRegist(
			@ApiParam(name = "memberId", value = "场地管理员编号，可不填", required = false) @RequestParam(value = "memberId", required = false) String memberId,
			@ApiParam(name = "parkId", value = "停车场地编号", required = true) @RequestParam(value = "parkId", required = true) String parkId,
			@ApiParam(name = "spaceType", value = "场地车位类型", required = true) @RequestParam(value ="spaceType", required = true) String spaceType,
			@ApiParam(name = "spaceTotal", value = "场地该类型车位总数", required = true) @RequestParam(value = "spaceTotal", required = true) String spaceTotal,
			@ApiParam(name = "spaceUsed", value = "场地该类型车位已占用数", required = true) @RequestParam(value = "spaceUsed", required = true) String spaceUsed,
			@ApiParam(name = "spacePricePerhour", value = "场地该类型车位没小时停车费用", required = false) @RequestParam(value = "spacePricePerhour", required = false) String spacePricePerhour
			){
		String msg = null;
		int code = 0;
		Map<String,String> respMap = new HashMap<String, String>();
		//注册车主信息
		if(code == 0){
			
		}
		return new AppJsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
}
