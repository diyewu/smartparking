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
	
	public void getOrderListByMemberId(String memberId){
		String sql = "";
	}
	
	public List<Map<String, Object>> getOrderByParkCar(String parkId,String carId,int orderState){
		String sql = " select * from smart_order where car_id = ? and park_id = ? and order_state_id = ? ORDER BY create_time desc ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, carId,parkId,orderState);
		return list;
	}
	
}
