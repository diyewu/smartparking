package com.xz.service;

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
public class SmartCarService {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	public String carRegist(String memberId,String carNumber,String carOwnerId,int carType,String carId){
		if(StringUtils.isNotBlank(carId)){//更新
			this.updateSmartCar(carNumber, carType, carId);
			return carId;
		}else{
			return this.insertsmartCar(memberId, carNumber, carOwnerId, carType);
		}
	}
	
	public List<Map<String, Object>> checkMaxCar(String memberId){
		String sql = " select 1 from smart_car where member_id = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, memberId);
		return list;
	}
	
	public String updateSmartCar(String carNumber,int carType,String carId){
		String sql = " update smart_car(car_number,car_type,update_time)values(?,?,NOW())where id = ? ";
		jdbcTemplate.update(sql, carNumber,carType,carId);
		return null;
	}
	
	public String insertsmartCar(String memberId,String carNumber,String carOwnerId,int carType){
		String uuCarId = SortableUUID.randomUUID();
		String sql = " insert into smart_car(id,member_id,car_number,car_owner_id,car_type,create_time,update_time)values(?,?,?,?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, uuCarId,memberId,carNumber,carOwnerId,carType);
		return uuCarId;
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
