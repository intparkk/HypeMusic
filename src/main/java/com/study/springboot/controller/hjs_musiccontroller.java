package com.study.springboot.controller;

import java.io.FileInputStream;
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
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.study.springboot.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class hjs_musiccontroller {


	@Autowired(required=false)
	private HjsmusicDAO hjsmusicDAO;
	
	@Autowired
	HjscommentDAO hjscommentDAO;
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDAO userDAO;
		
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
		// 박정수 경로 오류날 시 제꺼 주석처리 후 사용 부탁드리겠습니다
		// String filePath = "C:\\Users\\h\\Desktop\\HypeMusic_230712\\src\\main\\resources\\metadata\\MelonCrawling_2020.1~2023.4.xlsx";
		 
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
	                    
	                    // 0.88%의 곡이 DB에 담기지 않네요. 분명히 처리하는 방법이
	                    // 있겠지만, 지금 당장은 이 정도만 담아둘께요. (추후 수정 예정)
	                    // 23 ÷ 2612 * 100 = 0.8805...
	                    // 그래도 2589 ÷ 2612 * 100 = 99.1194 
	                    // 99.12%의 곡을 담았으니 성공입니다. ^^
	                    
	                    // 에러가 나는 데이터
	                    // 날짜형식 오류,long 타입이 없는데 long 타입오류가 납니다.
	                    // track_id2 = 53969.0
	                    // track_id2 = 31856628.0
	                    // track_id2 = 31470006.0
	                    // track_id2 = 46957.0
	                    // track_id2 = 71581.0
	                    // track_id2 = 37571.0
	                    // track_id2 = 70602.0
	                    // track_id2 = 33115806.0
	                    // track_id2 = 91306.0
	                    // track_id2 = 33133798.0
	                    // track_id2 = 33129886.0
	                    // track_id2 = 33552228.0
	                    // track_id2 = 34331508.0
	                    // track_id2 = 34144141.0
	                    // track_id2 = 34366007.0
	                    // track_id2 = 34366011.0
	                    // track_id2 = 34431722.0
	                    // track_id2 = 34699668.0
	                    // track_id2 = 35849186.0
	                    // track_id2 = 35913593.0
	                    // track_id2 = 35535827.0
	                    // track_id2 = 35825907.0
	                    // track_id2 = 35825906.0
	                    if ( track_id2 == 53969.0 
	                    		|| Double.compare(track_id2, 3.1856628E7) == 0
	                    		|| Double.compare(track_id2, 3.1470006E7) == 0
	                    		|| track_id2 == 46957.0
	                    		|| track_id2 == 71581.0 
	                    		|| track_id2 == 37571.0
	                    		|| track_id2 == 70602.0 
	                    		|| Double.compare(track_id2, 3.3115806E7) == 0
	                    		|| track_id2 == 91306.0
	                    		|| Double.compare(track_id2, 3.3133798E7) == 0
	                    		|| Double.compare(track_id2, 3.3129886E7) == 0
	                    		|| Double.compare(track_id2, 3.3552228E7) == 0
	                    		|| Double.compare(track_id2, 3.4331508E7) == 0
	                    		|| Double.compare(track_id2, 3.4144141E7) == 0
	                    		|| Double.compare(track_id2, 3.4366007E7) == 0
	                    		|| Double.compare(track_id2, 3.4366011E7) == 0
	                    		|| Double.compare(track_id2, 3.4431722E7) == 0
	                    		|| Double.compare(track_id2, 3.4699668E7) == 0
	                    		|| Double.compare(track_id2, 3.5849186E7) == 0
	                    		|| Double.compare(track_id2, 3.5913593E7) == 0
	                    		|| Double.compare(track_id2, 3.5535827E7) == 0
	                    		|| Double.compare(track_id2, 3.5825907E7) == 0
	                    		|| Double.compare(track_id2, 3.5825906E7) == 0
	                       ) {
	                    	continue;
	                    }
	                    
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

	                    // release_date를 String으로 받았는데, 만약 String이 되지 않을 때에는 
	                    // java 날짜형식으로 변환한 다음, sql날짜 형식으로 변환해서 담을 수도 있습니다. 
	                    
	                    // Cell cell8 = row.getCell(5);
	                    // double release_date2 = cell8.getNumericCellValue();
	                    // java.util.Date utilDate = DateUtil.getJavaDate(release_date2);
	                    // java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

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
//	                    musicDto.setRelease_date(sqlDate);
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
			HjsmusicDTO musicDto
			) {
		
		// HjsmusicDTO 객체를 적절하게 초기화하고 값을 설정해야 합니다.
		HjsmusicDTO dto = musicDto;
		
		List<HjsmusicDTO> list = hjsmusicDAO.listDao(musicDto);
		model.addAttribute("list",list);
		System.out.println(list);
		return "hjs_music_top100";
	}
	
