package com.xz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.utils.SortableUUID;

@Service
@Transactional
public class SmartParkService {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	/**
	 * 注册停车场主体信息
	 * @param parkName
	 * @param parkDescription
	 * @param parkLongitude
	 * @param parkLatitude
	 * @param managerId
	 * @param operateUserId
	 * @return
	 */
	public String registPark(String parkName,String parkDescription,String parkLongitude,String parkLatitude,String managerId,String operateUserId){
		String parkId = SortableUUID.randomUUID();
		String sql = " insert into smart_park(id,park_name,park_description,park_longitude,park_latitude,create_time,update_time,manager_id,operate_user_id)VALUES(?,?,?,?,?,NOW(),NOW(),?,?) ";
		jdbcTemplate.update(sql, parkId,parkName,parkDescription,parkLongitude,parkLatitude,managerId,operateUserId);
		return parkId;
	}
	
	/**
	 * 注册停车场入口信息，一个停车场可以有多个入口
	 * @param parkId
	 * @param entranceName
	 * @param entranceLongitude
	 * @param entranceLatitude
	 * @param entranceDescription
	 * @return
	 */
	public String registParkEntrance(String parkId,String entranceName,String entranceLongitude,String entranceLatitude,String entranceDescription){
		String entranceId = SortableUUID.randomUUID();
		String sql = " insert into smart_park_entrance(id,park_id,entrance_name,entrance_longitude,entrance_latitude,entrance_description,create_time,update_time)values(?,?,?,?,?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, entranceId,parkId,entranceName,entranceLongitude,entranceLatitude,entranceDescription);
		return entranceId;
	}
	
	/**
	 * 注册停车场车位信息，一个停车场可以有多种车位
	 * @param parkId
	 * @param spaceType
	 * @param spaceTotal
	 * @param spaceUsed
	 * @param spacePricePerhour
	 * @param spaceDescription
	 * @return
	 */
	public String registParkSpace(String parkId,String spaceType,int spaceTotal,int spaceUsed,double spacePricePerhour,String spaceDescription){
		String spaceId = SortableUUID.randomUUID();
		String sql = " insert into smart_park_space(id,park_id,space_type,space_total,space_used,space_price_perhour,space_description,create_time,update_time)values(?,?,?,?,?,?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, spaceId,parkId,spaceType,spaceTotal,spaceUsed,spacePricePerhour,spaceDescription);
		return spaceId;
	}
	
}
