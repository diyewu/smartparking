package com.xz.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.common.Page;
import com.xz.utils.ExcelReadUtils;
import com.xz.utils.SortableUUID;


@Service
@Transactional
public class PeojectServices {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	@Autowired
	private OperateHistoryService operateHistoryService;
	
	@Transactional
	public String importProjectData(HttpServletRequest request,File file,String title,String path,String createUser){
		ArrayList<ArrayList<Object>> list = new ArrayList<ArrayList<Object>>();
		String msg = null;
		String type = "5";//导入项目数据
		try {
			 list = ExcelReadUtils.readAllRows(file);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (list == null || list.size() == 0) {
			msg = "请检查上传附件内容，数据为空！";
			insertOperateHistory(request, type, msg);
			return null;
		}
		if(StringUtils.isBlank(title)){
			title = list.get(0).get(0)+"";
		}
		if(StringUtils.isBlank(title)){
			msg = "格式有误，请确认第一行第一列为项目标题！";
			insertOperateHistory(request, type, msg);
			return null;
		}
		//插入项目主表数据
		String projectId = SortableUUID.randomUUID();
		String mainSql = " insert into project_main(id,project_name,create_time,create_user_id,file_path)values(?,?,NOW(),?,?) ";
		jdbcTemplate.update(mainSql, projectId,title,createUser,path);
		
		//插入项目属性表数据
		ArrayList<Object> attrList = list.get(1);
		if(attrList == null || attrList.size() == 0){
			insertOperateHistory(request, type, msg);
			msg = "格式有误，请确认第二行数据不能为空！";
			return null ;
		}
		int attrSize = attrList.size();
		String attrSql = " insert into project_attribute(id,project_id,attribute_name,attribute_index)VALUES(?,?,?,?) ";
		for (int i = 0; i < attrSize; i++) {
			jdbcTemplate.update(attrSql, SortableUUID.randomUUID(),projectId,attrList.get(i)+"",i+1);
		}
		//插入项目详细数据,从第三行还是为详细数据
		List<String> params = new ArrayList<String>();
		List<String> marks = new ArrayList<String>();
		StringBuilder sb = new StringBuilder(); 
		attrList = new ArrayList<Object>();
		for(int i=0;i<list.size();i++){
			if(i>1){//从第三行开始
				attrList = list.get(i);
				if(attrList != null && attrList.size() != 0){
					sb = new StringBuilder();
					params = new ArrayList<String>();
					marks = new ArrayList<String>();
					sb.append(" insert into project_detail(id,project_id ");
					marks.add("?");
					marks.add("?");
					params.add(SortableUUID.randomUUID());
					params.add(projectId);
					for(int k =0;k<attrList.size();k++){
						sb.append(",ext"+(k+1));
						params.add(attrList.get(k)+"");
						marks.add("?");
					}
//					System.out.println(params);
					sb.append(")values("+StringUtils.join(marks.toArray(), ",")+")");
					jdbcTemplate.update(sb.toString(), params.toArray());
				}else{
					msg = "格式有误，请确认第三行数据不能为空！";
					insertOperateHistory(request, type, msg);
					return null;
				}
			}
		}
		return projectId;
	}
	
	/**
	 * 添加筛选条件
	 * @param list
	 */
	public void addCondition(List<String> list,String projectId){
		String sql = " select attribute_index from project_attribute where id = ? ";
		String detailSql = "";
		List<Map<String, Object>> attrList = new ArrayList<Map<String,Object>>();
		String attributeIndex = "";
		for (int i = 0; i < list.size(); i++) {
			detailSql = " insert into project_attribute_condition(attribute_condition,attribute_id)"
					+ "select DISTINCT(ext__index),? from project_detail where project_id = ? ";
			attrList = jdbcTemplate.queryForList(sql, list.get(i));
			attributeIndex = attrList.get(0).get("attribute_index")+"";
			detailSql=detailSql.replace("__index", attributeIndex);
			jdbcTemplate.update(detailSql, list.get(i),projectId);
//			System.out.println(detailSql);
//			System.out.println(list.get(i));
//			System.out.println(projectId);
		}
		
	}
	/**
	 * 删除筛选条件
	 */
	public void delCondition(List<String> list){
		String sql = " delete from project_attribute_condition where attribute_id = ? ";
		jdbcTemplate.update(sql, StringUtils.join(list.toArray(), "','"));
	}
	
	
	/**
	 * 插入操作日志
	 * @param request
	 * @param type
	 * @param msg
	 */
	public void insertOperateHistory(HttpServletRequest request,String type,String msg){
		HttpSession session=request.getSession();
		operateHistoryService.insertOH(request,(String)session.getAttribute("userId") , type, msg,msg==null?1:0);
	}
	
	public Page<Map<String, Object>> getProjectMain(String projectname,int start,int limit,String startDate,String endDate){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(start, limit, false);
		List<Object> params = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(" select a.id,a.project_name,a.create_time,b.real_name  ");
		sql.append(" from project_main a LEFT JOIN user_login b on a.create_user_id = b.id where 1=1 ");
		if(StringUtils.isNotBlank(projectname)){
			sql.append(" and a.project_name = ? ");
			params.add(projectname);
		}
		if(StringUtils.isNotBlank(startDate)){
			sql.append(" and a.create_date >= ? ");
			params.add(startDate);
		}
		if(StringUtils.isNotBlank(endDate)){
			sql.append(" and a.create_date <= ? ");
			params.add(endDate);
		}
		sql.append(" order by a.create_time ");
		
		List<Map<String, Object>> countList = jdbcTemplate.queryForList(sql.toString(),params.toArray());
		page.setTotalCount(countList.size());
		sql.append(" limit ?,?");
		params.add(start);
		params.add(limit);
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql.toString(), params.toArray());
		page.setResult(list);
		return page;
	}
	
	
	
