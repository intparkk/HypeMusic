package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.pjs_search_service;

/**
 * 
 * @author 박정수
 * @apiNote 서치 관련 컨트롤러 입니다
 */

@Controller
public class pjs_searchcontroller
{
	private final pjs_search_service search_service;
	
	@Autowired
	public pjs_searchcontroller(pjs_search_service search_service)
	{
		this.search_service = search_service;
	}

	// 서치 컨트롤러
    @GetMapping("/search/{keyword}")
    public String search(@PathVariable String keyword, Model model) 
    {   
    	// 키워드 저장용
    	String Keyword = keyword;
    	//model.addAttribute("keyword",Keyword);

    	// 서치가 한번 들어가면 3개의 쿼리문이 실행됩니다.
    	// 각각 트랙정보,아티스트정보,앨범정보 입니다.
    	List<trackinfoDTO> search_all = search_service.searchresultbind(Keyword);
    	
    	model.addAttribute("search_all",search_all);
    	
    	System.out.println("검색 페이지 진입");
    	return "/pjs_search";
    }

}
