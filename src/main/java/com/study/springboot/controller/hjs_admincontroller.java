package com.study.springboot.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.HjscommentDAO;
import com.study.springboot.dao.HjsmusicDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.HjscommentDTO;
import com.study.springboot.dto.HjsmusicDTO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.service.HjscommentService;
import com.study.springboot.service.HjsmusicService;
import com.study.springboot.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class hjs_admincontroller {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	UserService userService;
	
	@Autowired
	HjscommentDAO hjscommentDAO;
	
	@Autowired
	HjscommentService hjscommentService;
	
	@Autowired
	HjsmusicDAO hjsmusicDAO;
	
	@Autowired
	HjsmusicService hjsmusicService;
	
	
	@RequestMapping("/hjs_music_admin")
	public String admin(
			HttpServletRequest req,
			HttpServletResponse resp
			) {
		
		HttpSession session = req.getSession();
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		
		int user_id = userInfo.getUser_id();
		
			if (user_id != 1) {
			try {
				resp.sendRedirect("/Mainpage");
			} catch (IOException e) {
				e.printStackTrace();
				
			}

		}
		
		System.out.println("관리자페이지");
		return "hjs_main_adminpage";
	}
	
	
	// 관리자 음악정보 insert기능
	@RequestMapping("/hjs_music_admintest")
	public String admintest(
			HttpServletRequest req,
			HttpServletResponse resp
			) {
		HttpSession session = req.getSession();
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		
		//null이면 로그인 페이지로 유도 
		if(userInfo == null) {
			try {
				resp.sendRedirect("/login");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}


		return "hjs_music_admintest";
	}
	
	// 관리자 음악정보 insert기능 
	@RequestMapping("/hjs_music_admininsert")
	public String admintest(
			HjsmusicDTO musicDto2,
			Model model,
			HttpServletRequest req,
			HttpServletResponse resp
			) {

		HttpSession session = req.getSession();
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		
		//null이면 로그인 페이지로 유도 
		if(userInfo == null) {
			try {
				resp.sendRedirect("/login");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		
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
	
	// 관리자 음악정보 insert후에 리스트 확인
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
	
	
	@RequestMapping("/admin_delete")
	public String admin_delete(
			@ModelAttribute("dto") HjsmusicDTO dto,
			@RequestParam(value = "track_id", required = true, defaultValue = "") String track_id
			) {
		System.out.println(track_id);
		int result = hjsmusicDAO.deleteadminDao(track_id);
		System.out.println("삭제 개수 : "+ result);
		
		return "redirect:/hjs_music_viewtest";
	}
	
	
	@RequestMapping("/hjs_music_userlist")
	public String userlist(
			UserDTO userDTO,
			Model model,
			HttpServletRequest req,
			HttpServletResponse resp
			) {
		
		HttpSession session = req.getSession();
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		
		//null이면 로그인 페이지로 유도 
		if(userInfo == null) {
			try {
				resp.sendRedirect("/login");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		UserDTO userD = userDTO;
		
		System.out.println("userDTO: "+userDTO);
		List<UserDTO> list = userDAO.listDao(userDTO);
		model.addAttribute("list",list);
		
		return "hjs_music_userlist";
	}
	
	
	@RequestMapping("/hjs_music_commentlist")
	public String commentlist(
			HjscommentDTO hjscommentDTO,
			Model model,
			HttpServletRequest req,
			HttpServletResponse resp
			) {
		
		HttpSession session = req.getSession();
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		
		//null이면 로그인 페이지로 유도 
		if(userInfo == null) {
			try {
				resp.sendRedirect("/login");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		HjscommentDTO commentDTO = hjscommentDTO;
		
		System.out.println("hjscommentDTO : "+ hjscommentDTO);
		List<HjscommentDTO> list = hjscommentDAO.listDao2(hjscommentDTO);
		model.addAttribute("list",list);
		
		return "hjs_music_commentlist";
	}
	
}
