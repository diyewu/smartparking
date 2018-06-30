package com.xz.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.common.SmartParkDictionary;
import com.xz.entity.SmartOrder;
import com.xz.entity.SmartPark;
import com.xz.entity.SmartSpace;
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
	
	/**
	 * 
	 * @return
	 */
	public List<Map<String, Object>> listPark(){
		String sql = " select * from smart_park ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		return list;
	}
	
	public List<Map<String, Object>> listSpaceByParkId(String parkId){
		String sql = " select sps.id,spsd.space_name,sps.space_price_perhour from smart_park_space sps left join smart_park_space_dictionary spsd on sps.space_type = spsd.id where park_id = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,parkId);
		return list;
	}
	
	/**
	 * 获取全部停车场列表
	 * @return
	 */
	public List<SmartPark> getParkList(String keyWord){
		StringBuilder sb = new StringBuilder();
		sb.append(" select sp.id,sp.park_name,sp.park_longitude,sp.park_latitude,sp.support_mobile_pay ");
		sb.append(" from smart_park sp ");
		sb.append(" where 1=1 ");
		List<String> param = new ArrayList<String>();
		if(StringUtils.isNotBlank(keyWord)){
			sb.append(" and sp.name like ? ");
			param.add("%"+keyWord+"%");
		}
		List<SmartPark> list = (List<SmartPark>)jdbcTemplate.query(sb.toString(),new SmartParkBeanRowMapper(),param.toArray());
		return list;
	}
	
	
	public List<SmartSpace> getParkSpaceByParkId(String parkId){
		String sql = " select * from smart_park_space where park_id = ? ";
		List<SmartSpace> list = (List<SmartSpace>)jdbcTemplate.query(sql,new SmartSpaceBeanRowMapper(),parkId);
		return list;
	}
	public static class SmartParkBeanRowMapper implements RowMapper<SmartPark> {
		@Override
		public SmartPark mapRow(ResultSet rs, int rowNum) throws SQLException {
			SmartPark sp = new SmartPark();
			sp.setId(rs.getString("id"));
			sp.setName(rs.getString("park_name"));
			sp.setLongitude(rs.getDouble("park_longitude"));
			sp.setLatitude(rs.getDouble("park_latitude"));
//			sp.setSpacePricePerhour(rs.getDouble("space_price_perhour"));
			sp.setSupportMobilePay(rs.getInt("support_mobile_pay"));
			return sp;
		}
	}
	public static class SmartSpaceBeanRowMapper implements RowMapper<SmartSpace> {
		@Override
		public SmartSpace mapRow(ResultSet rs, int rowNum) throws SQLException {
			SmartSpace sp = new SmartSpace();
			sp.setId(rs.getString("id"));
			sp.setParkId(rs.getString("park_id"));
			sp.setSpaceType(rs.getInt("space_type"));
			sp.setSpaceTotal(rs.getInt("space_total"));
			sp.setSpaceUsed(rs.getInt("space_used"));
			sp.setSpacePricePerhour(rs.getDouble("space_price_perhour"));
			sp.setSpaceDescription(rs.getString("space_description"));
			return sp;
		}
	}
	
	
	
}