	public Page<Map<String, Object>> getProjectAttr(String projectId,int start,int limit){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(start, limit, false);
		List<Object> params = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(" select pa.id,pa.project_id,pm.project_name,pa.attribute_name,pat.type_name,pa.attribute_type,pa.attribute_active  ");
		sql.append(" from project_attribute pa left join project_main pm on pa.project_id = pm.id ");
		sql.append(" left join project_attribute_type pat on pa.attribute_type = pat.id and pat.id <> 0 where 1=1 ");
		if(StringUtils.isNotBlank(projectId)){
			sql.append(" and pm.id = ? ");
			params.add(projectId);
		}
		sql.append(" order by pa.attribute_index ");
		List<Map<String, Object>> countList = jdbcTemplate.queryForList(sql.toString(),params.toArray());
		page.setTotalCount(countList.size());
		sql.append(" limit ?,?");
		params.add(start);
		params.add(limit);
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql.toString(), params.toArray());
		page.setResult(list);
		return page;
	}
	
	
	public void updateAttrType(String id,String typeName){
		StringBuilder sb = new StringBuilder();
		String sql = " update project_attribute set attribute_type = (select id from project_attribute_type where type_name = ? ) where project_attribute.id = ? ";
		jdbcTemplate.update(sql,typeName,id);
	}
	public Page<Map<String, Object>> getAttrType(){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(0, 1010, false);
		String sql = " select id as value,type_name as text from project_attribute_type ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		page.setTotalCount(list.size());
		page.setResult(list);
		return page;
	}
	public void setAttrActive(String id,int value){
		String sql = " update project_attribute set attribute_active = ? where id = ?  ";
		jdbcTemplate.update(sql,value,id);
	}
	
	public List<Map<String, Object>> getAttrInfoByProjectId(String id){
		String sql = " select id,attribute_active from project_attribute where project_id = ?  ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, id);
		return list;
	}
	
	
}
