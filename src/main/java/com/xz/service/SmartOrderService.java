package com.xz.service;

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
	
}
