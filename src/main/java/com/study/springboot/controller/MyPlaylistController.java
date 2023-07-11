package com.study.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.PlaylistDAO;
import com.study.springboot.dto.MyPlaylistDTO;
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

		
		System.out.println("/createNewPlaylist 접근");
		// 새 재생목록 생성 (Mapper 에서 Insert한 행의 갯수가 아닌 재생목록ID를 반환
		int playlist_id = playlistService.createNewPlaylist(myPlaylistDTO);
		System.out.println("int playlist_id :" + playlist_id);
		
		// 재생목록DTO에 재생목록ID, 재생목록 이름 설정
		myPlaylistDTO.setPlayList_id(myPlaylistDTO.getPlayList_id());
		myPlaylistDTO.setPlayList_name(playlistDAO.selectPlaylistName(myPlaylistDTO));

		System.out.println("myPlaylistDTO : " + myPlaylistDTO);
		
		// jsp에 모델로 전달
		model.addAttribute("playlist", myPlaylistDTO);
//		if(countList == 1) {
//			System.out.println("[/createNewPlaylist] count : " + countList);
//			
//		} else {
//			System.out.println("[/createNewPlaylist] count : " + countList + "실패");
//		}
		
		return myPlaylistDTO;
	}
	
	

	
}
