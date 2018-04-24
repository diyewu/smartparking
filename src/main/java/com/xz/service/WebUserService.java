package com.xz.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.common.Page;
import com.xz.entity.CategoryTreeBeanCk;
import com.xz.entity.ModuleStoreBean;
import com.xz.entity.UserLogin;
import com.xz.entity.UserRole;
import com.xz.service.UserService.ModuleStoreBeanRowMapper;
import com.xz.service.UserService.UserRoleRowMapper;

@Service
@Transactional
public class WebUserService {
	
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	
	
	public List<CategoryTreeBeanCk> getTreeCKListAuthDo_bak(String roleId) {//赋予权限
		List<CategoryTreeBeanCk> list = new ArrayList<CategoryTreeBeanCk>();
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT CASE WHEN pac.type = 0 THEN pac.id ELSE pac.attribute_id END id, pac.attribute_condition AS menu_name, CASE WHEN pac.type = 2 THEN NULL ELSE pac.attribute_id END AS parent_id, pac.leaf, pac.id AS is_check FROM project_attribute_condition pac LEFT JOIN ( SELECT * FROM project_condition_auth pca WHERE pca.web_user_role_id = ? ) b ON pac.id = b.condition_id ORDER BY pac.id ASC; ");
		list = (List<CategoryTreeBeanCk>)jdbcTemplate.query(sb.toString(), new CategoryTreeBeanCKRowMapper(),roleId);
		return list;
	}
	public List<CategoryTreeBeanCk> getTreeCKListAuthDo(String roleId) {//赋予权限
		List<CategoryTreeBeanCk> list = new ArrayList();
		StringBuilder sb = new StringBuilder();
		sb.append(" select a.id,	a.menu_name,	a.parent_id,	a.leaf	,b.web_user_role_id as is_check from ");
		sb.append(" (SELECT	id,	pac.attribute_condition AS menu_name,	pac.attribute_id AS parent_id,	pac.leaf,	pac.id AS is_check FROM 	project_attribute_condition pac  ");
		sb.append(" union  ");
		sb.append(" SELECT id,	pa.attribute_name AS menu_name,		pa.project_id AS parent_id,		0 AS leaf,		pa.id AS is_check	FROM 		project_attribute pa	WHERE		pa.attribute_active = 1 ");
		sb.append(" union  ");
		sb.append(" SELECT id,	pm.project_name AS menu_name,	NULL AS parent_id,	0 AS leaf,	pm.id AS is_check	FROM	project_main pm where pm.type = 1	 ");
		sb.append(" )a left JOIN (  ");
		sb.append(" select * from project_condition_auth pca 	where pca.web_user_role_id = ?  ");
		sb.append(" ) b on a.id = b.condition_id ORDER BY a.id DESC  ");
		list = (List<CategoryTreeBeanCk>)jdbcTemplate.query(sb.toString(), new CategoryTreeBeanCKRowMapper(),roleId);
		return list;
	}
	public static class CategoryTreeBeanCKRowMapper implements RowMapper<CategoryTreeBeanCk> {
		@Override
		public CategoryTreeBeanCk mapRow(ResultSet rs, int rowNum) throws SQLException {
			CategoryTreeBeanCk tree = new CategoryTreeBeanCk();
			tree.setId(rs.getString("id"));
			tree.setText(rs.getString("menu_name"));
			tree.setParent_id(rs.getString("parent_id"));
			tree.setLeaf(rs.getInt("leaf")==0?false:true );
			tree.setChecked(rs.getString("is_check") == null?false:true);
			return tree;
		}
	}
	public List<UserRole> getRoleList(Map<String, String> condition,StringBuilder sb){
		List<UserRole> list = new ArrayList<UserRole>();
		List<Object> params = new ArrayList<Object>();
		StringBuilder sbud = new StringBuilder(" select * from web_user_role where is_delete = 0 ");
		if (!condition.isEmpty()) { 
			if (condition.containsKey("roleName")) {
				sbud.append(" and role_name like ?");
				params.add("%"+condition.get("roleName")+"%");
			}
			list = (List<UserRole>) jdbcTemplate.query(sbud.toString(), new UserRoleRowMapper(), params.toArray(new Object[params.size()]));
			sb.append(list.size());
			if (condition.containsKey("start") && condition.containsKey("limit")) {
				sbud.append(" LIMIT ?,? ");
				int start = Integer.parseInt(condition.get("start"));
				int limit = Integer.parseInt(condition.get("limit"));
				params.add(start);
				params.add(limit);
			}
		}
		list = new ArrayList<UserRole>();
		list = (List<UserRole>) jdbcTemplate.query(sbud.toString(), new UserRoleRowMapper(), params.toArray(new Object[params.size()]));
		if (list != null && list.size() > 0) {
			return list;
		}
		return null;
	}
	
	
	public Page<Map<String, Object>> getConsoleUserList(Map<String, String> condition){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(0, 1000, false);
		List<Object> params = new ArrayList<Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		StringBuilder sbud = new StringBuilder("select a.id,a.user_name,a.user_password,a.is_delete,a.user_role as user_role_id,b.role_name as user_role,"
				+ "real_name,CASE when c.use_size is null then 0 else c.use_size end as use_phone_size, a.allow_phone_size,a.enable_time,a.disable_time "
				+ "from web_user_login a left join web_user_role b on a.user_role = b.id "
				+ " left join (select count(wp.id) as use_size,wp.web_user_id from web_user_login_phone wp GROUP BY wp.web_user_id) c on c.web_user_id = a.id "
				+ "where 1 = 1 and a.is_delete = 0 and b.is_delete = 0 ");
		if (!condition.isEmpty()) { 
			if (condition.containsKey("userName")) {
				sbud.append(" and a.user_name like ?");
				params.add("%"+condition.get("userName")+"%");
			}
			if(condition.containsKey("userRole")){
				sbud.append(" and a.user_role = ?");
				params.add(condition.get("userRole"));
			}
			List<Map<String, Object>> countList = jdbcTemplate.queryForList(sbud.toString(),params.toArray());
			page.setTotalCount(countList.size());
			if (condition.containsKey("start") && condition.containsKey("limit")) {
				sbud.append(" LIMIT ?,? ");
				int start = Integer.parseInt(condition.get("start"));
				int limit = Integer.parseInt(condition.get("limit"));
				params.add(start);
				params.add(limit);
			}
			list = jdbcTemplate.queryForList(sbud.toString(),params.toArray());
		}
		page.setResult(list);
		return page;
	}
	
