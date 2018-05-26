package com.xz.service;

import java.util.List;
import java.util.Map;

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
}
