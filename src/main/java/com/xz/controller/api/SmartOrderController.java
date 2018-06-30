package com.xz.controller.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.xz.common.ServerResult;
import com.xz.common.SmartParkDictionary;
import com.xz.controller.BaseController;
import com.xz.controller.weixin.WeixinConstants;
import com.xz.entity.CustomConfig;
import com.xz.entity.SmartOrder;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartMemberService;
import com.xz.service.SmartOrderService;
import com.xz.utils.SmartEncryptionUtil;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("smartOrder")
public class SmartOrderController extends BaseController{
	
	@Autowired
	private SmartOrderService smartOrderService;
	@Autowired
	private SmartMemberService smartMemberService;
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
			//step1 检查当前session
			HttpSession session = getRequest().getSession();
			String sessionMemberId = (String)session.getAttribute(WeixinConstants.SESSION_MEMBER_ID);
			if(StringUtils.isBlank(sessionMemberId)){
				//step2 校验参数
				msg = SmartEncryptionUtil.checkParameter(param, "memberId", customConfig.getAeskeycode());
				if(StringUtils.isNotBlank(msg)){
					code = ServerResult.RESULT_SERVER_ERROR;
				}
			}else{
				memberId = sessionMemberId; 
			}
			int total = 0;
			//step3 校验memberid
			if(code == 0){
				List<Map<String, Object>> list = smartMemberService.getMemberInfoById(memberId);
				if(list != null && list.size()>0){
					String openId = (String)list.get(0).get("open_id");
					if(StringUtils.isNotBlank(openId)){
						session.setAttribute(WeixinConstants.SESSION_MEMBER_ID, memberId);
						session.setAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID, openId);
					}else{
						code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
					}
				}else{
					code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
				}
			}
			//step4 获取订单信息，根据订单状态排序
			if(code == 0){
				total = smartOrderService.getOrderCountByMemberId(memberId);
				List<Map<String, Object>> list = smartOrderService.getOrderListByMemberId(memberId, pageIndex*pageSize,  (pageIndex+1)*pageSize);
				int totalPage = total/pageSize;
				int yushu =  total%pageSize;
				if(yushu > 0){
					totalPage = totalPage+1;
				}
				respMap.put("total", total);
				respMap.put("totalPage", totalPage);
				respMap.put("list", list);
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
	@ApiOperation(value = "根据订单编号获取订单详细信息", notes = "根据订单编号获取订单详细信息", httpMethod = "POST")
	@RequestMapping("getOrderInfoByOrderNo")
	@ResponseBody
	public JsonModel getOrderInfoByOrderNo(
			@ApiParam(name = "orderNo", value = "订单编号", required = true) @RequestParam(value = "orderNo", required = true) String orderNo
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		try {
			//step1 校验session参数,一定会有会员编号，一种是首页进来，一种是通过消息通知进来
			HttpSession session = getRequest().getSession();
			String memberId = (String)session.getAttribute(WeixinConstants.SESSION_MEMBER_ID);
			if(StringUtils.isBlank(memberId)){
				code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
			}
			//step 2 根据订单编号获取信息
			if(code == 0){
				list = smartOrderService.getOrderInfoById(orderNo);
				if(list == null || list.size() == 0){
					code = ServerResult.RESULT_ORDER_ID_ERROR;
				}
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	@ApiOperation(value = "更新订单状态", notes = "用户支付完成后，更新订单状态为‘支付完成，待出场’", httpMethod = "POST")
	@RequestMapping("updateOrderState")
	@ResponseBody
	public JsonModel updateOrderState(
			@ApiParam(name = "orderNo", value = "订单编号", required = true) @RequestParam(value = "orderNo", required = true) String orderNo,
			@ApiParam(name = "orderState", value = "订单状态", required = true) @RequestParam(value = "orderState", required = true) String orderState
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		try {
			//step 1 校验权限
			HttpSession session = getRequest().getSession();
			String openId = (String) session.getAttribute(WeixinConstants.SESSION_WEIXIN_OPEN_ID);
			if (StringUtils.isBlank(openId)) {
				code = ServerResult.RESULT_AUTH_VALIDATE_ERROR;
			}
			//step 2 根据orderNo 获取订单信息
			if (code == 0) {
				List<Map<String, Object>> list = smartOrderService.getOrderInfoByIdAndState(orderNo, SmartParkDictionary.orderState.PAY_FINISHED.ordinal());
				if (list == null || list.size() == 0) {
					code = ServerResult.RESULT_ORDER_ID_ERROR;
				} else {
					SmartOrder smartOrder = new SmartOrder();
					smartOrder.setId(orderNo);
					if("payFinished".equals(orderState)){
						smartOrder.setOrderStateId(SmartParkDictionary.orderState.PAY_FINISHED.ordinal());
					}else if("orderFinished".equals(orderState)){
						smartOrder.setOrderStateId(SmartParkDictionary.orderState.ORDER_FINISHED.ordinal());
					}
					smartOrderService.updateSmartOrder(smartOrder);
				}
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), null);
	}
	
	
	
	
	
}
