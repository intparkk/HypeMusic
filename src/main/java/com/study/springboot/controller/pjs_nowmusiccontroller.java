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


@Controller
public class pjs_nowmusiccontroller
{
	@Autowired
	private pjs_nowmusicservice nowmusicService;
	
	@RequestMapping("/nowmusic")
	public String nowMusic()
	{
		return "pjs_nowmusic";
	}
	
	@PostMapping("/getYearTracks")
	@ResponseBody
	public List<trackinfoDTO> nowmusic(@RequestBody Map<String, String> requestbody, Model model)	
	{
		String selectYear = requestbody.get("year");
		System.out.println("선택 년도 :" +selectYear);
		
        List<trackinfoDTO> nowTracks = nowmusicService.getyearmusictracks(selectYear);
        
        model.addAttribute("nowTracks",nowTracks);        
     
        
		return nowTracks;		
	}
	
}