	public List<ModuleStoreBean> getRole(){
		return jdbcTemplate.query(" select id,role_name from web_user_role where is_delete = 0 ",new ModuleStoreBeanRowMapper());
	}
	
	public boolean isExitUser(String userName,String userId){
		int i = 0;
		List<Map<String, Object>> list  = new ArrayList<Map<String,Object>>();
		if (StringUtils.isBlank(userId)) {
			list = jdbcTemplate.queryForList("select count(1) as ct from web_user_login where user_name = ? and is_delete = 0 ",userName);
		}else{
			list = jdbcTemplate.queryForList("select count(1) as ct from web_user_login where user_name = ? and id <> ? and is_delete = 0 ",userName,userId);
		}
		if (list != null && list.size() > 0) {
			i = Integer.parseInt(list.get(0).get("ct")+"");
		}
		return i>0;
	}
	
	public void addUser(String userName,String userPwd,int role,
			String realName,int phoneSizeInt,String beginTime ,String endTime){
		String uuid = UUID.randomUUID().toString().replace("-", "");
		jdbcTemplate.update("insert into web_user_login"
				+ "(id,user_name,user_password,user_role,real_name,allow_phone_size,enable_time,disable_time)"
				+ "values(?,?,?,?,?,?,?,?)",uuid,userName,userPwd,role,realName,phoneSizeInt,beginTime,endTime);
	}
	public void editUser(UserLogin user){
		if(StringUtils.isNotBlank(user.getId())){
			List<Object> params = new ArrayList<Object>();
			StringBuilder sb = new StringBuilder(" update web_user_login set id = ? ");
			params.add(user.getId());
			if(StringUtils.isNotBlank(user.getUserName())){
				sb.append(",user_name = ?");
				params.add(user.getUserName());
			}
			if(StringUtils.isNotBlank(user.getUserPassword())){
				sb.append(",user_password = ?");
				params.add(user.getUserPassword());
			}
			if(StringUtils.isNotBlank(user.getUserRole()+"")){
				sb.append(",user_role = ?");
				params.add(user.getUserRole());
			}
			if(StringUtils.isNotBlank(user.getRealName()+"")){
				sb.append(",real_name = ?");
				params.add(user.getRealName());
			}
			if(StringUtils.isNotBlank(user.getAllowPhoneSize()+"")){
				sb.append(",allow_phone_size = ?");
				params.add(user.getAllowPhoneSize());
			}
			if(StringUtils.isNotBlank(user.getEnableTime())){
				sb.append(",enable_time = ?");
				params.add(user.getEnableTime());
			}
			if(StringUtils.isNotBlank(user.getDisableTime()+"")){
				sb.append(",disable_time = ?");
				params.add(user.getDisableTime());
			}
			sb.append(" where id = ?");
			params.add(user.getId());
			jdbcTemplate.update(sb.toString(), params.toArray(new Object[params.size()]));
			
		}
	}
	
