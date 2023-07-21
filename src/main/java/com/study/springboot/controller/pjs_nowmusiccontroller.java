package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.pjs_nowmusicservice;


@Controller
public class pjs_nowmusiccontroller
{
	@Autowired
	private pjs_nowmusicservice nowmusicService;
	
	@RequestMapping("/nowmusic")
	public String nowmusic(Model model)	
	{
        List<trackinfoDTO> nowTracks = nowmusicService.getnowmusictracks();
        
        model.addAttribute("nowTracks",nowTracks);        
     
        System.out.println("최신음악 페이지 진입");
        
		return "/pjs_nowmusic";		
	}

}
