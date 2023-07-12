package com.study.springboot.controller;

import com.study.springboot.dto.newsDTO;
import com.study.springboot.service.pjs_news_service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 
 * @author 박정수
 * @apiNote 스타메거진 페이지 컨트롤러 입니다
 * 			더 보기 방식으로 10개씩 기사가 나옵니다
 * 			Ajax 방식을 사용했고 GetMapping 사용하였습니다			
 * 
 */
@Controller
public class pjs_newscontroller {

    private final pjs_news_service newsService;

    @Autowired
    public pjs_newscontroller(pjs_news_service newsService) {
        this.newsService = newsService;
    }

    // 스타메거진 페이지
    @RequestMapping("/pjs_news")
    public String News(Model model) {
        List<newsDTO> newsList = newsService.getNewsList();
        
        // 전체 뉴스리스트 모델에 담기
        model.addAttribute("newsList", newsList);

        System.out.println("스타매거진 페이지 진입");        
        return "/pjs_news";
    }
    
    // 10개씩 보여주기용
    @GetMapping("/api/news")
    public @ResponseBody ResponseEntity<List<newsDTO>> getNewsByPage(@RequestParam("page") int page) {
        List<newsDTO> newsList = newsService.getNewsByPage(page);
        System.out.println("더 보기 실행");
        return new ResponseEntity<>(newsList, HttpStatus.OK);
    }

}
