package com.xz.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class WebService {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	public List<Map<String, Object>> getObjectList(String userRole){
		String sql = " SELECT	pm.id,	pm.project_name AS menu_name FROM project_main pm left join project_condition_auth pca on pm.id = pca.condition_id where pca.web_user_role_id = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,userRole);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}
	
	
	
	
}
