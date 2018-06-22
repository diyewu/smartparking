package com.xz.lbs.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;

import com.xz.utils.HttpUtil;

public class GeoUtils {
	
	public static void main(String[] args) {
		//上海市古美高级中学
		System.out.println(getGeocoderLatitude("上海市万源路平南路路口", "plEzfOG4jm58EGxEsHw4kCPoG3UjOcNv"));
	}
	/**
	 * 根据详细地址获取 经纬度
	 * @param address
	 * @param key
	 * @return
	 */
	public static Map<String,String> getGeocoderLatitude(String address,String key) {
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
	
	
	/**
	 * 根据经纬度获取 详细地址
	 * @param longitude
	 * @param latitude
	 * @param apiKey
	 * @return
	 */
	public static String getGeocoderAddress(String longitude,String latitude,String apiKey){
		ObjectMapper mapper = new ObjectMapper();
		String resp = HttpUtil.httpGetRequest(
				"http://api.map.baidu.com/cloudrgc/v1?location=" + longitude + "," + latitude
						+ "&geotable_id=135675&coord_type=bd09ll&ak="+apiKey);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map = (Map<String, Object>) mapper.readValue(resp, Map.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String address = (String) map.get("formatted_address");
		System.out.println("______address=" + address);
		return address;
	}
	
	/**
	 * 根据经纬度筛选数据库电子围栏信息
	 * @param x(大)
	 * @param y
	 * @param apl
	 * @return
	 */
	public static boolean getAddressByRegion(double x,double y,List<AyPoint> apl){
		AyPoint p = new AyPoint(x,y);
		boolean b = AnalysisPointAndRegion.judgeMeetPoint(p, apl);
		return b;
	}
	
}
