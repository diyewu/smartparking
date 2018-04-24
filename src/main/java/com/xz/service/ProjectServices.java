package com.xz.service;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.common.Page;
import com.xz.entity.ModuleStoreBean;
import com.xz.utils.CreateExcelUtil;
import com.xz.utils.ExcelReadUtils;
import com.xz.utils.SortableUUID;
import com.xz.utils.ZipUtil;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;
import net.coobird.thumbnailator.geometry.Positions;


@Service
@Transactional
public class ProjectServices {
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	@Autowired
	private OperateHistoryService operateHistoryService;
	
	@Transactional
	public String importProjectData(HttpSession session,File file,String title,String createUser){
		String msg = null;
		String type = "5";//导入项目数据
		String projectId = SortableUUID.randomUUID();
		try{
			ArrayList<ArrayList<Object>> list = new ArrayList<ArrayList<Object>>();
			try {
				 list = ExcelReadUtils.readAllRows(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (list == null || list.size() == 0) {
				msg = "请检查上传附件内容，数据为空！";
				insertOperateHistory(session, type, msg);
				return null;
			}
			if(StringUtils.isBlank(title)){
				title = list.get(0).get(0)+"";
			}
			if(StringUtils.isBlank(title)){
				msg = "格式有误，请确认第一行第一列为项目标题！";
				insertOperateHistory(session, type, msg);
				return null;
			}
			//插入项目主表数据
//			String projectId = SortableUUID.randomUUID();
			String mainSql = " insert into project_main(id,project_name,create_time,create_user_id,file_path)values(?,?,NOW(),?,?) ";
			jdbcTemplate.update(mainSql, projectId,title,createUser,file.getPath());
			
			//插入项目属性表数据
			ArrayList<Object> attrList = list.get(1);
			if(attrList == null || attrList.size() == 0){
				insertOperateHistory(session, type, msg);
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
				boolean allNull = true;
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
							
							if(StringUtils.isNotBlank(attrList.get(k)+"") && !"null".equals(attrList.get(k)+"")){
								allNull = false;
							}
						}
						if(allNull){
							continue;
						}
	//					System.out.println(params);
						sb.append(")values("+StringUtils.join(marks.toArray(), ",")+")");
						jdbcTemplate.update(sb.toString(), params.toArray());
					}else{
						msg = "格式有误，请确认第三行数据不能为空！";
						insertOperateHistory(session, type, msg);
						return null;
					}
				}
			}
			}catch(Exception e){
				msg = e.getMessage();
				throw new RuntimeException("运行出错："+msg);
			}
		insertOperateHistory(session, type, msg);
		return projectId;
	}
	public boolean checkSetImg(String projectId){
		String sql = " select * from project_attribute where project_id = ? and attribute_type = 4 ";
		List<Map<String, Object>> attrList = jdbcTemplate.queryForList(sql, projectId);
		if(attrList != null && attrList.size()>0){
			return true;
		}
		return false;
	}
	
	
	public void addRelateImg(HttpSession session,String projectId,File zipFile,String desPath) throws IOException{
		String msg = null;
		String sql = " select * from project_attribute where project_id = ? and attribute_type = 4 ";
		String projectSql = " select * from project_main where id = ? ";
		String tPath = "";
		try {
			List<Map<String, Object>> attrList = jdbcTemplate.queryForList(sql, projectId);
			List<Map<String, Object>> proList = jdbcTemplate.queryForList(projectSql, projectId);
			String projectName = "";
			projectName = proList.get(0).get("project_name")+"";
			List<List<Object>> exList = new ArrayList<List<Object>>();
			List<Object> dList = new ArrayList<Object>();
			dList.add(projectName);
			exList.add(dList);
			if (attrList != null && attrList.size() > 0) {
				Map<String, String> map = new HashMap<String, String>();
				String desPathLocal = desPath.split("\\.")[0];
				ZipUtil.unZipFiles(zipFile, desPathLocal + File.separator);
				ZipUtil.readFiles(desPathLocal, map);
				//			System.out.println(map);
				String attrIndex = attrList.get(0).get("attribute_index") + "";
				sql = "select id, ext" + attrIndex + " as imgname,img_path from project_detail where project_id = ?";
				if (map != null && map.size() > 0) {
					//生成缩略图
					String newPath = "";
					String imagePath = "";
					String[] imgs = null; 
					try{
						for (Map.Entry<String, String> entry : map.entrySet()) {
						    imagePath = entry.getValue();  
						    imgs = StringUtils.split(imagePath, ".");
						    newPath = imgs[0]+"_thumb."+imgs[1];
						    BufferedImage image = ImageIO.read(new File(imagePath));  
						    if(null == image){
						    	continue;
						    }
						    Builder<BufferedImage> builder = null;  
						    int imageWidth = image.getWidth();  
						    int imageHeitht = image.getHeight();  
						    if ((float)120 / 90 != (float)imageWidth / imageHeitht) {  
						        if (imageWidth > imageHeitht) {  
						            image = Thumbnails.of(imagePath).height(90).asBufferedImage();  
						        } else {  
						            image = Thumbnails.of(imagePath).width(120).asBufferedImage();  
						        }  
						        builder = Thumbnails.of(image).sourceRegion(Positions.CENTER, 120, 90).size(120, 90);  
						    } else {  
						        builder = Thumbnails.of(image).size(120, 90);  
						    }  
						    builder.outputFormat("jpg").toFile(newPath);  
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
					//生成缩略图
					List<Map<String, Object>> detailList = jdbcTemplate.queryForList(sql, projectId);
					List<Map<String, Object>> remainList = new ArrayList<Map<String,Object>>();
					if (detailList != null && detailList.size() > 0) {
						remainList.addAll(detailList);
						String imgName = "";
						String detailId = "";
						sql = " update project_detail set img_path = ? where id = ? ";
						for (int i = 0; i < detailList.size(); i++) {
							imgName = detailList.get(i).get("imgname") + "";
							detailId = detailList.get(i).get("id") + "";
							for (Map.Entry<String, String> entry : map.entrySet()) {
								if (imgName.equals(entry.getKey().split("\\.")[0])) {
									jdbcTemplate.update(sql, entry.getValue(), detailId);
									remainList.remove(detailList.get(i));
								}
							}
						}
					} else {
						msg = "项目详细数据为空！";
					}
					if(remainList != null && remainList.size() > 0){
						String remainPic = "";
						Map<String, Object> tmap = new HashMap<String, Object>();
						for (int i = 0; i < remainList.size(); i++) {
							tmap = remainList.get(i);
							if(StringUtils.isBlank(tmap.get("img_path")==null?"":tmap.get("img_path")+"")){
								remainPic += tmap.get("imgname")+",";
								dList = new ArrayList<Object>();
								dList.add(tmap.get("imgname"));
								exList.add(dList);
							}
						}
						msg = "以下图片名称没有匹配到图片：" + remainPic;
						if(exList.size()>1){
							tPath = desPathLocal + File.separator+System.currentTimeMillis()+".xlsx";
							CreateExcelUtil.createExcelFile(tPath, exList);
						}
					}
				} else {
					msg = "请确认zip压缩包有正确数据！";
				}
			} else {
				msg = "请先设置项目图片属性，在提交图片数据！";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		operateHistoryService.insertOH(session, "18", msg, msg==null?1:0,tPath);
	}
	
	/**
	 * 添加筛选条件
	 * @param list<attrId>
	 */
	public void addCondition_bak(List<String> list,String projectId){
		String sql = " select attribute_index from project_attribute where id = ? ";
		String detailSql = "";
		List<Map<String, Object>> attrList = new ArrayList<Map<String,Object>>();
		String attributeIndex = "";
		detailSql = " select DISTINCT(ext__index) from project_detail where project_id = ? ";
		String conditionSql = " insert into project_attribute_condition(id,attribute_condition,attribute_id) "
				+ "values(?,?,?) ";
		List<Map<String, Object>> detailList = new ArrayList<Map<String,Object>>();
		Map<String, Object> detailMap = new HashMap<String, Object>();
		for (int i = 0; i < list.size(); i++) {
			attrList = jdbcTemplate.queryForList(sql, list.get(i));
			attributeIndex = attrList.get(0).get("attribute_index")+"";
			detailSql=detailSql.replace("__index", attributeIndex);
			detailList = jdbcTemplate.queryForList(detailSql, projectId);
			if(detailList != null && detailList.size()>0){
				for(int k =0;k<detailList.size();k++){
					detailMap = detailList.get(i);
					jdbcTemplate.update(conditionSql, SortableUUID.randomUUID(),detailMap.get("ext"+attributeIndex),list.get(i));
				}
			}
		}
		
//		for (int i = 0; i < list.size(); i++) {
//			detailSql = " insert into project_attribute_condition(attribute_condition,attribute_id)"
//					+ "select DISTINCT(ext__index),? from project_detail where project_id = ? ";
//			attrList = jdbcTemplate.queryForList(sql, list.get(i));
//			attributeIndex = attrList.get(0).get("attribute_index")+"";
//			detailSql=detailSql.replace("__index", attributeIndex);
//			jdbcTemplate.update(detailSql, list.get(i),projectId);
//		}
		
	}
	/**
	 * 添加筛选条件
	 * @param list
	 */
	public void addCondition_bak_bak(List<String> list,String projectId){
		String sql = " select id, attribute_index,attribute_name from project_attribute where id = ? ";
		String detailSql = "";
		List<Map<String, Object>> attrList = new ArrayList<Map<String,Object>>();
		String attributeIndex = "";
		String attrSql = "insert into project_attribute_condition(attribute_condition,attribute_id,type)values(?,?,1)";
		for (int i = 0; i < list.size(); i++) {
			detailSql = " insert into project_attribute_condition(attribute_condition,attribute_id,type)"
					+ "select DISTINCT(ext__index),?,0 from project_detail where project_id = ? ";
			attrList = jdbcTemplate.queryForList(sql, list.get(i));
			attributeIndex = attrList.get(0).get("attribute_index")+"";
			detailSql=detailSql.replace("__index", attributeIndex);
			jdbcTemplate.update(detailSql, list.get(i),projectId);
			jdbcTemplate.update(attrSql, attrList.get(0).get("attribute_name"),projectId);
		}
		String mainSql = "insert into project_attribute_condition(attribute_condition,attribute_id,type)values((select project_name from project_main where id = ?),?,2)";
		jdbcTemplate.update(mainSql,projectId,projectId);
		
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
		}
		String mainSql = " update project_main set type = 1 where id = ? ";
		jdbcTemplate.update(mainSql, projectId);
	}
	/**
	 * 删除筛选条件
	 */
	public void delCondition(List<String> list){
		String sql = " delete from project_attribute_condition where attribute_id = ? ";
		jdbcTemplate.update(sql, StringUtils.join(list.toArray(), "','"));
	}
	
	/**
	 * 删除筛选条件
	 */
	public void delConditionByProjectId(String projectId){
		//删除project_condition_auth数据，提示用户重置该项目涉及权限
		String authSql = "delete from project_condition_auth where condition_id in(select id from project_attribute_condition  where attribute_id in (select id from project_attribute where project_id = ?))";
		jdbcTemplate.update(authSql, projectId);
		authSql = " delete from project_condition_auth where condition_id in(select id from project_attribute where project_id = ?) ";
		jdbcTemplate.update(authSql, projectId);
		authSql = " delete from project_condition_auth where condition_id in(?) ";
		jdbcTemplate.update(authSql, projectId);
		
		String sql = " delete from project_attribute_condition  where attribute_id in (select id from project_attribute where project_id = ?) ";
		jdbcTemplate.update(sql, projectId);
		sql = " delete from project_attribute_condition  where attribute_id in (?) ";
		jdbcTemplate.update(sql, projectId);
		sql = " update project_attribute set attribute_active = 0 where project_id = ? ";
		jdbcTemplate.update(sql, projectId);
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
	public void insertOperateHistory(HttpSession session,String type,String msg){
		operateHistoryService.insertOH(session, type, msg,msg==null?1:0);
	}
	
	public void insertOperateHistory(String userId,String type,String msg){
		operateHistoryService.insertOH(userId, type, msg,msg==null?1:0);
	}
	
	
	public Page<Map<String, Object>> getProjectMain(String projectname,int start,int limit,String startDate,String endDate){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(start, limit, false);
		List<Object> params = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(" select a.id,a.project_name,a.create_time,b.real_name  ");
		sql.append(" from project_main a LEFT JOIN user_login b on a.create_user_id = b.id where 1=1 ");
		if(StringUtils.isNotBlank(projectname)){
			sql.append(" and a.project_name like ? ");
			params.add("%"+projectname+"%");
		}
		if(StringUtils.isNotBlank(startDate)){
			sql.append(" and a.create_date >= ? ");
			params.add(startDate);
		}
		if(StringUtils.isNotBlank(endDate)){
			sql.append(" and a.create_date <= ? ");
			params.add(endDate);
		}
		sql.append(" order by a.create_time desc ");
		
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
		StringBuilder sql = new StringBuilder(" select pa.id,pa.project_id,pm.project_name,pa.attribute_name,pat.type_name,patt.type_name as info_type_name,pa.attribute_type,pa.attribute_active  ");
		sql.append(" from project_attribute pa left join project_main pm on pa.project_id = pm.id ");
		sql.append(" left join project_attribute_type pat on pa.attribute_type = pat.id AND pat.id <> 0 and pat.type = 0  ");
		sql.append(" LEFT JOIN project_attribute_type patt ON pa.attribute_info_type = patt.id AND patt.id <> 16 and patt.type = 1 ");
		sql.append(" where 1=1 ");
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
	
	
	public void updateAttrType(String id,String typeName,String infoTypeName){
		String sql = " update project_attribute set "
				+ "attribute_type = (select id from project_attribute_type where type_name = ? and type = 0 ) "
				+ ",attribute_info_type = (select id from project_attribute_type where type_name = ? and type = 1 ) "
				+ "where project_attribute.id = ? ";
		jdbcTemplate.update(sql,typeName,infoTypeName,id);
	}
	public void geoDetailAddr(String attrId,HttpSession session ,String apikey){
		String attrSql = " select * from project_attribute where id = ? ";
		List<Map<String, Object>> attrList = jdbcTemplate.queryForList(attrSql, attrId);
		if (attrList != null && attrList.size() > 0) {
			String projectId = (String)attrList.get(0).get("project_id");
			String index = attrList.get(0).get("attribute_index")+"";
			String detailSql = "select id, ext"+index+" from project_detail where project_id = ?";
			List<Map<String, Object>> detailList = jdbcTemplate.queryForList(detailSql, projectId);
			if (detailList != null && detailList.size() > 0) {
				String address = "";
				String key = "ext"+index;
				Map<String, String> respMap = new HashMap<String, String>();
				String longitude = "";
				String latitude = "";
				String id = "";
				String insSql = " update project_detail set latitude = ? ,longitude = ? where id = ? ";
				String type = "0";
				String msg = null;
				for (int i = 0; i < detailList.size(); i++) {
					longitude = "";
					latitude = "";
					id = "";
					respMap = new HashMap<String, String>();
					address = (String)detailList.get(i).get(key);
					id = (String)detailList.get(i).get("id");
					if(StringUtils.isNotBlank(address) && !"null".equals(address)){
						respMap = getGeocoderLatitude(address, apikey);
					}
					longitude = respMap.get("longitude");
					latitude = respMap.get("latitude");
					if(StringUtils.isNotBlank(latitude) && StringUtils.isNotBlank(latitude) && StringUtils.isNotBlank(longitude)){
						jdbcTemplate.update(insSql, latitude,longitude,id);
					}else{
						msg = address+" 解析出错.";
						operateHistoryService.insertOH(session, "38", msg, 1);
						type = "1";
					}
				}
				if("0".equals(type)){
					operateHistoryService.insertOH(session, "38", msg, 0);
				}
			}
		}
		
	}
	
	
	
	public Map<String,String> getGeocoderLatitude(String address,String key) {
		Map<String,String> map = new HashMap<String, String>();
		BufferedReader in = null;
		try {
			address = URLEncoder.encode(address, "UTF-8");
			URL tirc = new URL("http://api.map.baidu.com/geocoder/v2/?address=" + address + "&output=json&ak=" + key+"&callback=showLocation");
			in = new BufferedReader(new InputStreamReader(tirc.openStream(), "UTF-8"));
			String res;
			StringBuilder sb = new StringBuilder("");
			while ((res = in.readLine()) != null) {
				sb.append(res.trim());
			}
			String str = sb.toString();
			if (StringUtils.isNotEmpty(str)) {
				int lngStart = str.indexOf("lng\":");
				int lngEnd = str.indexOf(",\"lat");
				int latEnd = str.indexOf("},\"precise");
				if (lngStart > 0 && lngEnd > 0 && latEnd > 0) {
					String lng = str.substring(lngStart + 5, lngEnd);
					String lat = str.substring(lngEnd + 7, latEnd);
					map.put("longitude", lng);//经度
					map.put("latitude", lat);//纬度
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
//		System.out.println(map);
		return map;
	}
	
	public Page<Map<String, Object>> getAttrType(int type){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(0, 1010, false);
		String sql = " select id as value,type_name as text from project_attribute_type where type = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,type);
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
	
	/**
	 * 删除project数据，包括主表、属性、detail、condition、权限表
	 * @param projectId
	 */
	@Transactional
	public void deleteProjectById(String projectId){
		String sql = " select id from project_attribute where project_id = ? ";
		String conditionSql = " select id from project_attribute_condition where attribute_id = ? ";
		String delConditionSql = " delete from project_condition_auth where condition_id = ? ";
		String delprojectAuthSql = " delete from project_condition_auth where condition_id = ? ";
		
		String delprojectMain = " delete from project_main where id = ? ";
		String delprojectDetail = " delete from project_detail where  project_id = ?  ";
		String delprojectAttribute = " delete from project_attribute where project_id = ? ";
		String delprojectCondition = " delete from project_attribute_condition  where attribute_id in (select id from project_attribute where project_id = ?) ";
		List<Map<String, Object>> attrList = jdbcTemplate.queryForList(sql, projectId);
		List<Map<String, Object>> conditionList = new ArrayList<Map<String,Object>>();
		Map<String, Object> attrMap = new HashMap<String, Object>();
		Map<String, Object> conditionMap = new HashMap<String, Object>();
		String attrId = "";
		String conditionId = "";
		if (attrList != null && attrList.size() > 0) {
			for(int i=0;i<attrList.size();i++){
				attrMap = attrList.get(i);
				attrId = attrMap.get("id")+"";
				conditionList = jdbcTemplate.queryForList(conditionSql, attrId);
				if (conditionList != null && conditionList.size() > 0) {
					//删除 auth
					for(int k=0;k<conditionList.size();k++){
						conditionMap = conditionList.get(k);
						conditionId = conditionMap.get("id")+"";
						jdbcTemplate.update(delprojectAuthSql,conditionId);
					}
				}
				//删除attribute 条件
				jdbcTemplate.update(delConditionSql,attrId);
			}
			//删除项目的条件
			jdbcTemplate.update(delConditionSql,projectId);
		}
		//删除condition
		jdbcTemplate.update(delprojectCondition,projectId);
		//删除detail
		jdbcTemplate.update(delprojectDetail,projectId);
		//删除attribute
		jdbcTemplate.update(delprojectAttribute,projectId);
		//删除main
		jdbcTemplate.update(delprojectMain,projectId);
	}
	
	public Page<Map<String, Object>> getSearchNoDictionary(Map<String, String> condition){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(0, 1000, false);
		List<Object> params = new ArrayList<Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		StringBuilder sbud = new StringBuilder(" select * from project_searchno_dictionary where 1=1 ");
		if (!condition.isEmpty()) { 
			if (condition.containsKey("searchNo")) {
				sbud.append(" and search_no like ? ");
				params.add("%"+condition.get("searchNo")+"%");
			}
			if(condition.containsKey("searchName")){
				sbud.append(" and search_name like ? ");
				params.add("%"+condition.get("searchName")+"%");
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
	public Page<Map<String, Object>> getQuestionType(Map<String, String> condition){
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(0, 1000, false);
		List<Object> params = new ArrayList<Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		StringBuilder sbud = new StringBuilder(" select qc.id ,qc.question_type,cd.color_name from question_color qc left JOIN color_dictionary cd on qc.color_id = cd.id where 1=1 ");
		if (!condition.isEmpty()) { 
			if (condition.containsKey("questionType")) {
				sbud.append(" and  qc.question_type like ? ");
				params.add("%"+condition.get("questionType")+"%");
			}
			List<Map<String, Object>> countList = jdbcTemplate.queryForList(sbud.toString(),params.toArray());
			page.setTotalCount(countList.size());
			sbud.append(" ORDER BY qc.id ");
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
	
	
	public void updateResearchInfoById(String id,String no,String name){
		if(StringUtils.isNotBlank(id)){
			String sql = " update project_searchno_dictionary set search_no = ? ,search_name = ? ,update_date=NOW() where id = ? ";
			jdbcTemplate.update(sql, no,name,id);
		}
	}
	
	public void addResearchInfo(String no,String name){
		String sql = " INSERT into project_searchno_dictionary(search_no,search_name,create_date,update_date)VALUES(?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, no,name);
	}
	
	public void deleteResearchInfoById(String id){
		String sql = " delete from project_searchno_dictionary where id = ? ";
		if(StringUtils.isNotBlank(id)){
			jdbcTemplate.update(sql, id);
		}
	}
	
	public void importResearchInfo(File file,HttpSession session){
		ArrayList<ArrayList<Object>> list = new ArrayList<ArrayList<Object>>();
		String msg = null;
		String type = "20";//导入调研编号
		try {
			try {
				 list = ExcelReadUtils.readAllRows(file);
			} catch (IOException e) {
				e.printStackTrace();
				msg = "文件解析出错："+e.getMessage();
			}
			ArrayList<Object> objList = new ArrayList<Object>(); 
			if(msg != null){
				insertOperateHistory(session, type, msg);
				return;
			}else{
				if(list == null || list.size() <= 0){
					msg = "文件内容有误，请确认文件内容不为空！";
					insertOperateHistory(session, type, msg);
					return;
				}
				String searchNo = "";
				String searchName = "";
				String sql = " INSERT into project_searchno_dictionary(search_no,search_name,create_date,update_date)VALUES(?,?,NOW(),NOW()) ";
				String checkSql = " select * from project_searchno_dictionary where search_no = ? and search_name = ? ";
				List<Map<String, Object>> checkList = new ArrayList<Map<String,Object>>();
				boolean allnull = true;
				for(int i=1;i<list.size();i++){
					allnull = true;
					objList = list.get(i);
					searchNo = objList.get(0)+"";
					searchName = objList.get(1)+"";
					if(StringUtils.isNotBlank(searchNo) && !"null".equals(searchNo)){
						allnull = false;
					}
					if(StringUtils.isNotBlank(searchName) && !"null".equals(searchName)){
						allnull = false;
					}
					if(allnull){
						continue;
					}
					checkList = jdbcTemplate.queryForList(checkSql, searchNo,searchName);
					if (checkList == null || checkList.size() == 0) {
						jdbcTemplate.update(sql, searchNo,searchName);
					}else{
						throw new RuntimeException("编号："+checkList.get(0).get("search_no")+" 数据有重复");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
//			insertOperateHistory(session, type, msg);
			throw new RuntimeException(msg);
		}
	}
	
	public List<ModuleStoreBean> getColor(){
		return jdbcTemplate.query(" select id,color_name from color_dictionary ",new ModuleStoreBeanRowMapper());
	}
	public static class ModuleStoreBeanRowMapper implements RowMapper<ModuleStoreBean> {
		@Override
		public ModuleStoreBean mapRow(ResultSet rs, int rowNum) throws SQLException {
			ModuleStoreBean rm = new ModuleStoreBean();
			rm.setValue(rs.getString("id"));
			rm.setText(rs.getString("color_name"));
			return rm;
		}
	}
	
	
	public void addQuestionColorById(String question,String color){
		String sql = " INSERT into question_color(question_type  ,color_id, update_date ,create_date )VALUES(?,?,NOW(),NOW()) ";
		jdbcTemplate.update(sql, question,color);
	}
	public void updateQuestionColorById(String id,String question,String color){
		if(StringUtils.isNotBlank(id)){
			String sql = " update question_color set question_type = ? ,color_id = ?, update_date = NOW() where id = ? ";
			jdbcTemplate.update(sql, question,color,id);
		}
	}
	
	public void deleteQuestionTypeById(String id){
		String sql = " delete from question_color where id = ? ";
		if(StringUtils.isNotBlank(id)){
			jdbcTemplate.update(sql, id);
		}
	}
	
}
