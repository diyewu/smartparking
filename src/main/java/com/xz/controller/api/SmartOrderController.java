package com.xz.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.xz.common.ServerResult;
import com.xz.entity.CustomConfig;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartOrderService;
import com.xz.utils.SmartEncryptionUtil;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("smartOrder")
public class SmartOrderController {
	
	@Autowired
	private SmartOrderService smartOrderService;
	@Autowired  
    private CustomConfig customConfig; 
	
	@ApiOperation(value = "获取订单列表", notes = "获取订单列表", httpMethod = "POST")
	@RequestMapping("getOrderList")
	@ResponseBody
	public JsonModel getOrderList(
			 @ApiParam(name = "memberId", value = "会员编号", required = true) @RequestParam(value = "memberId", required = true) String memberId,
			 @ApiParam(name = "time", value = "时间戳", required = true) @RequestParam(value = "time", required = true) String time,
			 @ApiParam(name = "sign", value = "验证签名", required = true) @RequestParam(value = "sign", required = true) String sign,
			 @ApiParam(name = "pageIndex", value = "当前页", required = true) @RequestParam(value = "pageIndex", required = true) int pageIndex,
			 @ApiParam(name = "pageSize", value = "每个页面订单数量", required = true) @RequestParam(value = "pageSize", required = true) int pageSize
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		try {
			Map<String, String> param = new HashMap<String, String>();
			param.put("time", time);
			param.put("sign", sign);
			param.put("memberId", memberId);
			//step1 校验参数
			msg = SmartEncryptionUtil.checkParameter(param, "memberId", customConfig.getAeskeycode());
			if(StringUtils.isNotBlank(msg)){
				code = ServerResult.RESULT_SERVER_ERROR;
			}
			int total = 0;
			//step2 获取订单信息，根据订单状态排序
			if(code == 0){
				total = smartOrderService.getOrderCountByMemberId(memberId);
				List<Map<String, Object>> list = smartOrderService.getOrderListByMemberId(memberId, pageIndex*pageSize,  (pageIndex+1)*pageSize);
				respMap.put("total", total);
				respMap.put("list", list);
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
}
