package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dao.HjscommentDAO;
import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.HjscommentDTO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.service.HjscommentService;
import com.study.springboot.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
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
	
	@RequestMapping("/hjs_music_userlist")
	public String userlist(
			UserDTO userDTO,
			Model model,
			HttpServletRequest req
			) {
		
	//	HttpSession session = req.getSession();
	//	UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
	//	System.out.println("userInfo: "+userInfo);
		
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
			HttpServletRequest req
			) {
		
		HjscommentDTO commentDTO = hjscommentDTO;
		
		System.out.println("hjscommentDTO : "+ hjscommentDTO);
		List<HjscommentDTO> list = hjscommentDAO.listDao2(hjscommentDTO);
		model.addAttribute("list",list);
		
		return "hjs_music_commentlist";
	}
	
}
