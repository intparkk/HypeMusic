package com.study.springboot.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.HjscommentDAO;
import com.study.springboot.dao.HjsmusicDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.HjscommentDTO;
import com.study.springboot.dto.HjsmusicDTO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.HjsmusicService;
import com.study.springboot.service.UserService;
import com.study.springboot.service.pjs_detailpage_service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class hjs_musiccontroller {


	@Autowired(required=false)
	private HjsmusicDAO hjsmusicDAO;
	
	@Autowired
	HjsmusicService hjsmusicService;
	
	@Autowired
	HjscommentDAO hjscommentDAO;
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDAO userDAO;
	
	@Autowired
	pjs_detailpage_service detailpage_Service;
		
	@RequestMapping("/hjs_main_test")
	public String test1() {
		
		System.out.println("hjs_test");
		return "hjs_main_test";
	}
	
	
/*
 * @author 허진서
 * 엑셀의 자료를 불러와서 DB로 담는 컨트롤러
 * 
 */
 
	@RequestMapping("/ExcelToDB")
	public String music2() {
		 // 엑셀파일 경로(각자의 PC환경에 맞게 바꾸셔야 합니다. 이미 아시겠지만요.~)	
		 String filePath = "C:\\Users\\82109\\OneDrive\\바탕 화면\\HypeMusic\\src\\main\\resources\\metadata\\MelonCrawling_2020.1~2023.4.xlsx";
		 
		 DataFormatter dataFormatter = new DataFormatter();
		    // 엑셀 파일을 java로 불러오기
	        try (FileInputStream fis = new FileInputStream(filePath);
	             Workbook workbook = new XSSFWorkbook(fis)) {
	        	// 첫 번째 시트를 선택합니다.
	            Sheet sheet = (Sheet) workbook.getSheetAt(0); 

	            	// 첫번째 행은 열의 명칭부분이라 건너뛰도록 합니다.
	                boolean isFirst = true;
	                for (Row row : sheet) {
	                	if(isFirst == true){
	                		isFirst = false;
	                		continue;
	                	}
	                	// 엑셀에서 필요한 열만 따로 선별하여 java로 불러옴
	                    // 필요한 열의 데이터를 추출하여 DB에 저장
	                    Cell cell = row.getCell(0);
	                    double track_id2 = cell.getNumericCellValue();
	                    
	                    Cell cell1 = row.getCell(1);
	                    double artist_id2 = cell1.getNumericCellValue();
	                    
	                    Cell cell2 = row.getCell(8);
	                    String album_image2 = cell2.getStringCellValue();
	                    
	                    Cell cell3 = row.getCell(2);
	                    String title2 = cell3.getStringCellValue();
	                    
	                    Cell cell4 = row.getCell(9);
	                    String artist2 = cell4.getStringCellValue();
	                    
	                    Cell cell5 = row.getCell(4);
	                    String album_name2 = cell5.getStringCellValue();
	                    
	                    Cell cell6 = row.getCell(17);
	                    double numericValue = 0;
	                    try{
	                    	numericValue = cell6.getNumericCellValue();
	                    } catch (Exception e) {
							String tmp = cell6.getStringCellValue();
							System.out.println("에러 : "+ tmp);
						}
	                    int like_count2 = (int) numericValue;
	                    
	                    Cell cell7 = row.getCell(6);
	                    String genre2 = cell7.getStringCellValue();

	                    Cell cell8 = row.getCell(5);
	                    // Cell의 타입에 상관없이 값을 문자열로 변환
		                String release_date2 = dataFormatter.formatCellValue(cell8);

	                    Cell cell9 = row.getCell(7);
	                    String lyrics2 = cell9.getStringCellValue();

	                    System.out.println(cell8);
	                    System.out.println(release_date2);
	                    System.out.println(title2);
	                    System.out.println(lyrics2);
	                   
	                    // java로 불러온 데이터를 HjsmusicDTO객체에 매핑하기
	                    HjsmusicDTO musicDto = new HjsmusicDTO();
	                    musicDto.setTrack_id(""+track_id2);
	                    musicDto.setArtist_id(""+artist_id2);
	                    musicDto.setAlbum_img(album_image2);
	                    musicDto.setTitle(title2);
	                    musicDto.setArtist(artist2);
	                    musicDto.setAlbum_name(album_name2);
	                    musicDto.setLike_count(like_count2);
	                    musicDto.setGenre(genre2);
	                    musicDto.setRelease_date(release_date2);
	                    musicDto.setLyrics(lyrics2);
	               
						System.out.println(musicDto);
	                    System.out.println(release_date2);
	                    

	                
	                    // HjsmusicDao의 writeDao 메서드를 호출하여 DB에 저장
	                    hjsmusicDAO.writeDao(musicDto); 

	                
	                }
		       } catch (Exception e) {
		            e.printStackTrace();
		        }
		
		return "hjs_ExcelToDB";
	}

	
	@RequestMapping("/hjs_music_top100")
	public String music_top100(
			Model model,
			HttpServletRequest req, 
			HjsmusicDTO musicDto,
			@RequestParam(value="pageNum", required=false)
			Integer pageNum, String youtube_url
			) {
		
		// HjsmusicDTO 객체를 적절하게 초기화하고 값을 설정해야 합니다.
		HjsmusicDTO dto = musicDto;
		System.out.println("pageNum : "+ pageNum);
		if(pageNum == null) {
			pageNum = 1;
		}
		
		String cpp = req.getParameter("countPerPage");
		int countPerPage = 10;
		
		try {
			countPerPage = Integer.parseInt(cpp); // 한 페이지당 표시 수
		}catch (Exception e) {
		//	e.printStackTrace();
		}
		
		int startNum = ((pageNum-1) * countPerPage) + 1;
		int endNum = startNum + (countPerPage - 1);
		
		System.out.println("startNum : "+ startNum +", endNum : "+ endNum);
		
		musicDto.setStartNum(startNum);
		musicDto.setEndNum(endNum);
		
		req.setAttribute("pageNum", pageNum);
		model.addAttribute("countPerPage", countPerPage);
		
		Map map = hjsmusicService.list(musicDto);
		List<HjsmusicDTO> list = (List<HjsmusicDTO>) map.get("list");
		
		model.addAttribute("list", list);
		
		System.out.println("list"+list);
		
		int total = (int) map.get("totalCount");
		
		req.setAttribute("total", total);
		
		return "hjs_music_top100";
	}

	// 페이지 완성후에 오류코드를 확인후 수정하기 
	@RequestMapping("/music_info")

	public String music_info(
			Model model,
			@RequestParam("track_id") String track_id,
			@ModelAttribute HjscommentDTO dto2,
			HttpServletRequest req
			) {
		
		HttpSession session = req.getSession();
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		int user_id = userInfo.getUser_id();
		
		System.out.println("user_id:"+user_id);
		
		HjsmusicDTO dto = hjsmusicDAO.viewDao(track_id);
		model.addAttribute("dto",dto);
		List<HjscommentDTO> list = hjscommentDAO.listDao(track_id);
		model.addAttribute("list",list);
		
		System.out.println(list);
		return "hjs_music_info";
	}
	
	@RequestMapping("/write_comment")
	public String write2(
			UserDTO userDTO,			
			HjsmusicDTO musicDTO,
			@RequestParam(value="track_id", required=true, defaultValue="") 
			String track_id,
			@ModelAttribute HjscommentDTO dto2,
			Model model,
			HttpServletRequest req,
			HttpServletResponse resp

			) {

		HttpSession session = req.getSession();
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		
		//null이면 로그인 페이지로 유도 
		if(userInfo == null) {
			try {
				resp.sendRedirect("loginForm.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		int user_id2 = userInfo.getUser_id();
		
		System.out.println("user_id:"+user_id2);
		
		// --------- 박정수 : 여기서부터 수정한 내용입니다 --------------
		// 박정수 : track_id 를 처리하기 위한 변수입니다
		HjsmusicDTO trackId = hjsmusicDAO.viewDao(track_id);
		String trackIdString = trackId.getTrack_id();
		
		// 박정수 : 댓글 달기위해 호출하였습니다
		List<HjscommentDTO> list = hjscommentDAO.listDao(track_id);
		model.addAttribute("list",list);
		
		// --------- 박정수 : 여기까지가 수정한 내용입니다 --------------
		
		
		String comment_id = dto2.getComment_id();
		String comment_content = dto2.getComment_content();
		String parent_id = dto2.getParent_id();
		
		System.out.println("comment_id : "+ comment_id);
		System.out.println("user_id : "+ user_id2);
		System.out.println("comment_content: "+ comment_content);
		System.out.println("parent_id : "+ parent_id);
		
		dto2.setUser_id(user_id2);
		
		int result = hjscommentDAO.writeDao(dto2);
		System.out.println("writeDao result : "+ result);
		return "redirect:/music_info?track_id="+trackIdString;		
	}
	
	
	@RequestMapping("/reply")
	public String reply(
			@ModelAttribute("dto") HjsmusicDTO dto,
			@RequestParam(value = "track_id", required = true, defaultValue = "") String track_id,
			@ModelAttribute("dto2") HjscommentDTO dto2,
			@RequestParam(value = "comment_id", required = false) String comment_id,
			Model model,
			HttpServletRequest req
	) {
		
		HjsmusicDTO dto1 = hjsmusicDAO.viewDao(track_id);
		model.addAttribute("dto",dto1);
		
		HjscommentDTO dto3 = hjscommentDAO.viewDao(comment_id);
		System.out.println("comment_id:"+comment_id);
		System.out.println("dto3:"+dto3.getComment_id());
		model.addAttribute("dto2",dto3);
		System.out.println(dto3);
		
		// 박정수 : 답글 페이지에 el 태그 값 호출
		List<trackinfoDTO> trackInfo = detailpage_Service.musicinfo(track_id);
		model.addAttribute("trackInfo",trackInfo);
		
		model.addAttribute("track_id", track_id);
		

		return "hjs_music_writeForm";
	}
	
	@RequestMapping("/modify")
	public String modify(
			@ModelAttribute("dto") HjsmusicDTO dto,
			@RequestParam(value = "track_id", required = true, defaultValue = "") String track_id,
			@ModelAttribute("dto2") HjscommentDTO dto2,
			@RequestParam(value = "comment_id", required = false) String comment_id,
			Model model,
			HttpServletRequest req
	) {
		
		int result = hjscommentDAO.updateDao(dto2);
		
		System.out.println("업데이트 결과 : "+ result);
		
		return "redirect:/music_info?track_id="+track_id;
	}
	
	
	@RequestMapping("/modifyForm")
	public String modifyForm(
			@ModelAttribute("dto") HjsmusicDTO dto,
			@RequestParam(value = "track_id", required = true, defaultValue = "") String track_id,
			@ModelAttribute("dto2") HjscommentDTO dto2,
			@RequestParam(value = "comment_id", required = false) String comment_id,
			Model model,
			HttpServletRequest req
			) {

		HjsmusicDTO dto1 = hjsmusicDAO.viewDao(track_id);
		model.addAttribute("dto",dto1);
		
		HjscommentDTO dto3 = hjscommentDAO.viewDao(comment_id);
		model.addAttribute("dto2",dto3);
		
		// 박정수 : 수정페이지에 trackInfo 값이 없어서 추가하였습니다
		List<trackinfoDTO> trackInfo = detailpage_Service.musicinfo(track_id);
		model.addAttribute("trackInfo",trackInfo);
		
		model.addAttribute("track_id", track_id);
		
		return "hjs_music_modifyForm";
	}
	
	@RequestMapping("/delete")
	public String delete(
			@ModelAttribute("dto") HjsmusicDTO dto,
			@RequestParam(value = "track_id", required = true, defaultValue = "") String track_id,
			@ModelAttribute("dto2") HjscommentDTO dto2,
			@RequestParam(value = "comment_id", required = false) String comment_id,
			Model model,
			HttpServletRequest req
			
			) {
		
		int result = hjscommentDAO.deleteDao(comment_id);
		System.out.println("삭제 개수 : "+ result);
		
		model.addAttribute("track_id", track_id);
		
		return "redirect:/music_info?track_id="+track_id;
	}
	
	
	@RequestMapping("/hjs_music_genre")
	public String genrechoice(
			Model model,
			HttpServletRequest req,
			@ModelAttribute HjsmusicDTO musicDto
			) {
		long before = System.currentTimeMillis();
		// 웹 페이지의 전달 내용을 받아옴
		String preference = req.getParameter("preference"); // 곡의 장르 값을 가져옴
		System.out.println(preference);
		
		// DTO에 곡의 장르 값을 설정
		musicDto.setGenre(preference); 
		
		List list = hjsmusicDAO.testIf(musicDto);
		model.addAttribute("list", list);
		
		System.out.println("걸린시간: "+(System.currentTimeMillis() - before));
		
		return "hjs_music_genre";
	}
	
}