package com.xz.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SmartOrderService {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	public List<Map<String, Object>> getOrderByParkCar(String parkId,String carId,int orderState){
		String sql = " select * from smart_order where car_id = ? and park_id = ? and order_state_id = ? ORDER BY create_time desc ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, carId,parkId,orderState);
		return list;
	}
	
	/**
	 * 根据会员编号获取订单总数，分页使用
	 * @param memberId
	 * @return
	 */
	public int getOrderCountByMemberId(String memberId){
		int count = 0;
		String sql = " SELECT so.id, sosd.show_name FROM smart_order so LEFT JOIN smart_order_state_dictionory sosd ON so.order_state_id = sosd.id LEFT JOIN smart_car sc ON so.car_id = sc.id WHERE sc.member_id = ? ORDER BY so.create_time desc ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, memberId);
		if(list != null){
			count = list.size();
		}
		return count;
	}
	/**
	 * 根据会员编号获取订单
	 * @param memberId
	 * @param min
	 * @param max
	 * @return
	 */
	public List<Map<String, Object>> getOrderListByMemberId(String memberId,int min,int max){
		String sql = " SELECT so.id, sosd.id AS status,so.receivable_amount, sosd.show_name, sp.park_name FROM smart_order so LEFT JOIN smart_order_state_dictionory sosd ON so.order_state_id = sosd.id LEFT JOIN smart_car sc ON so.car_id = sc.id LEFT JOIN smart_park sp ON so.park_id = sp.id WHERE sc.member_id = ? ORDER BY so.create_time desc limit ? , ? ";
		if(max == 0){
			max = 10;
		}
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, memberId,min,max);
		return list;
	}
	
	/**
	 * 获取待支付的订单
	 * 根据订单Id获取订单详细信息
	 * @param orderId
	 * @return
	 */
	public List<Map<String, Object>> getOrderInfoById(String orderId){
		String sql = " select id, begin_time,end_time,receivable_amount from smart_order where id = ? and order_state_id = 3 ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, orderId);
		return list;
	}
	
	
	
}
