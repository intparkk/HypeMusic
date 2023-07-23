package com.study.springboot.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class hjs_uploadcontroller {

	/*
	 * 경로는 각자의 PC환경에 맞추어 총 3군데 수정하셔야합니다. 
	 * 두번째, 세번째 경로에 반드시 마지막에 \\ 붙여주셔야합니다. 
	 */
	@RequestMapping("/hjs_img_uploadForm")
	public String uploadForm(Model model) {
		
		String path = "C:\\Users\\h\\Desktop\\HypeMusic\\src\\main\\resources\\static\\user_profile_img";
		List list = getFiles(path);
		model.addAttribute("fileList", list);
		
		return "hjs_music_imgupload";
	}
	
	
	// 파일 목록을 가져오기
	List getFiles(String path) {
		
		File file = new File(path);
		
		File[] listFiles = file.listFiles(); // File 객체로 가져오기
		
		
		List list = new ArrayList();
		
		for(int i=0; i<listFiles.length; i++) {
			File tmpFile = listFiles[i];
			// 폴더라면
			if( tmpFile.isDirectory() ) {
				System.out.println("폴더이고 이름은 : "+ tmpFile.getName());
				System.out.println("폴더이고 경로는 : "+ tmpFile.getPath());
				
				// 재귀호출; 내가 나를 다시 부르기
				List subList = getFiles( tmpFile.getPath() );
				list.addAll(subList);
				System.out.println("---------- 오늘 폴더 완료");
			} else {
				System.out.println("파일이고");
				System.out.println("이름: "+ tmpFile.getName());
				System.out.println("크기: "+ tmpFile.length());
				System.out.println("경로: "+ tmpFile.getPath());
				
				Map map = new HashMap();
				map.put("name", tmpFile.getName());
				
				list.add( map );
			}
		}
		
		return list;
	}
	
	@RequestMapping("/hjs_img_uploadOk")
	@ResponseBody
	public String uploadOk(
			@RequestParam("filename") 
			MultipartFile multipartFile
			) {
		try {
			// 방어
			// filename이 비어있는지 확인
			if( multipartFile.isEmpty() ) {
				return "need file";
			}
		
			
			String path = "C:\\Users\\h\\Desktop\\HypeMusic\\src\\main\\resources\\static\\user_profile_img\\";
			
			File dir = new File(path);
			
			if(dir.exists()) { // 존재하느냐?
				System.out.println(path +" : 디렉토리가 존재합니다.");
			} else {
				boolean isMake = dir.mkdir();
				if( isMake ) {
					System.out.println(path +" : 디렉토리를 생성했습니다.");
				} else {
					System.out.println(path +" : 디렉토리를 생성에 실패했습니다.");
				}
			}
			
			
			String fileName = multipartFile.getOriginalFilename();
			long now = System.currentTimeMillis();
			fileName = now +"_"+ fileName;
			System.out.println("fileName : "+ fileName);
			
			// file 객체 만들기
			System.out.println(path +File.separator+ fileName);
			File file = new File( path +File.separator+ fileName );
			
			// 그 file 객체에 덮어쓰기
			FileUtils.writeByteArrayToFile(file, multipartFile.getBytes());
			
		}catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
		
		return "성공입니다~! 이미지를 확인하시려면 되돌아가기+새로고침.♡";
	}
	

	@RequestMapping("/hjs_readMail")
	public ResponseEntity<byte[]> readMail(HttpServletRequest req) {
	    String id = req.getParameter("id");
	    System.out.println("id: " + id);
	try {
	    // 디렉토리에서 가장 최신 파일을 가져옴
	    File directory = new File("C:\\Users\\h\\Desktop\\HypeMusic\\src\\main\\resources\\static\\user_profile_img\\");
	    File[] files = directory.listFiles();
	    
	    if (files != null && files.length > 0) {
	        File lastModifiedFile = Arrays.stream(files)
	                .filter(File::isFile)
	                .max(Comparator.comparingLong(File::lastModified))
	                .orElse(null);
	        
	        if (lastModifiedFile != null) {
	            // 이미지 파일을 바이트 배열로 읽어옴
	            byte[] imageBytes = Files.readAllBytes(lastModifiedFile.toPath());
	            
	            // 응답 헤더 설정
	            HttpHeaders headers = new HttpHeaders();
	            headers.setContentType(MediaType.IMAGE_JPEG);
	            
	            // 이미지 파일 바이트 배열과 헤더를 포함한 ResponseEntity 반환
	            return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
	        }
	    }
	    
	    return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	} catch (IOException e) {
	    e.printStackTrace();
	    return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}

//	/* 주석 코드는 폴더에 있는 모든 이미지 파일을 화면에 표시해줍니다. 필요할때만 사용해보셔요. */
//	
//	@RequestMapping("/hjs_readMail")
//	public ResponseEntity<byte[]> readMail(HttpServletRequest req) {
//	    String id = req.getParameter("id");
//	    System.out.println("id: " + id);
//	    
//	    // 이미지 파일 경로
//	    String imagePath = "C:\\Users\\h\\Desktop\\HypeMusic\\src\\main\\resources\\static\\user_profile_img\\" + id;
//	    
//	    try {
//	        // 이미지 파일을 바이트 배열로 읽어옴
//	        File file = new File(imagePath);
//	        byte[] imageBytes = Files.readAllBytes(file.toPath());
//	        
//	        // 응답 헤더 설정
//	        HttpHeaders headers = new HttpHeaders();
//	        headers.setContentType(MediaType.IMAGE_JPEG);
//	        
//	        // 이미지 파일 바이트 배열과 헤더를 포함한 ResponseEntity 반환
//	        return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
//	    } catch (IOException e) {
//	        e.printStackTrace();
//	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//	    }
//	}
//
	
	
}
	
	
