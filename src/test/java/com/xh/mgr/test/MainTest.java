package com.xh.mgr.test;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

public class MainTest {
	public static void main(String[] args) {
		splitTest();
	}
	
	
	
	public static void formatTest(){
		DecimalFormat df = new DecimalFormat("#.00000");
		double longitudeF = 121.411;
		double latitudeF = 30.803;
		String key = df.format(longitudeF) + df.format(longitudeF);
		System.out.println(key);
		
	}
	
	public static void splitTest(){
//		String s = "310000000000";
//		String zero = "00";
//		String resp = s.substring(0, s.length()-zero.length());
//		System.out.println(resp);
		String s = "3100000000000013BZ";
		int a =12;
		int b =16;
		
	}
	public static void listTest(){
		List<String> list = new ArrayList<String>();
		list.add("1");
		list.add("1");
		list.add("1");
		System.out.println(StringUtils.join(list.toArray(), "','"));
	}
}
