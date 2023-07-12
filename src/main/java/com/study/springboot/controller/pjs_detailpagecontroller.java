package com.study.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.pjs_detailpage_service;

@Controller
public class pjs_detailpagecontroller
{
	private final pjs_detailpage_service detailpageService;
	
	@Autowired
	public pjs_detailpagecontroller(pjs_detailpage_service detailpageService)
	{
		this.detailpageService = detailpageService;
	}
	
	// 트랙 상세페이지 
    @GetMapping("/musicinfo/{trackId}")
    public String getMusicInfo(@PathVariable int trackId, Model model) {
        List<trackinfoDTO> trackInfo = detailpageService.musicinfo(trackId);
        
        model.addAttribute("trackInfo", trackInfo);
        System.out.println("음악 상세페이지 진입");
        return "/pjs_musicinfo";
    }
    
    // 아티스트 상세페이지
    @GetMapping("/artistinfo/{artistId}")
    public String getArtistInfo(@PathVariable int artistId, Model model) {
        List<trackinfoDTO> artistInfo = detailpageService.artistinfo(artistId);
        List<trackinfoDTO> relativeArtistInfo = detailpageService.relativeartist(null);
        
        model.addAttribute("artistInfo", artistInfo);
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