	public void updatePwd(String userId,String userName,String newUserPwd){
//		String md5Pwd = Md5Util.generatePassword(newUserPwd);
		jdbcTemplate.update("update web_user_login set user_password = ? where id =? ",newUserPwd,userId);
	}
	public void DeleteWebRoleAuth(String roleId){
		jdbcTemplate.update("delete from project_condition_auth where web_user_role_id =?",roleId);
	}
	public void addWebRoleAuth(String roleId,String conditionId){
		jdbcTemplate.update("insert into project_condition_auth (web_user_role_id,condition_id) values(?,?)",roleId,conditionId);
	}
	public void addRole(String roleName){
		jdbcTemplate.update("insert into web_user_role(role_name)values(?)",roleName);
	}
	public boolean isExitRole(String roleName){
		int i = 0;
		List<Map<String, Object>> list = jdbcTemplate.queryForList("select * from web_user_role where role_name = ? and is_delete = 0 ",roleName);
		if(list != null){
			i = list.size();
		}
		return i>0;
	}
	
	public void deleteUserByRoleId(String roleId){
		if(StringUtils.isNotBlank(roleId)){
//			jdbcTemplate.update("update web_user_login set is_delete = 1 where user_role =?",roleId);
			String sql  = " select id from web_user_login where user_role = ? ";
			List<Map<String, Object>> webUserlist = jdbcTemplate.queryForList(sql, roleId);
			if (webUserlist != null && webUserlist.size() > 0) {
				String webUserId =""; 
				for(int i=0;i<webUserlist.size();i++){
					webUserId = webUserlist.get(i).get("id")+"";
					if(StringUtils.isNotBlank(webUserId)){
						deleteUser(webUserId);
					}
				}
			}
		}
	}
	public void deleteRole(String roleId){
		if(StringUtils.isNotBlank(roleId)){
			jdbcTemplate.update("update web_user_role set is_delete = 1 where id =?",roleId);
		}
	}
	public void deleteUser(String userId){
		if(StringUtils.isNotBlank(userId)){
			jdbcTemplate.update("update web_user_login set is_delete = 1 where id =?",userId);
			deleteUserPhone(userId);
		}
	}
	public void deleteUserPhone(String userPhoneId){
		if(StringUtils.isNotBlank(userPhoneId)){
			jdbcTemplate.update("delete from web_user_login_phone where id = ?",userPhoneId);
		}
	}
	
	public void editRole(String roleId,String roleName){
		if(StringUtils.isNotBlank(roleId)){
			List<Object> params = new ArrayList<Object>();
			StringBuilder sb = new StringBuilder(" update web_user_role set id = ? ");
			params.add(roleId);
			if(StringUtils.isNotBlank(roleName)){
				sb.append(",role_name = ?");
				params.add(roleName);
			}
			sb.append(" where id = ?");
			params.add(roleId);
			jdbcTemplate.update(sb.toString(), params.toArray(new Object[params.size()]));
		}
	}
	public Page<Map<String, Object>> listUserPhone (Map<String, String> condition){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(0, 1000, false);
		List<Object> params = new ArrayList<Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		StringBuilder sbud = new StringBuilder("select wp.create_date, wp.id,wp.phone_id,wl.user_name,wl.real_name from web_user_login_phone wp "
				+ "inner join web_user_login wl on wp.web_user_id = wl.id and wl.is_delete = 0 ");
		if (!condition.isEmpty()) { 
			if (condition.containsKey("userRealName")) {
				sbud.append(" and wl.real_name like ?");
				params.add("%"+condition.get("userRealName")+"%");
			}
			if(condition.containsKey("userLoginName")){
				sbud.append(" and wl.user_name like ?");
				params.add("%"+condition.get("userLoginName")+"%");
			}
			List<Map<String, Object>> countList = jdbcTemplate.queryForList(sbud.toString(),params.toArray());
			page.setTotalCount(countList.size());
			if (condition.containsKey("start") && condition.containsKey("limit")) {
				sbud.append(" LIMIT ?,? ");
				int start = Integer.parseInt(condition.get("start"));
				int limit = Integer.parseInt(condition.get("limit"));
				params.add(start);
				params.add(limit);
			}
			list = jdbcTemplate.queryForList(sbud.toString(),params.toArray());
		}
		page.setResult(list);
		return page;
	}
	
	
}