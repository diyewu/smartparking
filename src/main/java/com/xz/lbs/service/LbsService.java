package com.xz.lbs.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.lbs.utils.AyPoint;
import com.xz.lbs.utils.GeoUtils;
import com.xz.utils.CreateExcelUtil;
import com.xz.utils.ExcelReadUtils;

@Service
@Transactional
public class LbsService implements InitializingBean{

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private static Map<String,List<AyPoint>> areaMap = new HashMap<String, List<AyPoint>>();
	
	public String geoAddress(File file, String destPath, HttpSession session,String apiKey) {
		ArrayList<ArrayList<Object>> list = new ArrayList<ArrayList<Object>>();
		List<List<Object>> respList = new ArrayList<List<Object>>();
		String msg = "success";
		//优秀取经纬度，若无经纬度信息，则取详细地址，再根据详细地址获取经纬度，再判断电子围栏信息
		int longitudeIndex = -1;// 经度 列数
		int latitudeIndex = -1;// 纬度 列数
		int addressIndex = -1;// 详细地址 列数
		try {
			list = ExcelReadUtils.readAllRows(file);
			
			String longitude = "";
			String latitude = "";
			ArrayList<Object> objList = new ArrayList<Object>();
			objList = list.get(0);
			for (int i = 0; i < objList.size(); i++) {
				if ("经度".equals((String) objList.get(i))) {
					longitudeIndex = i;
				}
				if ("纬度".equals((String) objList.get(i))) {
					latitudeIndex = i;
				}
				if ("详细地址".equals((String) objList.get(i))) {
					addressIndex = i;
				}
			}
			if (longitudeIndex != -1 && latitudeIndex != -1) {
				objList.add("转换后详细地址");
			}else if(addressIndex != -1){
				objList.add("转换后经度");
				objList.add("转换后纬度");
				objList.add("转换后详细地址");
			}
			respList.add(objList);
			for (int i = 1; i < list.size(); i++) {
				objList = new ArrayList<Object>();
				objList = list.get(i);
				if (longitudeIndex != -1 && latitudeIndex != -1) {//经纬度优先
						longitude = (String) objList.get(longitudeIndex);
						latitude = (String) objList.get(latitudeIndex);
						String address = "";
						if (StringUtils.isNotBlank(longitude) && StringUtils.isNotBlank(latitude)) {
							for (Map.Entry<String,List<AyPoint>> entry : areaMap.entrySet()) { 
								boolean flag = GeoUtils.getAddressByRegion(Double.parseDouble(longitude), Double.parseDouble(latitude), entry.getValue());
								if(flag){
									address = entry.getKey();
									break;
								}
							}
						}
						objList.add(address);
						respList.add(objList);
				}else if(addressIndex != -1){//详细地址--》经纬度--》电子围栏获取街镇
					String address = "";
					String sourceAddress = (String) objList.get(addressIndex);
					Map<String, String> map = GeoUtils.getGeocoderLatitude(sourceAddress, apiKey);
					for (Map.Entry<String, List<AyPoint>> entry : areaMap.entrySet()) {
						boolean flag = GeoUtils.getAddressByRegion(Double.parseDouble(map.get("longitude")),
								Double.parseDouble(map.get("latitude")), entry.getValue());
						if (flag) {
							address = entry.getKey();
							break;
						}
					}
					objList.add(map.get("longitude"));
					objList.add(map.get("latitude"));
					objList.add(address);
				}
			}

			CreateExcelUtil.createExcelFile(destPath, respList);
			session.setAttribute("downloadFilePath", destPath);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		return msg;
	}
	
	/**
	 * 获取电子围栏 位置信息
	 * @return
	 */
	public List<Map<String, Object>> getLocationInfo() {
		String sql = " select * from location_area ";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		return list;
	}

	private static int kk = 0;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		if(kk == 0){
			//加载电子围栏信息
			List<Map<String, Object>> list = this.getLocationInfo();
			if(list != null && list.size()>0){
//				Map<String,List<AyPoint>> apMap = new HashMap<String, List<AyPoint>>(); 
				List<AyPoint> apList = new ArrayList<AyPoint>();
				Map<String, Object> tmap = new HashMap<String, Object>();
				String name = "";
				String location = "";
				for(int i =0;i<list.size();i++){
					apList = new ArrayList<AyPoint>();
					name = "";
					location = "";
					tmap = new HashMap<String, Object>();
					tmap = list.get(i);
					name = tmap.get("name")+"";
					location = tmap.get("location")+"";
					String[] ls = location.split(",");
					double x = Double.parseDouble(ls[0]);
					double y = Double.parseDouble(ls[1]);
					AyPoint ap = new AyPoint(x, y);
					if(areaMap.containsKey(name)){//已经存在，则取出value，并重新放入
						apList = areaMap.get(name);
					}
					apList.add(ap);
					areaMap.put(name, apList);
				}
			}
		}
		kk++;
	}
}
