package com.xz.controller.api;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xz.common.ServerResult;
import com.xz.entity.CustomConfig;
import com.xz.model.json.JsonModel;
import com.xz.service.LbsService;

import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("lbs")
public class LbsController {
	
	@Autowired  
    private CustomConfig customConfig; 
	@Autowired  
	private LbsService lbsService; 
	
	class ReadCallable implements Callable<Object>{
		private String destPath;
		private File xlsFile;
		private HttpSession session;
		
		ReadCallable(String destPath,File xlsFile,HttpSession session) {
			this.destPath = destPath;
			this.xlsFile = xlsFile;
			this.session = session;
			
		}
		@Override
		public Object call() throws Exception {
			String resp = "";
			try {
				resp = lbsService.geoAddress(xlsFile, destPath,session);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return resp;
		}
	}
	ExecutorService threadPool = Executors.newCachedThreadPool();
	
	@ApiOperation(value = "上传文件", notes = "上传文件")
	@RequestMapping("upload")
	@ResponseBody
	public JsonModel upload(HttpServletRequest request,HttpServletResponse response){
		HttpSession session=request.getSession();
		String msg = null;
		int code = 0;
    	Map<String, String> map = new HashMap<String, String>();
		try{
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
			if (multipartResolver.isMultipart(request)) {
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				Iterator iter = multiRequest.getFileNames();
				File xlsFile = null;
				File zipFile = null;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				Date d = new Date();  
				String dateNowStr = sdf.format(d);
				String destPath = customConfig.getClientFileUpladPath()+File.separator+dateNowStr+File.separator+System.currentTimeMillis()+".xlsx";
				while (iter.hasNext()) {
					// 一次遍历所有文件
					MultipartFile file = multiRequest.getFile(iter.next().toString());
					if (file != null) {
				        String uploadPath = customConfig.getClientFileUpladPath()+File.separator+dateNowStr;
				        File uploadPathFile =new File(uploadPath);
						if(!uploadPathFile.exists() && !uploadPathFile.isDirectory() ){
							uploadPathFile.mkdir();
						}
						//xls
						String path=customConfig.getClientFileUpladPath()+File.separator+dateNowStr+File.separator+new Date().getTime()+file.getOriginalFilename();
						// 上传
						file.transferTo(new File(path));
						if((file.getOriginalFilename()).contains(".xls")){//上传EXCEL文件
							xlsFile = new File(path);
						}
					}
	
				}
				if(xlsFile != null || zipFile != null){
					if(msg == null){
						//线程处理
						ReadCallable cb = new ReadCallable(destPath, xlsFile,session);
						Future<Object> future = threadPool.submit(cb);
//						if("success".equals(future.get())){//成功返回
//							
//						}
					}
				}
			}
		}catch(Exception e){
			code = ServerResult.RESULT_SERVER_ERROR;
			e.printStackTrace();
			msg = e.getMessage();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), null);
	}
	
	
	
	
	@ApiOperation(value = "检车session中是否存在下载信息", notes = "检车session中是否存在下载信息", httpMethod = "POST")
	@RequestMapping("checkSession")
	@ResponseBody
	public JsonModel checkSession(HttpServletRequest request,HttpServletResponse response){
		String msg = null;
		int code = 0;
		Map<String,Object> respMap = new HashMap<String, Object>();
		HttpSession session=request.getSession();
		try {
			String path = (String)session.getAttribute("downloadFilePath"); 
	        if(StringUtils.isBlank(path)){
	        	code = 1;
	        }
		} catch (Exception e) {
			code = ServerResult.RESULT_SERVER_ERROR;
			msg = e.getMessage();
			e.printStackTrace();
		}
		return new JsonModel(code, ServerResult.getCodeMsg(code, msg), respMap);
	}
	
	
	@RequestMapping("downloadExcel")
	@ResponseBody
	public void downloadExcel(HttpServletRequest request,HttpServletResponse response){
        response.setHeader("Pragma", "No-cache"); 
        response.setHeader("Cache-Control", "no-cache"); 
        response.setDateHeader("Expires", 0); 
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.addHeader("Content-Disposition","inline; attachment; filename=" + System.currentTimeMillis()+".xlsx");
        HttpSession session=request.getSession();
        
        List<Map<String, Object>> list = null ;
        File excelFile = null;
        String path = (String)session.getAttribute("downloadFilePath"); 
        if(StringUtils.isNotBlank(path)){
        	session.setAttribute("downloadFilePath", "");
        	excelFile = new File(path); 
        }
        if(excelFile != null){
            OutputStream os = null;
            FileInputStream fos = null;
			try {
				os = response.getOutputStream();
				byte[] buffer = new byte[2048];
				fos = new FileInputStream(excelFile.getPath());
				int count;
				while ((count = fos.read(buffer)) > 0) {
					os.write(buffer, 0, count);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally{
				try {
					if (os != null)
						os.close();
					if (fos != null)
					fos.close();
				} catch (IOException e) {
				}
			}
        }
	}
}
