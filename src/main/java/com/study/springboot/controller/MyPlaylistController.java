package com.study.springboot.controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.study.springboot.dao.PlaylistDAO;
import com.study.springboot.dto.MyPlaylistDTO;
import com.study.springboot.dto.PlaylistDTO;
import com.study.springboot.dto.UpdatePlaylistNameDTO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.service.PlaylistService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * @author 이승찬
 * @apiNote 유저 재생목록 컨트롤러
 * 	
 * TODO DB에 저장된 재생목록 표시하기
 * 		재생목록에 곡 추가하기
 * 		재생목록 삭제, 이름 변경
 * 		재생목록 이미지?
 * 		재생목록 안에서 곡 삭제
 * 		
 * */
@Controller
public class MyPlaylistController {

	@Autowired
	PlaylistService playlistService;
	
	@Autowired
	PlaylistDAO playlistDAO;
	
	// 재생목록에 담기
	@RequestMapping(value="/myPlaylist/addToPlaylist", method=RequestMethod.POST)
	@ResponseBody
	public PlaylistDTO addToPlaylist(
			// POST 방식으로 요청했기때문에 @RequestBody
			@RequestBody
			PlaylistDTO playlistDTO
			) {
		try {
			
//			System.out.println(playlistDTO);
			
			int insertedColumn = playlistService.insertTrackIntoPlaylist(playlistDTO);
//			System.out.println("[/addToPlaylist]insertedColumn : " + insertedColumn);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return playlistDTO;
	}
	
	// 내 재생목록 페이지
	@RequestMapping("/myPlaylist")
	public String myPlaylist(
			HttpServletRequest req,
			@ModelAttribute
			UserDTO userDTO,
			@ModelAttribute
			MyPlaylistDTO myPlaylistDTO
			) {
		HttpSession session = req.getSession();
	
		return "myPlaylist";
	}
	
	// 새 재생목록 생성
	@RequestMapping(value="/myPlaylist/createNewPlaylist", method=RequestMethod.POST)
	@ResponseBody
	public MyPlaylistDTO createNewPlayList(
			HttpServletRequest req,
			@ModelAttribute
			MyPlaylistDTO myPlaylistDTO,
			Model model
			) {
		
		HttpSession session = req.getSession();
		// 세션에서 유저 정보 불러오기
		UserDTO userDTO = (UserDTO) session.getAttribute("userInfo");
		
		// 유저ID 추출
		int user_id = userDTO.getUser_id();
		System.out.println("user id :" + user_id);
		
		// 재생목록DTO에 유저ID 설정
		myPlaylistDTO.setUser_id(user_id);

		// 새 재생목록 생성 (Mapper 에서 Insert한 행의 갯수가 아닌 재생목록ID를 반환
		int playlist_id = playlistService.createNewPlaylist(myPlaylistDTO);
		
		// 재생목록DTO에 재생목록ID, 재생목록 이름 설정
		myPlaylistDTO.setPlayList_id(myPlaylistDTO.getPlayList_id());
		myPlaylistDTO.setPlayList_name(playlistDAO.selectPlaylistName(myPlaylistDTO));

		
		// jsp에 모델로 전달
		model.addAttribute("playlist", myPlaylistDTO);
		
		return myPlaylistDTO;
	}
	
	// 재생목록 불러오기
	@RequestMapping("/myPlaylist/loadPlaylist")
	@ResponseBody
	public String loadPlaylist(
			HttpServletRequest req,
			@ModelAttribute
			MyPlaylistDTO myPlaylistDTO,
			Model model
			) {
		
		HttpSession session = req.getSession();
		// 세션에서 유저 정보 불러오기
		UserDTO userDTO = (UserDTO) session.getAttribute("userInfo");
		
		// 유저ID 추출
		int user_id = userDTO.getUser_id();
		System.out.println("user id :" + user_id);
		// 재생목록DTO에 유저ID 설정
		myPlaylistDTO.setUser_id(user_id);
		
		// 재생목록 갯수
		int numberOfPlaylist = playlistDAO.countNumberOfPlaylist(myPlaylistDTO);
		System.out.println(numberOfPlaylist);
		model.addAttribute("numberOfPlaylist", numberOfPlaylist);
		
		// 유저 재생목록 불러오기 
		List<MyPlaylistDTO> playlist = playlistService.loadPlaylist(myPlaylistDTO);
		
		// JSON 으로 파싱
		String jsonPlaylist = parseToJson(playlist);
		
		return jsonPlaylist;
	}
	
	// Object 리스트를 JSON 문자열로 파싱하는 메소드
	private String parseToJson(
			List<MyPlaylistDTO> playlist
			) {
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		try {
			
			return objectMapper.writeValueAsString(playlist);
		} catch (Exception e) {
			e.printStackTrace();
			
			return null;
		}
	}
	
	// 개별 재생목록 접근
	@RequestMapping("/myPlaylist/playlist")
	public String loadPlaylistById(
			@RequestParam("playlist_id") int playlist_id,
			@ModelAttribute
			MyPlaylistDTO myPlaylistDTO,
			Model model
			) {

		myPlaylistDTO.setPlayList_id(playlist_id);
		String playlistName = playlistDAO.selectPlaylistName(myPlaylistDTO);
		int trackQuantity = playlistDAO.countTracksFromPlaylist(playlist_id);
		
//		if (trackQuantity == 0) {
//			String playlistImg = "/public/playlist_img.svg";	
//			model.addAttribute("playlistImg", playlistImg);
//		} else {
			String playlistImg = playlistDAO.selectPlaylistImg(playlist_id);
			model.addAttribute("playlistImg", playlistImg);
//		}
		
		
		model.addAttribute("playlist_id", playlist_id);
		model.addAttribute("playlistName", playlistName);
		model.addAttribute("trackQuantity", trackQuantity);
//		model.addAttribute("playlistImg", playlistImg);
		
		return "playlist";
	}
	
	// 재생목록 곡 불러오기
	@RequestMapping("/myPlaylist/playlist/loadPlaylistTracks")
	@ResponseBody
	public List<PlaylistDTO> loadPlaylistTracks(
			HttpServletRequest req,
			@RequestParam("playlist_id") int playlist_id,
			@ModelAttribute
			MyPlaylistDTO myPlaylistDTO,
			@ModelAttribute
			PlaylistDTO playlistDTO,
			Model model
			) {
		// 세션에서 유저 정보 불러오기
		HttpSession session = req.getSession();
		UserDTO userDTO = (UserDTO) session.getAttribute("userInfo");
		
		System.out.println("playlist_id : " + playlist_id);
		playlistDTO.setPlaylist_id(playlist_id);
		
		List<PlaylistDTO> playlist = playlistService.loadPlaylistTracks(playlistDTO);
		System.out.println("[/loadTracks] List : " + playlist);
		
		return playlist;
	}
	
	// 재생목록 이름 변경
	@RequestMapping(value="/myPlaylist/playlist/updatePlaylistName", method=RequestMethod.PUT)
	@ResponseBody
	public String updatePlaylistName(
			@RequestBody 
			UpdatePlaylistNameDTO updatePlaylistNameDTO
			) {
		
	    int playlist_id = updatePlaylistNameDTO.getPlaylist_id();
	    String playlist_name = updatePlaylistNameDTO.getPlaylist_name();
	    
		System.out.println(updatePlaylistNameDTO);

	    System.out.println(playlist_id + playlist_name);
	    
	    int countUpdated = playlistService.updatePlaylistName(updatePlaylistNameDTO);
	    
	    String updatedName = updatePlaylistNameDTO.getPlaylist_name();
	    
	    return "";
	}
	
	// 재생목록 사진 업로드
	@RequestMapping(value="/myPlaylist/playlist/updatePlaylistImage", method=RequestMethod.POST)
	@ResponseBody
	public String updatePlaylistImage(
			@RequestPart(value="file", required=false) MultipartFile file,
			@RequestParam("playlist_id") int playlist_id,
			RedirectAttributes redirectAttributes
			) {
		if (!file.isEmpty()) {
	        try {
	            String filePath = "C:\\Users\\User\\Desktop\\HypeMusic\\src\\main\\resources\\static\\playlist_img";
	            String originalFileName = file.getOriginalFilename();
	            String fullFilePath = filePath + "\\" + originalFileName;

	            File destination = new File(fullFilePath);
	            file.transferTo(destination);
	            
//	            String binFilePath = "C:\\Users\\User\\Desktop\\HypeMusic\\bin\\main\\static\\playlist_img";
//	            String binOriginalFileName = file.getOriginalFilename();
//	            String binFullFilePath = binFilePath + "\\" + binOriginalFileName;
//	            
//	            File binDestination = new File(binFullFilePath);
//	            file.transferTo(binDestination);
	            
	            
	            // 이미지 주소 반환
	            String imageUrl = "/playlist_img/" + originalFileName;
	            ClassPathResource resource = new ClassPathResource(fullFilePath);
	            System.out.println(resource);

	            

	            MyPlaylistDTO myPlaylistDTO = new MyPlaylistDTO();
	            myPlaylistDTO.setPlayList_id(playlist_id);
	            myPlaylistDTO.setPlaylist_img(imageUrl);
	            playlistService.updatePlaylistImg(myPlaylistDTO);

	            redirectAttributes.addFlashAttribute("imageUrl", imageUrl);
	            return imageUrl;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
			
		
		 return "";
	}
	
	// 재생목록 삭제
	@RequestMapping(value="/myPlaylist/playlist/deletePlaylist", method=RequestMethod.DELETE)
	@ResponseBody
	public String deletePlaylist(
			@ModelAttribute
			PlaylistDTO playlistDTO
			) {
		System.out.println(playlistDTO);
		
		int deletedPlaylist = playlistService.deletePlaylist(playlistDTO);
		System.out.println(deletedPlaylist);
		
		return "";
	}
	
	
	// 재생목록에서 곡 삭제
	@RequestMapping(value="/myPlaylist/playlist/deleteTrack", method=RequestMethod.DELETE)
	@ResponseBody
	public String deleteTrackFromPlaylist(
			@ModelAttribute
			PlaylistDTO playlistDTO
			) {

			System.out.println(playlistDTO);
			
			int deletedTrack = playlistService.deleteTrackFromPlaylist(playlistDTO);
			System.out.println("deleted track : " + deletedTrack);
			
			
		return "";
		
	}
	
}
