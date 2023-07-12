package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.pjs_top100_service;


@Controller
public class pjs_top100controller
{
	@Autowired
	private pjs_top100_service top100_service;
	
	@RequestMapping("/pjs_top100")
	public String top100(Model model)	
	{
        List<trackinfoDTO> top100_tracks = top100_service.getTop100Tracks();
        
        model.addAttribute("top100_tracks",top100_tracks);
        
        /*for (top100DTO track : top100_tracks) {
            System.out.println(track.getAlbum_name());
        }*/
        
        System.out.println("Top100 페이지 진입");
		return "/pjs_top100";		
	}

}
