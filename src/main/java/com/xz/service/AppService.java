package com.xz.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Joiner;
import com.xz.common.ServerResult;
import com.xz.entity.AppMenu;
import com.xz.entity.AreaBean;
import com.xz.utils.AgingCache;

@Service
@Transactional
public class AppService implements InitializingBean{
	
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	private static List<String> keyList = new ArrayList<String>();
	private static Map<String,String> lvlMap = new HashMap<String, String>();
	private static Map<String,String> preMap = new HashMap<String, String>();
	private static Map<Integer,Integer> levelMap = new HashMap<Integer,Integer>();
	public static Map<String,String> researchNoMap = new HashMap<String, String>();
	static{
		keyList.add("research_no");
		keyList.add("question_type");
		keyList.add("longitude");
		keyList.add("latitude");
//		keyList.add("detail_address");
		levelMap.put(0, 0);
		levelMap.put(1, 2);
		levelMap.put(2, 4);
		levelMap.put(3, 6);
		levelMap.put(4, 9);
		levelMap.put(5, 12);
		levelMap.put(6, 16);
		
		lvlMap.put("first_area", "second_area");
		lvlMap.put("second_area", "third_area");
		lvlMap.put("third_area", "forth_area");
		
		preMap.put("second_area", "first_area");
		preMap.put("third_area", "second_area");
		preMap.put("forth_area", "third_area");
	}
	public static Map<String,List<Map<String, Object>>> cacheMap = new HashMap<String, List<Map<String,Object>>>();
	
