package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.pjs_search_service;


@Controller
public class pjs_searchcontroller
{
	private final pjs_search_service search_service;
	
	@Autowired
	public pjs_searchcontroller(pjs_search_service search_service)
	{
		this.search_service = search_service;
	}

    @GetMapping("/search/{keyword}")
    public String search(@PathVariable String keyword, Model model) 
    {   
    	// 키워드 저장용
    	String Keyword = keyword;
    	model.addAttribute("keyword",Keyword);
    	
    	List<trackinfoDTO> searchbytrack = search_service.searchbytrack(Keyword);
    	List<trackinfoDTO> searchbyartist = search_service.searchbyartist(Keyword);
    	
    	model.addAttribute("searchbytrack",searchbytrack);
    	model.addAttribute("searchbyartist",searchbyartist);
    	
    	System.out.println("검색 페이지 진입");
    	return "/pjs_search";
    }

}
