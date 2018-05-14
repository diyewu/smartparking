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
public class SmartCarService {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	public String carRegist(String memberId,String carNumber,String carOwnerId,int carType){
		String carId = SortableUUID.randomUUID();
		String sql = " insert into smart_car(id,member_id,car_number,car_owner_id,car_type,create_time,update_time)values(?,?,?,?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, carId,memberId,carNumber,carOwnerId,carType);
		return carId;
	}
	
	public String ownerRegist(String ownerName,String ownerAdress,String ownerPhone){
		String ownerId = SortableUUID.randomUUID();
		String sql = " insert into smart_car_owner(id,owner_name,owner_address,owner_phone,create_time,update_time)values(?,?,?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, ownerId,ownerName,ownerAdress,ownerPhone);
		return ownerId;
	}
	public String ownerIsMemberRegist(String memberId){
		String ownerId = SortableUUID.randomUUID();
		String sql = " insert into smart_car_owner(id,member_id,create_time,update_time)values(?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, ownerId,memberId);
		return ownerId;
	}
	
	
	public List<Map<String, Object>> listCar(){
		String sql = " select id,car_number from smart_car ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		return list;
	}
	
	public String getCarIdByNumber(String carNumber){
		String sql = " select id from smart_car where car_number = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,carNumber);
		String carId = "";
		if(list != null && list.size()>0){
			carId = list.get(0).get("id")+"";
		}
		return carId;
	}
	
	
}
