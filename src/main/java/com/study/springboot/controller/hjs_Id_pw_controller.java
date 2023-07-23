package com.study.springboot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class hjs_Id_pw_controller {

	
	@Autowired
	UserDAO userDAO;
	
	@Autowired
	UserService userService;
	
	
	@RequestMapping("/hjs_find")
	public String find() {
		System.out.println("아이디찾기");
		return "hjs_music_findId";
	}
	
	
	// 아이디찾기 완료
	@RequestMapping("/hjs_find_id")
	public String find_id(
			@ModelAttribute UserDTO userDTO,
			HttpServletRequest request, 
			HttpServletResponse response,
			@RequestParam("email") String email,
			Model model
			
			) {
		
		UserDTO userDTO1 = userService.userEmail(userDTO);
		System.out.println(email);
		System.out.println(userDTO1);
		
		if(userDTO1 != null && email.equals(userDTO1.getEmail())){
			System.out.println(email);
			
			System.out.println(userDTO1.getId());
	//		model.addAttribute("id", userDTO1.getId());
			String mes = "당신의 id는"+ userDTO1.getId()+"입니다";
			model.addAttribute("message_1",mes);
			return "hjs_music_findId";
		}
		else {
			
			System.out.println("아이디찾기");
			model.addAttribute("message","이메일이 일치하지 않습니다.다시 입력해 주세요.");
			System.out.println("이메일이 일치하지 않습니다.다시 입력해 주세요.");
			return "/hjs_music_findId";
		}	

		
	}
	
	
}