//	원본
//	@RequestMapping("/music_info")
//	public String music_info(
//			Model model,
//			@RequestParam("track_id") String track_id,
//			@ModelAttribute HjscommentDTO dto2,
//			HttpServletRequest req
//			) {
//		HjsmusicDTO dto = hjsmusicDAO.viewDao(track_id);
//		model.addAttribute("dto",dto);
//		List<HjscommentDTO> list = hjscommentDAO.listDao(track_id);
//		model.addAttribute("list",list);
//		
//		System.out.println(list);
//		return "hjs_music_info";
//	}
//	
	@RequestMapping("/music_info")
	public String music_info(
			UserDTO userDTO,
			@RequestParam(value="user_id", required=true, defaultValue="") 
			String user_id,
			Model model,
			@RequestParam("track_id") String track_id,
			@ModelAttribute HjscommentDTO dto2,
			HttpServletRequest req
			) {
		
		Map map = userService.login(userDTO);
		UserDTO userInfo = (UserDTO) map.get("dto");
		int countAcc = (int) map.get("count");
		
		System.out.println("[/doLogin]count : " + countAcc);	
		System.out.println("[/doLogin]userInfo : " + userInfo);	
		
		if(countAcc == 1) {
			// 계정 있음
			HttpSession session = req.getSession();
			session.setAttribute("isLoggedIn", "ok");
			
			if(userInfo != null) {
				
				session.setAttribute("userInfo", userInfo);
				System.out.println("[/doLogin]로그인 성공 id : " + userDTO.getId());
				System.out.println("[/doLogin]userInfo : " + userInfo);
				
				return "redirect:/test-main";
			}
		} else {
				System.out.println("로그인 실패");
				// 계정 없음
				String errMsg = "계정 정보가 일치하지 않습니다.";
				model.addAttribute("errMsg", errMsg);
			  }
		
		System.out.println(user_id);
		HjsmusicDTO dto = hjsmusicDAO.viewDao(track_id);
		model.addAttribute("dto",dto);
		List<HjscommentDTO> list = hjscommentDAO.listDao(track_id);
		model.addAttribute("list",list);
		
		System.out.println(list);
		return "hjs_music_info";
	}
	
	
	// 원본
	/* DB에 댓글을 저장하는 컨트롤러 */
//	@RequestMapping("/write_comment")
//	public String write2(
//			@ModelAttribute HjsmusicDTO dto,
//			@RequestParam(value="track_id", required=true, defaultValue="") 
//			String track_id,
//			@ModelAttribute HjscommentDTO dto2,
//			Model model,
//			HttpServletRequest req
//			) {
//		
//		model.addAttribute("track_id", track_id);
//		System.out.println(track_id);
//		
//		String comment_id = dto2.getComment_id();
//		String member_id = dto2.getMember_id();
//		String comment_content = dto2.getComment_content();
//		String parent_id = dto2.getParent_id();
//		
//		System.out.println("comment_id : "+ comment_id);
//		System.out.println("member_id : "+ member_id);
//		System.out.println("comment_content: "+ comment_content);
//		System.out.println("parent_id : "+ parent_id);
//		
//		int result = hjscommentDAO.writeDao(dto2);
//		
//		System.out.println("writeDao result : "+ result);
//		
//		
//		return "redirect:/music_info?track_id="+track_id;
//		
//	}
//
	
	@RequestMapping("/write_comment")
	public String write2(
			UserDTO userDTO,
			
			@RequestParam(value="track_id", required=true, defaultValue="") 
			String track_id,
			@ModelAttribute HjscommentDTO dto2,
			Model model,
			HttpServletRequest req
			) {
		
		model.addAttribute("track_id", track_id);
		System.out.println(track_id);
		
		
		String comment_id = dto2.getComment_id();
		String comment_content = dto2.getComment_content();
		String parent_id = dto2.getParent_id();
		
		System.out.println("comment_id : "+ comment_id);
	//	System.out.println("user_id : "+ user_id);
		System.out.println("comment_content: "+ comment_content);
		System.out.println("parent_id : "+ parent_id);
		
		int result = hjscommentDAO.writeDao(dto2);
		
	//	System.out.println(user_id);
		System.out.println("writeDao result : "+ result);
		
		
		return "redirect:/music_info?track_id="+track_id;
		
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
	
	
	/*
	 *장르 음악은 초기화면 로딩 속도가 느립니다. 
	 *다른 페이지는 DB에서 100개의 데이터만 가져오는데, 
	 *장르 음악은 모든 곡을 로딩해오기 때문인것 같습니다. 
	 * 
	 */
	
	@RequestMapping("/hjs_music_genre")
	public String genrechoice(
			Model model,
			HttpServletRequest req,
			@ModelAttribute HjsmusicDTO musicDto
			) {
		
		// 웹 페이지의 전달 내용을 받아옴
		String preference = req.getParameter("preference"); // 곡의 장르 값을 가져옴
		System.out.println(preference);
		
		// DTO에 곡의 장르 값을 설정
		musicDto.setGenre(preference); 
		
		List list = hjsmusicDAO.testIf(musicDto);
		model.addAttribute("list", list);
		
		return "hjs_music_genre";
	}
	
	@RequestMapping("/hjs_music_admintest")
	public String admintest() {
		return "hjs_music_admintest";
	}
	
	
	@RequestMapping("/hjs_music_admininsert")
	public String admintest(
			HjsmusicDTO musicDto2,
			Model model,
			HttpServletRequest req
			) {

		 String track_id = musicDto2.getTrack_id(); 
		 String artist_id = musicDto2.getArtist_id(); 
		 String album_img = musicDto2.getAlbum_img();
		 String title = musicDto2.getTitle(); 
		 String artist = musicDto2.getArtist(); 
		 String album_name = musicDto2.getAlbum_name();
		 int like_count = musicDto2.getLike_count(); 
		 String genre = musicDto2.getGenre(); 
		 String release_date = musicDto2.getRelease_date();
		 String lyrics = musicDto2.getLyrics();
		
		 System.out.println("track_id : "+ track_id);
		 
		 int result = hjsmusicDAO.writeDao2(musicDto2);
		
		 System.out.println("writeDao2 result : "+ result);
		 
		return "hjs_music_admintest";
	}
	
	@RequestMapping("/hjs_music_viewtest")
	public String viewtest(
			HjsmusicDTO musicDto2,
			Model model,
			HttpServletRequest req
			
			) {
		HjsmusicDTO newmusic = musicDto2;
		
		List<HjsmusicDTO> list = hjsmusicDAO.listDao2(musicDto2);
		model.addAttribute("list", list);
		System.out.println(list);
		
		
		return "hjs_music_viewtest";
	}
		
	
}
