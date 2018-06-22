package com.xz.lbs.utils;
import java.util.ArrayList;
import java.util.List;

public class TestRegion {
	public static void main(String[] args){
		check();
	}
	
	private static void check(){
		AyPoint p = new AyPoint(121.392988,31.162703);
		List<AyPoint> apl = new ArrayList<AyPoint>();
		//117.18137,39.13884,117.18568,39.13874,117.18560,39.13709,117.18139,39.13724
		apl.add(new AyPoint(121.392987,31.162703));
		apl.add(new AyPoint(121.383636,31.163446));
		apl.add(new AyPoint(121.386986,31.153154));
		apl.add(new AyPoint(121.388369,31.139664));
		apl.add(new AyPoint(121.391962,31.132678));
		apl.add(new AyPoint(121.400676,31.135275));
		apl.add(new AyPoint(121.398107,31.146077));
		apl.add(new AyPoint(121.402455,31.147282));
		apl.add(new AyPoint(121.406443,31.149878));
		apl.add(new AyPoint(121.406623,31.149786));
		apl.add(new AyPoint(121.408851,31.143635));
		apl.add(new AyPoint(121.413162,31.145861));
		apl.add(new AyPoint(121.416217,31.147808));
		apl.add(new AyPoint(121.416217,31.148271));
		apl.add(new AyPoint(121.415857,31.150713));
		apl.add(new AyPoint(121.41672,31.151207 ));
		apl.add(new AyPoint(121.40921,31.168265 ));
		apl.add(new AyPoint(121.401233,31.165268));
		apl.add(new AyPoint(121.402239,31.161683));
		apl.add(new AyPoint(121.394693,31.159705));
		apl.add(new AyPoint(121.393975,31.162796));
		apl.add(new AyPoint(121.383636,31.163446));
		//apl.add(new AyPoint(117.1171,39.392));
		boolean b = AnalysisPointAndRegion.judgeMeetPoint(p, apl);
		String isIn = b?"内":"外";
		System.out.print("点在围栏  " + isIn);
	}
}
