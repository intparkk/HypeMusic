package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.study.springboot.dao.HjscommentDAO;
import com.study.springboot.dto.HjscommentDTO;
import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.HjscommentService;
import com.study.springboot.service.HjscommentServiceImpl;
import com.study.springboot.service.pjs_detailpage_service;

@Controller
public class pjs_detailpagecontroller
{
	// 생성자(진서님 포함)
	private final pjs_detailpage_service detailpageService;
	private final HjscommentServiceImpl commentService;
	
	@Autowired
	public pjs_detailpagecontroller(pjs_detailpage_service detailpageService, HjscommentServiceImpl commentService)
	{
		this.detailpageService = detailpageService;
		this.commentService = commentService;
	}
	
	// 트랙 상세페이지(진서님꺼와 합침) 
    @GetMapping("/music_info")
    public String getMusicInfo(@RequestParam("track_id") String trackId, Model model) {
    	
    	// 진서님 listDao 쓰기위해 String 형변환
    	//Integer track_id = trackId;
    	//String track_id_reply = track_id.toString();
        
    	// 진서님 listDao 호출
    	List<trackinfoDTO> trackInfo = detailpageService.musicinfo(trackId);
        List<HjscommentDTO> replyAll = commentService.listDao(trackId);
        
        model.addAttribute("trackInfo", trackInfo);
        model.addAttribute("list",replyAll);
        
        System.out.println("음악 상세페이지 진입");
        // 진서님 jsp 호출
        return "/hjs_music_info";
    }
    
    // 아티스트 상세페이지
    @GetMapping("/artistinfo/{artistId}")
    public String getArtistInfo(@PathVariable int artistId, Model model) {
    	
    	List<trackinfoDTO> artistInfo = detailpageService.artistinfo(artistId);
    	List<trackinfoDTO> relativeArtistInfo = detailpageService.relativeartist(artistId); 
      
        model.addAttribute("artistInfo", artistInfo);
        model.addAttribute("relativeArtistInfo",relativeArtistInfo);
        
        System.out.println("아티스트 상세페이지 진입");
        
        return "/pjs_artistinfo";
    }
    
    // 앨범 상세페이지
    @GetMapping("/albuminfo/{albumId}")
    public String getAlbumInfo(@PathVariable int albumId, Model model) {
        List<trackinfoDTO> albumInfo = detailpageService.albuminfo(albumId);
        
        model.addAttribute("albumInfo", albumInfo);
        System.out.println("앨범 상세페이지 진입");
        
        return "/pjs_albuminfo";
    }
    
}
