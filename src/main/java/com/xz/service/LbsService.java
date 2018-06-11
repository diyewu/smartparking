package com.xz.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xz.utils.CreateExcelUtil;
import com.xz.utils.ExcelReadUtils;
import com.xz.utils.HttpUtil;

@Service
@Transactional
public class LbsService {
	
	@Autowired  
	private JdbcTemplate jdbcTemplate; 
	
	
	public String geoAddress(File file,String destPath,HttpSession session){
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<ArrayList<Object>> list = new ArrayList<ArrayList<Object>>();
		List<List<Object>> respList = new ArrayList<List<Object>>();
		String msg = "success";
		int longitudeIndex = 0;//经度 列数
		int latitudeIndex = 0;//纬度 列数
		try {
			list = ExcelReadUtils.readAllRows(file);
			ArrayList<Object> objList = new ArrayList<Object>(); 
			objList = list.get(0);
			objList.add("转换后详细地址");
			respList.add(objList);
			String longitude = "";
			String latitude = "";
			for(int i=0;i<objList.size();i++){
				if("经度".equals((String)objList.get(i))){
					longitudeIndex = i;
				}
				if("纬度".equals((String)objList.get(i))){
					latitudeIndex = i;
				}
			}
			if(longitudeIndex != 0 && latitudeIndex != 0){
				for(int i=1;i<list.size();i++){
					objList = new ArrayList<Object>();
					objList = list.get(i);
					longitude = (String)objList.get(longitudeIndex);
					latitude = (String)objList.get(latitudeIndex);
					String address = "";
					if(StringUtils.isNotBlank(longitude) && StringUtils.isNotBlank(latitude)){
						String resp = HttpUtil.httpGetRequest("http://api.map.baidu.com/cloudrgc/v1?location="+longitude+","+latitude+"&geotable_id=135675&coord_type=bd09ll&ak=plEzfOG4jm58EGxEsHw4kCPoG3UjOcNv");
						Map<String,Object> map = (Map<String,Object>)mapper.readValue(resp, Map.class);
						address = (String)map.get("formatted_address");
						System.out.println("______address="+address);
					}
					objList.add(address);
					respList.add(objList);
				}
			}
			
			CreateExcelUtil.createExcelFile(destPath, respList);
			session.setAttribute("downloadFilePath", destPath);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
		}
		return msg ;
	}
}
