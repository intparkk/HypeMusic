package com.study.springboot.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.pjs_nowmusicservice;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class pjs_nowmusiccontroller
{
	@Autowired
	private pjs_nowmusicservice nowmusicService;
	
	@RequestMapping("/nowmusic")
	public String nowMusic(Model model,HttpServletRequest req)
	{
		String selectYear = req.getParameter("yearButton");
		
		// 최초진입시 2023년 곡들만 표시
		if(selectYear == null)
		{
			List<trackinfoDTO> nowTracks = nowmusicService.getyearmusictracks("2023");
			model.addAttribute("nowTracks",nowTracks);
		}
		else
		{
			List<trackinfoDTO> nowTracks = nowmusicService.getyearmusictracks(selectYear);
			model.addAttribute("nowTracks",nowTracks);
		}
		
		return "pjs_nowmusic";
	}	
	
}
