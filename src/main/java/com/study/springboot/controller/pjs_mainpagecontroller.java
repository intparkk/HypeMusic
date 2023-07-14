package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.pjs_mainpage_service;

@Controller
public class pjs_mainpagecontroller
{
	private final pjs_mainpage_service mainpage_service;
	
	@Autowired
	public pjs_mainpagecontroller(pjs_mainpage_service mainpage_service)
	{
		this.mainpage_service = mainpage_service;
	}
	
	@RequestMapping("/Mainpage")
	public String mainpage(Model model)
	{
		List<trackinfoDTO> getTop10Tracks = mainpage_service.gettop10tracks();
		List<trackinfoDTO> getGridTracks = mainpage_service.getgridtracks();
		
		model.addAttribute("getTop10Tracks",getTop10Tracks);
		model.addAttribute("getGridTracks",getGridTracks);
		
		return "/Mainpage";
	}

}
