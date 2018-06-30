package com.xz.controller.api;

import java.util.ArrayList;
import java.util.Date;
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
import com.xz.common.SmartParkDictionary;
import com.xz.controller.BaseController;
import com.xz.controller.weixin.WeixinSendTeleplate;
import com.xz.entity.CustomConfig;
import com.xz.entity.SmartOrder;
import com.xz.model.json.JsonModel;
import com.xz.service.SmartCarService;
import com.xz.service.SmartMemberService;
import com.xz.service.SmartOrderService;
import com.xz.service.SmartParkService;
import com.xz.utils.DateHelper;
import com.xz.utils.SmartEncryptionUtil;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
@RestController
@RequestMapping("demo")
public class DemoController extends BaseController{
	@Autowired
	private SmartParkService smartParkService;
	@Autowired
	private SmartCarService smartCarService;
	@Autowired
	private SmartOrderService smartOrderService;
	@Autowired
	private SmartMemberService smartMemberService;
	@Autowired  
    private CustomConfig customConfig; 
	
	@ApiOperation(value = "汽车申请驶入停车场地", notes = "由客户端识别汽车牌照", httpMethod = "POST")
	@RequestMapping("askInParking")
	@ResponseBody
	public JsonModel askInParking(
			 @ApiParam(name = "carNumber", value = "准备驶入停车场汽车牌照编号，有客户端自动识别或手动填写", required = true) @RequestParam(value = "carNumber", required = true) String carNumber,
			 @ApiParam(name = "parkId", value = "停车场编号", required = true) @RequestParam(value = "parkId", required = true) String parkId,
			 @ApiParam(name = "spaceId", value = "停车位类型编号", required = false) @RequestParam(value = "spaceId", required = false) String spaceId
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		String orderId = "";
		try {
			//TODO 进场，出场，产生订单
			//获取carid,
			String carId = smartCarService.getCarIdByNumber(carNumber);
			if(StringUtils.isBlank(carId)){//车辆信息不存在
				code = ServerResult.RESULT_CAR_NOT_REGIST_ERROR;
			}
			if(code == 0){
				//车辆申请停车，TODO 判断是否允许车辆停车,需要判断车位剩余数量信息  判断车辆 是否需要付钱
				code = smartOrderService.checkCarForbidParking(carId, parkId);
				if(code == 0){//申请成功，允许车辆进入，创建订单
					orderId = smartOrderService.createOrder(carId, parkId, 0,spaceId);
				}
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		respMap.put("orderId", orderId);
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
	
	@ApiOperation(value = "汽车申请驶出停车场地", notes = "由机器客户端识别汽车牌照，返回：开始停车时间、结束停车时间、停车场地、车位、总共产生停车费用，推送到APP客户端，等待会员支付", httpMethod = "POST")
	@RequestMapping("askOutParking")
	@ResponseBody
	public JsonModel askOutParking(
			@ApiParam(name = "carNumber", value = "准备驶出停车场汽车牌照编号，有客户端自动识别或手动填写", required = true) @RequestParam(value = "carNumber", required = false) String carNumber,
			@ApiParam(name = "parkId", value = "停车场编号", required = true) @RequestParam(value = "parkId", required = true) String parkId
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		String orderId = "";
		try {
			//获取carid,
			String carId = "";
			// 会员编号，用来推送支付信息,TODO member_id car_owner_id 应怎么样处理或取舍，发送支付订单信息应想member_id发送，
			//car为该会员注册进入。如果车主再次注册该车辆该如何处理
			String memberId = "";
			List<Map<String, Object>> carList = smartCarService.getMemberInfoByCarNumber(carNumber);
			if(carList != null && carList.size()>0){
				carId = (String)carList.get(0).get("id");
				memberId = (String)carList.get(0).get("member_id");
			}
			if(StringUtils.isBlank(carId)){//车辆信息不存在
				code = ServerResult.RESULT_CAR_NOT_REGIST_ERROR;
			}
			String format = "yyyy-MM-dd HH:mm:ss";
			double totalParkingFee = 0;
			if(code == 0){
				//车辆申请驶出场地，返回，开始停车时间、结束停车时间、停车场地、车位、总共产生停车费用，到会员客户端，等待会员支付
				//step 1、查看是否有满足条件的订单，carId，parkId，order_state_id=2
				//TODO 如何处理多条  同样carId，parkId，order_state_id=2 订单，暂时先按照第一条处理
				List<Map<String, Object>> list = smartOrderService.getOrderId(carId, parkId, SmartParkDictionary.orderState.CAR_PARKING.ordinal());
				if (list != null && list.size() > 0) {
					orderId = list.get(0).get("id")+"";
				}else{
					code = ServerResult.RESULT_ORDER_DONOT_EXSIT_ERROR;
				}
				//step 2、根据订单信息，获取进场record，
				List<Map<String, Object>> orderList = new ArrayList<Map<String,Object>>();
				if(code == 0){
					orderList = smartOrderService.getOrderInfo(orderId);
					if(orderList == null || orderList.size() == 0){
						code = ServerResult.RESULT_ORDER_STATE_ERROR;
					}
				}
				//step 3 计算停车费用,更新订单状态
				if(code == 0){
					
					String beginTimeStr = orderList.get(0).get("begin_time")+"";
					Date beginTime = DateHelper.paraseStringToDate(beginTimeStr, format);
					Date endTime = new Date();
					String endTimeStr = DateHelper.paraseDateToString(endTime, format);
					long between=(endTime.getTime()-beginTime.getTime())/1000;//除以1000是为了转换成秒
					long min=between/60;//获取分钟数
					double hour = min/60;
					long yushu = min%60;//取整数小时候，余 分钟数,不满30分钟，按照0.5小时计算，大于30分钟按1小时计算
					if(yushu <= 30){
						hour = hour+0.5;
					}else{
						hour = hour + 1;
					}
					double spacePricePerhour = 0;
					try {
						spacePricePerhour = Double.parseDouble(orderList.get(0).get("space_price_perhour")+"");
					} catch (Exception e) {
						e.printStackTrace();
					}
					totalParkingFee = hour * spacePricePerhour;
					String parkName = orderList.get(0).get("park_name")+"";
					String spaceName = orderList.get(0).get("space_name")+"";
					
					respMap.put("orderId", orderId);//用于用户返回更新订单状态
					respMap.put("parkName", parkName);
					respMap.put("spaceName", spaceName);
					respMap.put("beginTime", beginTimeStr);
					respMap.put("endTime", endTimeStr);
					respMap.put("totalParkingFee", totalParkingFee);
					
					//更新订单状态
					SmartOrder smartOrder = new SmartOrder();
					smartOrder.setId(orderId);
					smartOrder.setOrderStateId(SmartParkDictionary.orderState.ASK_OUT.ordinal());
					smartOrder.setBeginTime(beginTimeStr);
					smartOrder.setEndTime(endTimeStr);
					smartOrder.setReceivableAmount(totalParkingFee);
					try {
						smartOrderService.updateSmartOrder(smartOrder);
					} catch (Exception e) {
						msg = e.getMessage();
						code = ServerResult.RESULT_SERVER_ERROR;
						e.printStackTrace();
					}
				}
				//TODO 向客户端发送消息信息，提醒客户支付，车牌号做唯一验证
				if(code == 0){
					//根据memberId获取用户open_id
					List<Map<String, Object>> memberList = smartMemberService.getMemberInfoById(memberId);
					if(memberList != null && memberList.size()>0){
						String openId = (String)memberList.get(0).get("open_id");
						long paramTime = System.currentTimeMillis();
						Map<String, String> param = new HashMap<String, String>();
						param.put("time", paramTime+"");
						param.put("memberId", memberId);
						String sign = SmartEncryptionUtil.encryParam(param, "memberId", customConfig.getAeskeycode());
						String url = "https://zhonglestudio.cn/smartparking/weixin/order.html?time="+
						paramTime+"&memberId="+memberId+"&sign="+sign;
						System.out.println("url="+url);
					    long time = 120*60*1000;//30分钟
					    Date now = new Date();
					    Date afterDate = new Date(now .getTime() + time);//30分钟后的时间
					    String failureTime = DateHelper.paraseDateToString(afterDate, format);
						WeixinSendTeleplate.sendUnpaidInfo(openId, url, orderId, totalParkingFee+"", "微信支付", failureTime,customConfig.getAppid(),customConfig.getSecret());
					}else{
						code =ServerResult.RESULT_MEMBER_AUTH_ERROR;
					}
				}
			}
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	

	@ApiOperation(value = "用户支付", notes = "用户收到服务器推送消息，在线支付应收费用，web页面支付完成后更新订单", httpMethod = "POST")
	@RequestMapping("onlinePay")
	@ResponseBody
	public JsonModel onlinePay(
			@ApiParam(name = "memberId", value = "会员编号", required = true) @RequestParam(value = "memberId", required = true) String memberId,
			@ApiParam(name = "orderId", value = "订单编号", required = true) @RequestParam(value = "orderId", required = true) String orderId,
			@ApiParam(name = "payWayId", value = "支付方式", required = true) @RequestParam(value = "payWayId", required = true) String payWayId,
			@ApiParam(name = "PaymentReceipt", value = "支付回执", required = true) @RequestParam(value = "PaymentReceipt", required = true) String PaymentReceipt
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		try {
			double actualAmount = 0;//
			//step1 校验订单编号和会员编号是否一致
			List<Map<String, Object>> chechList = smartOrderService.checkOrderIdAndMemberId(orderId, memberId);
			if (chechList == null || chechList.size() == 0) {
				code = ServerResult.RESULT_ORDERID_MEMBERID_NOTMATCH_ERROR;
			}
			//step2 TODO 校验支付回执，并取出支付款数额，作为订单实付金额
			actualAmount = 0;//TODO
			//step3 根据订单编号更新订单
			if (code == 0) {
				SmartOrder smartOrder = new SmartOrder();
				smartOrder.setId(orderId);
				smartOrder.setPayWayId(payWayId);
				smartOrder.setActualAmount(actualAmount);
//				smartOrder.setOrderStateId(SmartParkDictionary.PAY_FINISHED);
				smartOrder.setOrderStateId(SmartParkDictionary.orderState.PAY_FINISHED.ordinal());
			} 
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	@ApiOperation(value = "汽车驶入或驶出停车场地", notes = "由客户端识别汽车牌照", httpMethod = "POST")
	@RequestMapping("parking")
	@ResponseBody
	public JsonModel parking(
			@ApiParam(name = "carNumber", value = "准备驶入停车场汽车牌照编号，有客户端自动识别或手动填写", required = true) @RequestParam(value = "carNumber", required = false) String carNumber,
			@ApiParam(name = "parkId", value = "停车场编号", required = true) @RequestParam(value = "parkId", required = true) String parkId,
			@ApiParam(name = "spaceId", value = "停车位编号", required = false) @RequestParam(value = "spaceId", required = false) String spaceId,
			@ApiParam(name = "entranceId", value = "停车场入口编号", required = false) @RequestParam(value = "entranceId", required = false) String entranceId,
			@ApiParam(name = "parkingType", value = "停车类型，0：驶入 1：驶出", required = true) @RequestParam(value = "parkingType", required = true) int parkingType,
			@ApiParam(name = "description", value = "停车说明", required = false) @RequestParam(value = "description", required = false) String description
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		if(code == 0){
			try {
				//获取carid,
				String carId = smartCarService.getCarIdByNumber(carNumber);
				if(StringUtils.isBlank(carId)){//车辆信息不存在
					code = ServerResult.RESULT_CAR_NOT_REGIST_ERROR;
				}
				String orderId = "";
				String recordId = "";
				if(code == 0){
					int orderState = 10000;
					SmartOrder smartOrder = new SmartOrder();
					if(parkingType == 0){//驶入
						orderState = SmartParkDictionary.orderState.ASK_IN.ordinal();
						String format = "yyyy-MM-dd HH:mm:ss";
						String beginTime = DateHelper.paraseDateToString(new Date(), format);
//						smartOrder.setId(orderId);
						smartOrder.setBeginTime(beginTime);
						smartOrder.setOrderStateId(SmartParkDictionary.orderState.CAR_PARKING.ordinal());
					}else{//驶出
						orderState = SmartParkDictionary.orderState.CAR_PARKING.ordinal();
//						smartOrder.setId(orderId);
						smartOrder.setOrderStateId(SmartParkDictionary.orderState.ORDER_FINISHED.ordinal());
					}
					//step1 根据parkid和carid获取状态为“申请驶进停车场”订单信息，TODO 如何处理存在多条记录   如果获取不到，TODO 则走人工流程
					List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
					try {
						list = smartOrderService.getOrderId(carId, parkId, orderState);
						if (list != null && list.size() > 0) {
							orderId = list.get(0).get("id") + "";
						} else {
							code = ServerResult.RESULT_ORDER_DONOT_EXSIT_ERROR;
						} 
					} catch (Exception e) {
						msg = e.getMessage();
						code = ServerResult.RESULT_SERVER_ERROR;
						e.printStackTrace();
					}
					if(code == 0 && StringUtils.isBlank(orderId)){
						code = ServerResult.RESULT_ORDER_STATE_ERROR;
					}
					if(code == 0){
						smartOrder.setId(orderId);
					}
					//step2 创建停车出入场地记录
					if(code == 0){
						recordId = smartOrderService.parkIngIn(carId, parkId, spaceId, entranceId,parkingType);
						if(StringUtils.isBlank(recordId)){
							code = ServerResult.RESULT_RECORD_CREATE_ERROR;
						}
					}
					//step3 更新订单状态
					if(code == 0){
						if(parkingType == 0){
							smartOrder.setRecordInId(recordId);
						}else{
							smartOrder.setRecordOutId(recordId);
						}
						smartOrderService.updateSmartOrder(smartOrder);
					}
					if(code == 0){
						//TODO  发送驶入停车场通知给用户
					}
				}
			} catch (Exception e) {
				code = ServerResult.RESULT_SERVER_ERROR;
				msg = e.getMessage();
				e.printStackTrace();
			}
		}
		respMap.put("parkId", parkId);
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
	
	@ApiOperation(value = "加载车辆信息", notes = "加载车辆信息", httpMethod = "POST")
	@RequestMapping("listCar")
	@ResponseBody
	public JsonModel listCar(){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(code == 0){
			try {
				list = smartCarService.listCar();
			} catch (Exception e) {
				code = ServerResult.RESULT_SERVER_ERROR;
				msg = e.getMessage();
				e.printStackTrace();
			}
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	@ApiOperation(value = "加载停车场信息", notes = "加载停车场信息", httpMethod = "POST")
	@RequestMapping("listPark")
	@ResponseBody
	public JsonModel listPark(){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(code == 0){
			try {
				list = smartParkService.listPark();
			} catch (Exception e) {
				code = ServerResult.RESULT_SERVER_ERROR;
				msg = e.getMessage();
				e.printStackTrace();
			}
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	@ApiOperation(value = "根据停车场地加载车位信息", notes = "根据停车场地加载车位信息", httpMethod = "POST")
	@RequestMapping("listSpaceByPark")
	@ResponseBody
	public JsonModel listSpaceByPark(
			@ApiParam(name = "parkId", value = "停车场地编号", required = true) @RequestParam(value = "parkId", required = true) String parkId
			){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(code == 0){
			try {
				list = smartParkService.listSpaceByParkId(parkId);
			} catch (Exception e) {
				code = ServerResult.RESULT_SERVER_ERROR;
				msg = e.getMessage();
				e.printStackTrace();
			}
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), list);
	}
	
	
	
}
