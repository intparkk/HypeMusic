package com.study.springboot.controller;
import java.util.List;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.Date;
import java.util.Random;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dto.lju_music4uDTO;
import com.study.springboot.service.lju_music4uService;

import io.micrometer.common.util.StringUtils;

import java.text.SimpleDateFormat;
import jakarta.servlet.http.HttpServletRequest;
@Controller
public class lju_Controller {
	@Autowired
    private final lju_music4uService musicService;
    
    public lju_Controller(lju_music4uService musicService) {
        this.musicService = musicService;
    }
    
    @RequestMapping("/chart")
    public String showBarChart() {
    	return "music4u"; // 
    }
    
    @GetMapping("/music4u")
    public String showMusicList(HttpServletRequest request, Model model) {

    	List<lju_music4uDTO> limitedRunresult = musicService.runresult().stream()
    	        .limit(7)
    	        .collect(Collectors.toList());

    	model.addAttribute("limitedRunresult", limitedRunresult);
    	
    	String run=request.getParameter("run");
    	String concept=request.getParameter("concept");
    	
    	if ("0".equals(run)) {
    		concept = "밝고 활동적인";
    		List<lju_music4uDTO> musicList = musicService.good_fast_id();
    		model.addAttribute("musicList", musicList);
    		model.addAttribute("concept", concept);
		}
    	if ("1".equals(run)) {
    		concept = "우울하고 정적인";
    		List<lju_music4uDTO> musicList = musicService.bad_slow_id();
    		model.addAttribute("musicList", musicList);
    		model.addAttribute("concept", concept);
    	}
    	else {
    		List<lju_music4uDTO> musicList = musicService.musiclist();
    		model.addAttribute("musicList", musicList);
    		concept = "밝고 활동적인";
    		model.addAttribute("concept", concept);
    	}
    	
    	

    	Date checkDate = new Date();
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yy-MM-dd");
    	String formattedDate = dateFormat.format(checkDate);
    	
    	model.addAttribute("date", formattedDate);
    	
        return "music4u";
    }

    
    @GetMapping("/music4u_attend")
    public String attend(@RequestParam("check") int check,HttpServletRequest request) {
        if (check ==1) {
        	List<lju_music4uDTO> runresult = musicService.checkIfIdExists();
        	int trackId =runresult.size()+1;
        	System.out.println(trackId);
        		musicService.updateRunresultByTrackId(trackId);
        	}
        else if(check==2) {
        	musicService.endRunresult();
        	return "Mainpage";
        }
    
    	return "redirect:music4u"; // 
    }

}
