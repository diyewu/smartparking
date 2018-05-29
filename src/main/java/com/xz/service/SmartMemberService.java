package com.xz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.utils.SortableUUID;

@Service
@Transactional
public class SmartMemberService {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	public String memberRegist(String memberName,int memberSex){
		String memberId = SortableUUID.randomUUID();
		String sql = " insert into smart_member(id,member_name,member_sex,create_time)VALUES(?,?,?,NOW()) ";
		jdbcTemplate.update(sql, memberId,memberName,memberSex);
		return memberId;
	}
	
	public List<Map<String, Object>> checkMemberByOpenId(String openId){
		String sql = " select * from smart_member where open_id = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, openId);
		return list;
	}
	
	public List<Map<String, Object>> getCarParkStateByMemId(String memberId){
		StringBuilder sb = new StringBuilder();
		sb.append(" select sc.car_number,so.order_state_id,sp.park_name ,sod.state_name ");
		sb.append(" from smart_car sc  ");
		sb.append(" left join smart_member sm on sc.member_id = sm.id ");
		sb.append(" left join smart_order so on so.car_id = sc.id and so.order_state_id in (1,2,3,4) ");
		sb.append(" left join smart_order_state_dictionory sod on so.order_state_id = sod.id ");
		sb.append(" left join smart_park sp on so.park_id = sp.id ");
		sb.append(" where sm.id = ? ");
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(StringUtils.isNotBlank(memberId)){
			list = jdbcTemplate.queryForList(sb.toString(), memberId);
		}
		return list;
	}
}