	public void initResearchNo(){
		String sql = " select search_no,search_name from project_searchno_dictionary ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		if(list != null && list.size()>0){
			Map<String, Object> map = new HashMap<String, Object>();
			if(list != null){
				for(int i=0;i<list.size();i++){
					map = list.get(i);
					researchNoMap.put(map.get("search_no")+"", map.get("search_name")+"");
				}
			}
		}
	}
	
	public List<Map<String, Object>> getUserInfoByNameandPwd(String name,String pwd){
		String sql = "  select * from web_user_login where user_name = ? and user_password = ? and is_delete = 0 ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,name,pwd);
		if(list != null && list.size()>0){
			return list;
		}
		return null;
	}
	public int checkPhoneId(String phoneId,int allowSize,String webUserId){
		int code = 0;
		String sql = "select * from web_user_login_phone where web_user_id = ?";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,webUserId);
		//第一次使用,新增记录
		String insertSql = " insert into web_user_login_phone(phone_id,web_user_id,create_date)values(?,?,NOW()) ";
		if(list == null || list.size() == 0){
			jdbcTemplate.update(insertSql,phoneId,webUserId);
		}else{//当前存在记录
			boolean containPhoneId = false;
			int nowSize = list.size();
			if(nowSize == allowSize){
				for(int i=0;i<nowSize;i++){
					if(phoneId.equals(list.get(i).get("phone_id"))){
						containPhoneId = true;
						break;
					}
				}
				if(!containPhoneId){
					code = ServerResult.RESULT_CHECK_PHONE_ERROE;
				}
			}else if(nowSize < allowSize){
				jdbcTemplate.update(insertSql,phoneId,webUserId);
			}
		}
		return code;
	}
	
	public List<AppMenu> getMenulist(String roleId){
		List<AppMenu> newList = new ArrayList<AppMenu>();
		List<AppMenu>  l = new ArrayList<AppMenu>();
		l = this.getMenu(roleId);
		Map<String,AppMenu> map = new LinkedHashMap<String,AppMenu>(); 
		Map<String,AppMenu> map1 = new LinkedHashMap<String,AppMenu>(); 
		for(AppMenu t:l){//list转换成map
			map.put(t.getId(), t);
			map1.put(t.getId(), t);
		}
		AppMenu c1 = null;
		AppMenu c2 = null;
		Iterator it = map.keySet().iterator();//遍历map
		while (it.hasNext()) {
			c1 = new AppMenu();
			c1 = map.get(it.next());
			if(c1.getId() == null ||"null".equals(c1.getId())){//第一级节点
				
			}else{
				if(map1.containsKey(c1.getParent_id())){//
					c2 = new AppMenu();
					c2 = map1.get(c1.getParent_id());
					if(c2.getChildren() != null){
						c2.getChildren().add(c1);
					}else{
						List<AppMenu> childrens = new ArrayList<AppMenu>();
						childrens.add(c1);
						c2.setChildren(childrens);
					}
					map1.remove(c1.getId());
				}
			}
		}
		
		Iterator i = map1.keySet().iterator();
		while (i.hasNext()) {
			newList.add((AppMenu)map.get(i.next()));
		}
		return newList;
	}
	public List<AppMenu> getMenulistByProjectId(String roleId,String projectId){
		List<AppMenu> newList = new ArrayList<AppMenu>();
		List<AppMenu>  l = new ArrayList<AppMenu>();
		l = this.getMenuByProjectId(roleId,projectId);
		Map<String,AppMenu> map = new LinkedHashMap<String,AppMenu>(); 
		Map<String,AppMenu> map1 = new LinkedHashMap<String,AppMenu>(); 
		for(AppMenu t:l){//list转换成map
			map.put(t.getId(), t);
			map1.put(t.getId(), t);
		}
		AppMenu c1 = null;
		AppMenu c2 = null;
		Iterator it = map.keySet().iterator();//遍历map
		while (it.hasNext()) {
			c1 = new AppMenu();
			c1 = map.get(it.next());
			if(c1.getId() == null ||"null".equals(c1.getId())){//第一级节点
				
			}else{
				if(map1.containsKey(c1.getParent_id())){//
					c2 = new AppMenu();
					c2 = map1.get(c1.getParent_id());
					if(c2.getChildren() != null){
						c2.getChildren().add(c1);
					}else{
						List<AppMenu> childrens = new ArrayList<AppMenu>();
						childrens.add(c1);
						c2.setChildren(childrens);
					}
					map1.remove(c1.getId());
				}
			}
		}
		
		Iterator i = map1.keySet().iterator();
		while (i.hasNext()) {
			newList.add((AppMenu)map.get(i.next()));
		}
		return newList;
	}
	
	
	
	public List<AppMenu> getMenu(String roleId){
		StringBuilder sb = new StringBuilder();
		sb.append(" select a.id,	a.menu_name,	a.parent_id,	a.leaf	,b.web_user_role_id as is_check from ");
		sb.append(" (SELECT	id,	pac.attribute_condition AS menu_name,	pac.attribute_id AS parent_id,	pac.leaf,	pac.id AS is_check FROM 	project_attribute_condition pac  ");
		sb.append(" union  ");
		sb.append(" SELECT id,	pa.attribute_name AS menu_name,		pa.project_id AS parent_id,		0 AS leaf,		pa.id AS is_check	FROM 		project_attribute pa	WHERE		pa.attribute_active = 1 ");
		sb.append(" union  ");
		sb.append(" SELECT id,	pm.project_name AS menu_name,	NULL AS parent_id,	0 AS leaf,	pm.id AS is_check	FROM	project_main pm	 ");
		sb.append(" )a inner JOIN (  ");
		sb.append(" select * from project_condition_auth pca 	where pca.web_user_role_id = ?  ");
		sb.append(" ) b on a.id = b.condition_id where a.is_check is not null ORDER BY a.id DESC  ");
//		List<Map<String, Object>> list = jdbcTemplate.queryForList(sb.toString(),roleId);
		List<AppMenu> list = (List<AppMenu>)jdbcTemplate.query(sb.toString(), new AppMenuRowMapper(),roleId);
		return list;
	}
	public List<AppMenu> getMenuByProjectId(String roleId,String projectId){
		StringBuilder sb = new StringBuilder();
		sb.append(" select a.id,	a.menu_name,	a.parent_id,	a.leaf	,b.web_user_role_id as is_check from ");
		sb.append(" (SELECT pac.id, pac.attribute_condition AS menu_name, pac.attribute_id AS parent_id, pac.leaf, pac.id AS is_check, ppa.project_id FROM project_attribute_condition pac LEFT JOIN project_attribute ppa ON pac.attribute_id = ppa.id  ");
		sb.append(" union  ");
		sb.append(" SELECT id,	pa.attribute_name AS menu_name,		pa.project_id AS parent_id,		0 AS leaf,		pa.id AS is_check,pa.project_id	FROM 		project_attribute pa	WHERE		pa.attribute_active = 1 ");
		sb.append(" union  ");
		sb.append(" SELECT id,	pm.project_name AS menu_name,	NULL AS parent_id,	0 AS leaf,	pm.id AS is_check,pm.id as projet_id	FROM	project_main pm	 ");
		sb.append(" )a inner JOIN (  ");
		sb.append(" select * from project_condition_auth pca 	where pca.web_user_role_id = ?  ");
		sb.append(" ) b on a.id = b.condition_id where a.is_check is not null and a.project_id = ? ORDER BY a.id DESC  ");
//		List<Map<String, Object>> list = jdbcTemplate.queryForList(sb.toString(),roleId);
		List<AppMenu> list = (List<AppMenu>)jdbcTemplate.query(sb.toString(), new AppMenuRowMapper(),roleId,projectId);
		return list;
	}
	
	public static class AppMenuRowMapper implements RowMapper<AppMenu> {
		@Override
		public AppMenu mapRow(ResultSet rs, int rowNum) throws SQLException {
			AppMenu tree = new AppMenu();
			tree.setId(rs.getString("id"));
			tree.setMenuName(rs.getString("menu_name"));
			tree.setParent_id(rs.getString("parent_id"));
			tree.setLeaf(rs.getInt("leaf")==0?false:true );
			tree.setChecked(rs.getString("is_check") == null?false:true);
			return tree;
		}
	}
	
	public List<Map<String,Object>> getMapInfo(String projectId,Map<String,
			List<String>> param,String cacheKey,String currentLevel,String sourceType){
		if(StringUtils.isBlank(cacheKey)){
			String attriSql = " select attribute_index from project_attribute where id = ? ";
			List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
			List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
			StringBuilder sb = new StringBuilder();
			String attriAllSql = " select pa.attribute_name,pat.alias_name,pa.attribute_index"
					+ " from project_attribute pa left join project_attribute_type pat"
					+ " on pa.attribute_type = pat.id and pat.type = 0 where pa.project_id = ? ORDER BY pat.id ";
			List<Map<String, Object>> attributeList = jdbcTemplate.queryForList(attriAllSql, projectId);
			if(attributeList == null || attributeList.size() == 0){
				return null;
			}
			List<String> conditionIdList = new ArrayList<String>();
			if (param != null && param.size() > 0) {
				String tempSql = "";
				sb.append(" select ");
				String aliasName = "";
				String questionAttr = "";
				boolean hasLatInfo = false;
				for (int i = 0; i < attributeList.size(); i++) {
					aliasName = (String)attributeList.get(i).get("alias_name");
					if(StringUtils.isNotBlank(aliasName)){
						if(keyList.contains(aliasName)){
							if("longitude".equals(aliasName)){
								hasLatInfo = true;
							}
							sb.append(" pd.ext"+attributeList.get(i).get("attribute_index") +" as " + aliasName +",");
							if("question_type".equals(aliasName)){
								questionAttr = "pd.ext"+attributeList.get(i).get("attribute_index");
							}
						}
					}
				}
				if(!hasLatInfo){//没有设置经纬度信息，则去查找详细地址 映射的经纬度
					sb.append(" pd.longitude,pd.latitude, ");
				}
				
				if(StringUtils.isNotBlank(questionAttr)){
					sb.append(" cd.color, ");
				}
				sb.append(" pd.id ");
				sb.append(" from project_detail  pd ");
				if(StringUtils.isNotBlank(questionAttr)){
					sb.append(" LEFT JOIN question_color qc on "+questionAttr+" = qc.question_type ");
					sb.append(" LEFT JOIN color_dictionary cd on qc.color_id = cd.id ");
				}
				
				
				sb.append(" where project_id = ? ");
				for (Map.Entry<String,List<String>> entry : param.entrySet()) {  
					list = jdbcTemplate.queryForList(attriSql, entry.getKey());
					tempSql = "and ext_index in(select attribute_condition from project_attribute_condition where id in (?) )";
				    if(list != null && list.size()>0){
				    	tempSql = tempSql.replace("_index", list.get(0).get("attribute_index")+"");
				    	conditionIdList = entry.getValue();
				    	if(conditionIdList != null && conditionIdList.size()>0){
				    		tempSql = tempSql.replace("?", Joiner.on(",").join(conditionIdList));
				    		sb.append(tempSql);
	//			    		sqlParam.add(Joiner.on(",").join(conditionIdList));
				    	}
				    }
				}
				resultList = jdbcTemplate.queryForList(sb.toString(), projectId);
				if(resultList != null && resultList.size()>0){
					String tkey = UUID.randomUUID().toString().replaceAll("-", "");
//					cacheMap.put(tkey, resultList);
					AgingCache.putCacheInfo(tkey, resultList,60);
					List<Map<String, Object>> cod = generateCod(null,resultList,tkey,currentLevel,sourceType);
					return cod;
				}
			}
		}else{
//			List<Map<String, Object>> cod = generateCod(null,cacheMap.get(cacheKey),cacheKey,currentLevel);
			List<Map<String, Object>> tlist = (List<Map<String, Object>>)AgingCache.getCacheInfo(cacheKey).getValue();
			if (tlist != null && tlist.size() > 0) {
				AgingCache.updateCacheTimeOut(cacheKey);
				List<Map<String, Object>> cod = generateCod(null,tlist,cacheKey,currentLevel,sourceType);
				return cod;
			}
		}
		return null;
	}
	public List<Map<String,Object>> generateCod(String currentKey,List<Map<String, Object>> resultList,
			String cacheKey,String currentLevel,String type){
		Map<String,AreaBean> areaMap = new HashMap<String, AreaBean>();
		int currentLevelInt = Integer.parseInt(currentLevel);
		AreaBean areaBean = new AreaBean();
		double longitudeF = 0;
		double latitudeF = 0;
		Map<String, Object> resultmap = new HashMap<String, Object>();
		List<Map<String,Object>> sList = new ArrayList<Map<String,Object>>();
		Map<String, Object> smap = new HashMap<String, Object>();
		String researchNo = "";
		String tempKey = "";
		String nextLevelKey = "";
		String id = "";
		String zeroStr = "";
		String projectCode = "";
		for (int i = 0; i < resultList.size(); i++) {
			areaBean = new AreaBean();
			resultmap = resultList.get(i);
			if(resultmap.containsKey("research_no")){
				researchNo = resultmap.get("research_no")+"";
				if (i == 0) {
					try {
						projectCode = researchNo.substring(researchNo.length() - 2, researchNo.length());
						if(isInteger(projectCode)){
							projectCode = "";
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if(StringUtils.isNotBlank(currentKey)){//从第二级开始
					tempKey = StringUtils.substring(researchNo, 0, levelMap.get(currentLevelInt));
					if(!currentKey.equals(tempKey))
						continue;
					if(currentLevelInt < 6){
						zeroStr = StringUtils.substring(researchNo, levelMap.get(currentLevelInt), levelMap.get(currentLevelInt+1));
					}
					if("00".equals(zeroStr)||"000".equals(zeroStr)){
						return generateCod(tempKey+zeroStr, resultList, cacheKey, (currentLevelInt+1)+"",type);
//						return null;
					}else{
						if(currentLevelInt != 6){//2.3.4.5
							if(currentKey.equals(tempKey)){//匹配,找下一级
								nextLevelKey = StringUtils.substring(researchNo, 0, levelMap.get(currentLevelInt+1));
								id = resultmap.get("id")+"";
								try {
									longitudeF = resultmap.get("longitude")==null?0:Double.parseDouble(resultmap.get("longitude")+"");
									latitudeF = resultmap.get("latitude")==null?0:Double.parseDouble(resultmap.get("latitude")+"");
								} catch (Exception e) {}
								if(longitudeF == 0 || latitudeF == 0){
									continue;
								}
								if(areaMap.containsKey(nextLevelKey)){
									areaBean = areaMap.get(nextLevelKey);
									areaBean.setTotalLongitude(areaBean.getTotalLongitude()+longitudeF);
									areaBean.setTotalLatitude(areaBean.getTotalLatitude()+latitudeF);
									areaBean.setCount(areaBean.getCount()+1);
									areaBean.setIds(areaBean.getIds()+","+id);
								}else{
									areaBean.setTotalLongitude(longitudeF);
									areaBean.setTotalLatitude(latitudeF);
									areaBean.setCount(1);
									areaBean.setIds(id);
								}
								areaMap.put(nextLevelKey, areaBean);
							}else{
								continue;
							}
						}else{//第六级
							if(currentKey.equals(tempKey)){//匹配,找下一级
								try {
									longitudeF = resultmap.get("longitude")==null?0:Double.parseDouble(resultmap.get("longitude")+"");
									latitudeF = resultmap.get("latitude")==null?0:Double.parseDouble(resultmap.get("latitude")+"");
								} catch (Exception e) {}
								if(longitudeF == 0 || latitudeF == 0){
									continue;
								}
								smap = new HashMap<String, Object>();
								smap.put("key",resultmap.get("question_type") );
								smap.put("color",resultmap.get("color") );
								smap.put("currentLevel", currentLevelInt+1);
								smap.put("nextLevel", "");
								smap.put("preKey", currentKey);
								smap.put("preLevel", currentLevelInt);
								smap.put("cacheKey", cacheKey);
	//							smap.put("text", "问题类型:"+(StringUtils.isBlank(researchNoMap.get(resultmap.get("question_type")))?resultmap.get("question_type"):researchNoMap.get(resultmap.get("question_type"))));
								smap.put("text", (StringUtils.isBlank(researchNoMap.get(resultmap.get("question_type")))?resultmap.get("question_type"):researchNoMap.get(resultmap.get("question_type"))));
								smap.put("longitude", longitudeF);
								smap.put("latitude", latitudeF);
								smap.put("ids", resultmap.get("id"));
								smap.put("totalitem", 1);
								if("mini".equals(type)){
									Map<String,Object> callout = new HashMap<String, Object>();
									callout.put("content", (StringUtils.isBlank(researchNoMap.get(resultmap.get("question_type")))?resultmap.get("question_type"):researchNoMap.get(resultmap.get("question_type"))));
									callout.put("fontSize","20");
									callout.put("color","#fff");
									callout.put("display","ALWAYS");
									callout.put("borderRadius","5%");
									callout.put("bgColor","#23aef4");
									smap.put("callout",callout);
									smap.put("iconPath","../../img/marker_red.png");
									smap.put("iconTapPath","../../img/marker_red.png");
//									level,key,cacheKey,currentLevel,nextLevel
									String markerId = (currentLevelInt+1)+"_"+resultmap.get("question_type")+"_"+cacheKey+"_"+currentLevelInt+"_0_"+resultmap.get("id");
									smap.put("id",markerId);
								}
								sList.add(smap);
							}
						}
					}
				}else{//第一级
					tempKey = StringUtils.substring(researchNo, 0, levelMap.get(currentLevelInt+1));
					zeroStr = StringUtils.substring(researchNo, levelMap.get(currentLevelInt), levelMap.get(currentLevelInt+1));
					if("00".equals(zeroStr)||"000".equals(zeroStr)){
						tempKey = StringUtils.substring(researchNo, 0, levelMap.get(currentLevelInt+1));
						return generateCod(tempKey, resultList, cacheKey, (currentLevelInt+1)+"",type);
//						return null;
					}else{
						id = resultmap.get("id")+"";
						try {
							longitudeF = resultmap.get("longitude")==null?0:Double.parseDouble(resultmap.get("longitude")+"");
							latitudeF = resultmap.get("latitude")==null?0:Double.parseDouble(resultmap.get("latitude")+"");
						} catch (Exception e) {}
						if(longitudeF == 0 || latitudeF == 0){
							continue;
						}
						if(areaMap.containsKey(tempKey)){
							areaBean = areaMap.get(tempKey);
							areaBean.setTotalLongitude(areaBean.getTotalLongitude()+longitudeF);
							areaBean.setTotalLatitude(areaBean.getTotalLatitude()+latitudeF);
							areaBean.setCount(areaBean.getCount()+1);
							areaBean.setIds(areaBean.getIds()+","+id);
						}else{
							areaBean.setTotalLongitude(longitudeF);
							areaBean.setTotalLatitude(latitudeF);
							areaBean.setCount(1);
							areaBean.setIds(id);
						}
						areaMap.put(tempKey, areaBean);
					}
				}
			}else{
				break;
			}
		}
		if(currentLevelInt != 6){
			if(areaMap != null && !areaMap.isEmpty()){
				Map<String,Object> sMap = new HashMap<String, Object>();
				for (Map.Entry<String,AreaBean> entry : areaMap.entrySet()) {
					areaBean = new AreaBean();
					areaBean = entry.getValue();
					sMap.put("key", entry.getKey());
					int currentLevelMini = 1;
					int nextLevelMini = 2;
					if(StringUtils.isNotBlank(currentKey)){
						sMap.put("currentLevel", currentLevelInt+1);
						currentLevelMini = currentLevelInt+1;
						sMap.put("nextLevel", currentLevelInt+2);
						nextLevelMini = currentLevelInt+2;
						sMap.put("preKey", StringUtils.substring(currentKey, 0,levelMap.get(currentLevelInt)));
						sMap.put("preLevel", currentLevelInt);
					}else{
						sMap.put("currentLevel", 1);
						sMap.put("nextLevel", 2);
						sMap.put("preKey", "");
						sMap.put("preLevel", 0);
					}
					sMap.put("cacheKey", cacheKey);
					sMap.put("text", (StringUtils.isBlank(researchNoMap.get(entry.getKey()+projectCode))?(entry.getKey()+projectCode):researchNoMap.get(entry.getKey()+projectCode)));
					sMap.put("longitude", areaBean.getTotalLongitude()/areaBean.getCount());
					sMap.put("latitude", areaBean.getTotalLatitude()/areaBean.getCount());
					sMap.put("ids", areaBean.getIds());
					sMap.put("totalitem", areaBean.getCount());
					sMap.put("color","" );
					if("mini".equals(type)){
						Map<String,Object> callout = new HashMap<String, Object>();
						callout.put("content", (StringUtils.isBlank(researchNoMap.get(entry.getKey()+projectCode))?(entry.getKey()+projectCode):researchNoMap.get(entry.getKey()+projectCode)));
						callout.put("fontSize","20");
						callout.put("color","#fff");
						callout.put("display","ALWAYS");
						callout.put("borderRadius","5%");
						callout.put("bgColor","#23aef4");
						sMap.put("callout",callout);
						sMap.put("iconPath","../../img/marker_red.png");
						sMap.put("iconTapPath","../../img/marker_red.png");
//						level,key,cacheKey,currentLevel,nextLevel
						String markerId = currentLevelMini+"_"+entry.getKey()+"_"+cacheKey+"_"+currentLevelInt+"_"+nextLevelMini;
						sMap.put("id",markerId);
					}
					sList.add(sMap);
					sMap = new HashMap<String, Object>();
				}
			}
//			System.out.println(sList);
		}
		
		if(currentLevelInt == 6){
			if(sList != null && sList.size()>0){
				Map<String,Object> tempMap = new HashMap<String, Object>();
				Map<String,Object> tempMap1 = new HashMap<String, Object>();
				Map<String,Object> tempMap2 = new HashMap<String, Object>();
				String longitude = "";
				String latitude = "";
				String text = "";
				String stext = "";
				String ids = "";
				String ttext ="";
				
				for (int i = 0; i < sList.size(); i++) {
					stext = "";
					tempMap = new HashMap<String, Object>();
					tempMap = sList.get(i);
					longitude = tempMap.get("longitude")+"";
					latitude = tempMap.get("latitude")+"";
					if(!tempMap1.containsKey(longitude+latitude)){//不存在
						tempMap1.put(longitude+latitude, tempMap);
					}else{//已经存在，则合并
						tempMap2 = new HashMap<String, Object>();
						tempMap2 = (Map<String, Object>) tempMap1.get(longitude+latitude);
						text = (String)tempMap.get("text");
						ids = (String)tempMap.get("ids");
						stext =tempMap2.get("text")+"";
//						tempMap.put("text", tempMap2.get("text")+","+text);
//						tempMap.put("text", (stext.contains("问题类型：")?"":"问题类型：")+(stext.contains(text)?stext:stext+","+text));
//						ttext = StringUtils.isNotBlank(stext)&&stext.contains(text)?stext:stext+","+text;
						if(StringUtils.isNotBlank(stext) && StringUtils.isNotBlank(text)){
							if(stext.contains(text)){
								ttext = stext;
							}else{
								ttext = stext+","+text;
							}
						}
						tempMap.put("text", ttext);
						tempMap.put("ids", tempMap2.get("ids")+","+ids);
						tempMap.put("totalitem", (Integer.parseInt(tempMap2.get("totalitem")+""))+1);
						tempMap1.put(longitude+latitude, tempMap);
						
					}
				}
				sList = new ArrayList<Map<String,Object>>();
				if(!tempMap1.isEmpty()){
					sList = new ArrayList<Map<String,Object>>();
					Map<String, Object> ttmap = new HashMap<String, Object>();
					for (Map.Entry<String,Object> entry : tempMap1.entrySet()) {
//						System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
//						text = "问题类型:"; 
						text = ""; 
						ttmap = (Map<String, Object>) entry.getValue();
						text += (String) ttmap.get("text");
						ttmap.put("text", text);
						sList.add(ttmap);
					}
				}
				
			}
		}
//		System.out.println(sList);
		return sList;
	}
	
	public static boolean isInteger(String str) {  
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");  
        return pattern.matcher(str).matches();  
  }
	public List<Map<String, Object>> turnback(String cacheKey,String key,String currentLevel,String sourceType ){
//		List<Map<String, Object>> resultList = cacheMap.get(cacheKey);
		List<Map<String, Object>> resultList = (List<Map<String, Object>>)AgingCache.getCacheInfo(cacheKey).getValue();
		Map<String, Object> map = new HashMap<String, Object>();
		int currentLevelInt = Integer.parseInt(currentLevel);
		String fatherKey = "";
		int fatherLvl = currentLevelInt - 1;
		String tempKey = "";
		String researchNo = "";
		String zeroStr = "";
		for(int i=0;i<resultList.size();i++){
			map = resultList.get(i);
			researchNo = map.get("research_no")+"";
			tempKey = StringUtils.substring(researchNo, 0, levelMap.get(currentLevelInt));
			if(key.equals(tempKey)){
				zeroStr = StringUtils.substring(researchNo, levelMap.get(fatherLvl), levelMap.get(currentLevelInt));
				if("00".equals(zeroStr) || "000".equals(zeroStr)){
					return turnback(cacheKey, tempKey.substring(0, tempKey.length()-zeroStr.length()), (currentLevelInt-1)+"",sourceType);
				}
				if(fatherLvl != 0){
					fatherKey = StringUtils.substring(researchNo, 0, levelMap.get(fatherLvl));
				}else{
					fatherKey = "";
				}
				break;
			}
		}
		List<Map<String, Object>> list = this.generateCod(fatherKey, resultList, cacheKey, fatherLvl+"",sourceType);
		return list;
	}
	
	
	
	public List<Map<String,Object>> getMapInfo_bak20180102(String projectId,Map<String,List<String>> param){
		String attriSql = " select attribute_index from project_attribute where id = ? ";
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		StringBuilder sb = new StringBuilder();
		String attriAllSql = " select pa.attribute_name,pat.alias_name,pa.attribute_index"
				+ " from project_attribute pa left join project_attribute_type pat"
				+ " on pa.attribute_type = pat.id where pa.project_id = ? ";
		List<Map<String, Object>> attributeList = jdbcTemplate.queryForList(attriAllSql, projectId);
		if(attributeList == null || attributeList.size() == 0){
			return null;
		}
		List<String> conditionIdList = new ArrayList<String>();
		if (param != null && param.size() > 0) {
			String tempSql = "";
			sb.append(" select ");
			String aliasName = "";
			for (int i = 0; i < attributeList.size(); i++) {
				aliasName = (String)attributeList.get(i).get("alias_name");
				if(StringUtils.isNotBlank(aliasName)){
					if("detail_address".equals(aliasName) || "latitude".equals(aliasName) || "longitude".equals(aliasName) ){
						sb.append(" pd.ext"+attributeList.get(i).get("attribute_index") +" as " + aliasName +",");
					}
				}
			}
			sb.append(" pd.id ");
			sb.append(" from project_detail  pd ");
			sb.append(" where project_id = ? ");
			for (Map.Entry<String,List<String>> entry : param.entrySet()) {  
//				sb = new StringBuilder();
//			    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
				list = jdbcTemplate.queryForList(attriSql, entry.getKey());
				tempSql = "and ext_index in(select attribute_condition from project_attribute_condition where id in (?) )";
				if(list != null && list.size()>0){
					tempSql = tempSql.replace("_index", list.get(0).get("attribute_index")+"");
					conditionIdList = entry.getValue();
					if(conditionIdList != null && conditionIdList.size()>0){
						tempSql = tempSql.replace("?", Joiner.on(",").join(conditionIdList));
						sb.append(tempSql);
//			    		sqlParam.add(Joiner.on(",").join(conditionIdList));
					}
				}
			}
			resultList = jdbcTemplate.queryForList(sb.toString(), projectId);
			if(resultList != null && resultList.size()>0){
				Map<String, Object> resultmap = new HashMap<String, Object>();
				String longitude = "";
				String latitude = "";
				String key = "";
				DecimalFormat df = new DecimalFormat("#.00");
				double longitudeF = 0;
				double latitudeF = 0;
				Set<String> set = new HashSet<String>();
				
				for (int i = 0; i < resultList.size(); i++) {
					resultmap = resultList.get(i);
					longitude = resultmap.get("longitude")+"";
					latitude = resultmap.get("latitude")+"";
					try {
						longitudeF = Double.parseDouble(longitude);
						latitudeF = Double.parseDouble(latitude);
					} catch (Exception e) {
//						e.printStackTrace();
						continue;
					}
					key = df.format(longitudeF) +","+ df.format(latitudeF);
					set.add(key);
				}
				Map<String,Object> tMap = new HashMap<String, Object>();
				List<String> dList = new ArrayList<String>();
				for (int i = 0; i < resultList.size(); i++) {
					resultmap = resultList.get(i);
					longitude = resultmap.get("longitude")+"";
					latitude = resultmap.get("latitude")+"";
					try {
						longitudeF = Double.parseDouble(longitude);
						latitudeF = Double.parseDouble(latitude);
					} catch (Exception e) {
//						e.printStackTrace();
						continue;
					}
					key = df.format(longitudeF) +","+ df.format(latitudeF);
					for(String setkey:set){
						dList = new ArrayList<String>();
						if(setkey.equals(key)){
							if(tMap.containsKey(setkey)){
								dList = (List<String>) tMap.get(setkey);
								dList.add(resultmap.get("id")+"");
							}else{
								dList.add(resultmap.get("id")+"");
								tMap.put(setkey, dList);
							}
						}
					}
				}
				if(tMap != null && !tMap.isEmpty()){
					Map<String,Object> sMap = new HashMap<String, Object>();
					List<Map<String,Object>> sList = new ArrayList<Map<String,Object>>();
					for (Map.Entry<String,Object> entry : tMap.entrySet()) {
//						System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
						String[] ads = entry.getKey().split(",");
						longitude = ads[0];
						latitude = ads[1];
						sMap.put("longitude", longitude);
						sMap.put("latitude", latitude);
						sMap.put("id", StringUtils.join((List<String>)entry.getValue(), ","));
						sMap.put("detail_address", "");
						sList.add(sMap);
						sMap = new HashMap<String, Object>();
					}
					return sList;
				}
			}
		}
		return null;
	}
	
	/**
	 * status  is_check
	 * @param projectArray
	 * @param checkFlag
	 * @return
	 */
	public List<Map<String, Object>> analyzeJson(JSONArray projectArray,String checkFlag,String sourceType){
		List<Map<String, Object>> info = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		String projectId = "";
		Map<String,List<String>> param = new HashMap<String, List<String>>();
		List<String> conditionList = new ArrayList<String>();
		boolean projectStatus = false;
		boolean attrStatus = false;
		boolean detailStatus = false;
		for (int k = 0; k < projectArray.size(); k++) {
			param = new HashMap<String, List<String>>();
			JSONObject jsonObject = projectArray.getJSONObject(k);
			if("status".equals(checkFlag)){
				projectStatus =jsonObject.containsKey(checkFlag)?(Boolean) jsonObject.get(checkFlag):false;
			}else{
//				projectStatus = jsonObject.containsKey(checkFlag)?(Boolean) jsonObject.get(checkFlag):false;
				projectStatus = true;
			}
			if(projectStatus){
				projectId = jsonObject.get("id")+"";
				JSONArray array = jsonObject.getJSONArray("children");
				if(array != null && array.size()>0){
					for (int i = 0; i < array.size(); i++) {
						conditionList = new ArrayList<String>();
						JSONObject attrObject = array.getJSONObject(i);
						if("status".equals(checkFlag)){
							attrStatus = attrObject.containsKey(checkFlag)?(Boolean) attrObject.get(checkFlag):false;
						}else{
							attrStatus = true;
						}
						if(attrStatus){
							String AttriId = attrObject.getString("id");
							JSONArray conditionArray = attrObject.getJSONArray("children");
							for(int m =0;m<conditionArray.size();m++){
								JSONObject conditionObject = conditionArray.getJSONObject(m);
//								conditionList.add(conditionObject.get("condition_id")+"");
								if("status".equals(checkFlag)){
									detailStatus = conditionObject.containsKey(checkFlag)?(Boolean) conditionObject.get(checkFlag):false;
								}else{
									detailStatus = true;
								}
								if(detailStatus){
									conditionList.add(conditionObject.get("id")+"");
								}
							}
							if (conditionList != null && conditionList.size() > 0) {
								param.put(AttriId, conditionList);
							}
						}
					}
				}
				if (param != null && param.size() > 0) {
					list = this.getMapInfo(projectId, param, null,"0",sourceType);
					if (list != null && list.size() > 0) {
						info.addAll(list);
					}
				}
			}
		}
		return info;
	}
	
	
	public List<Map<String, Object>> getMapInfo_bak(String projectId,Map<String,List<String>> param){
		String attriSql = " select attribute_index from project_attribute where id = ? ";
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		StringBuilder sb = new StringBuilder();
		String attriAllSql = " select pa.attribute_name,pat.alias_name,pa.attribute_index"
				+ " from project_attribute pa left join project_attribute_type pat"
				+ " on pa.attribute_type = pat.id where pa.project_id = ? ";
		List<Map<String, Object>> attributeList = jdbcTemplate.queryForList(attriAllSql, projectId);
		if(attributeList == null || attributeList.size() == 0){
			return null;
		}
		List<String> conditionIdList = new ArrayList<String>();
		if (param != null && param.size() > 0) {
			String tempSql = "";
			sb.append(" select ");
			String aliasName = "";
			for (int i = 0; i < attributeList.size(); i++) {
				aliasName = (String)attributeList.get(i).get("alias_name");
				if(StringUtils.isNotBlank(aliasName)){
					if("detail_address".equals(aliasName) || "latitude".equals(aliasName) || "longitude".equals(aliasName) ){
						sb.append(" pd.ext"+attributeList.get(i).get("attribute_index") +" as " + aliasName +",");
					}
				}
			}
			sb.append(" pd.id ");
			sb.append(" from project_detail  pd ");
			sb.append(" where project_id = ? ");
			List<Object> sqlParam = new ArrayList<Object>();
			for (Map.Entry<String,List<String>> entry : param.entrySet()) {  
//				sb = new StringBuilder();
//			    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
				list = jdbcTemplate.queryForList(attriSql, entry.getKey());
				tempSql = "and ext_index in(select attribute_condition from project_attribute_condition where id in (?) )";
			    if(list != null && list.size()>0){
			    	tempSql = tempSql.replace("_index", list.get(0).get("attribute_index")+"");
			    	conditionIdList = entry.getValue();
			    	if(conditionIdList != null && conditionIdList.size()>0){
			    		tempSql = tempSql.replace("?", Joiner.on(",").join(conditionIdList));
			    		sb.append(tempSql);
//			    		sqlParam.add(Joiner.on(",").join(conditionIdList));
			    	}
			    }
			}
			resultList = jdbcTemplate.queryForList(sb.toString(), projectId);
			if(resultList != null && resultList.size()>0){
				return resultList;
			}
		}
		return null;
	}
	
	
	public List<Map<String, Object>> getCoordinateInfoByIds(String coordinateId){
		List<String> coordinateIdList = new ArrayList<String>();
		if(coordinateId.contains(",")){
			coordinateIdList = Arrays.asList(coordinateId.split(","));  
		}else{
			coordinateIdList.add(coordinateId);
		}
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> resplist = new ArrayList<Map<String,Object>>();
		for(String id:coordinateIdList){
			list = this.getCoordinateInfo(id);
			resplist.addAll(list);
		}
		return resplist;
	}
	
	
	public List<Map<String, Object>> getCoordinateInfo(String detailId){
//		String attrSql = " SELECT pa.id, pat.alias_name, pa.attribute_index, pa.attribute_name FROM project_attribute_type pat LEFT JOIN ( SELECT * FROM project_attribute WHERE project_id = ( SELECT project_id FROM project_detail WHERE id = ? )) pa ON pa.attribute_info_type = pat.id WHERE pat.type = 1 and pa.id is not null ORDER BY alias_name ";
		String attrSql = " SELECT pa.id, pat.alias_name, pa.attribute_index, pa.attribute_name FROM ( SELECT * FROM project_attribute_type WHERE type = 1 and alias_name is not null) pat LEFT JOIN ( SELECT * FROM project_attribute WHERE project_id = ( SELECT project_id FROM project_detail WHERE id = ? ) AND id IS NOT NULL ) pa ON pa.attribute_info_type = pat.id WHERE 1 = 1 ORDER BY alias_name ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(attrSql, detailId);
		if(list == null || list.size()==0){
			return null;
		}
		Map<String, Object> attrMap = new HashMap<String, Object>();
		StringBuilder sb = new StringBuilder();
		sb.append(" select ");
		for (int i = 0; i < list.size(); i++) {
			attrMap = list.get(i);
			if(attrMap.get("attribute_name") != null && StringUtils.isNotBlank(attrMap.get("attribute_name")+"")){
				sb.append(" ext"+attrMap.get("attribute_index")+" as "+attrMap.get("alias_name")+"_value,");
				sb.append("'"+attrMap.get("attribute_name")+"' as "+attrMap.get("alias_name")+"_key,");
			}else{
				sb.append(" 'null' as "+attrMap.get("alias_name")+"_key,");
				sb.append("'null' as "+attrMap.get("alias_name")+"_value,");
			}
			//测试使用
//			sb.append(" 'null' as "+"detail_8_key,");
//			sb.append("'null' as "+"detail_8_value,");
			//测试使用
		}
		sb.append(" id from project_detail where id = ? ");
		return jdbcTemplate.queryForList(sb.toString(), detailId);
	}
	public List<Map<String, Object>> getCoordinateInfo_bak20180107(String detailId){
		String attrSql = " SELECT pat.alias_name, attribute_index FROM project_attribute_type pat LEFT JOIN ( SELECT * FROM project_attribute WHERE project_id = ( SELECT project_id FROM project_detail WHERE id = ? )) pa ON pa.attribute_type = pat.id WHERE pat.alias_name IS NOT NULL ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(attrSql, detailId);
		if(list == null || list.size()==0){
			return null;
		}
		Map<String, Object> attrMap = new HashMap<String, Object>();
		StringBuilder sb = new StringBuilder();
		sb.append(" select ");
		for (int i = 0; i < list.size(); i++) {
			attrMap = list.get(i);
			if(StringUtils.isNotBlank(attrMap.get("attribute_index")==null?null:attrMap.get("attribute_index")+"")){
				sb.append(" ext"+attrMap.get("attribute_index")+" as "+attrMap.get("alias_name")+",");
			}else{
				sb.append(" 'null' as "+attrMap.get("alias_name")+",");
			}
		}
		sb.append(" id from project_detail where id = ? ");
		return jdbcTemplate.queryForList(sb.toString(), detailId);
	}
	
	
	public List<Map<String, Object>> getImgPath(String id){
		String sql = " select img_path from project_detail where id = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, id);
		return list;
	}
	private int tempi = 0;
	@Override
	public void afterPropertiesSet() throws Exception {
		if(tempi == 0){
			initResearchNo();
		}
		tempi++;
	}
	
	public void updateWebUserPwdById(String pwd,String userId){
		String sql = " update web_user_login set user_password = ? where id = ?  ";
		jdbcTemplate.update(sql, pwd,userId);
	}
	
	public void updateWebUserEmail(String email,String userId){
		String sql = " update web_user_login set email = ? where id = ?  ";
		jdbcTemplate.update(sql, email,userId);
	}
	
	public List<Map<String, Object>> getWebUserInfoByUserName(String name){
		String sql = " select * from web_user_login where user_name = ? ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, name);
		return list;
	}
	
	public void updateWxBind(String userId ,String appId){
		String sql = " update web_user_login set wx_appid = ? ,wx_bind_time = NOW() where id = ? ";
		jdbcTemplate.update(sql, appId,userId);
	}
	
	
}
