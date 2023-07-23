package com.study.springboot.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dto.UserDTO;
import com.study.springboot.dto.trackinfoDTO;
import com.study.springboot.service.UserService;
import com.study.springboot.service.pjs_mainpage_service;

import jakarta.servlet.http.HttpSession;

@Controller
public class pjs_mainpagecontroller
{
	private final pjs_mainpage_service mainpage_service;
	
	@Autowired
	public pjs_mainpagecontroller(pjs_mainpage_service mainpage_service)
	{
		this.mainpage_service = mainpage_service;
	}
	@Autowired
	UserService userService;
	
	
	@RequestMapping("/Mainpage")
	public String mainpage(Model model,HttpSession session) {
	    List<trackinfoDTO> getTop10Tracks = mainpage_service.gettop10tracks();
	    List<trackinfoDTO> getRandomArtists = mainpage_service.getrandomartists();
	    
	    UserDTO now_user = (UserDTO) session.getAttribute("userInfo");
	    
	    model.addAttribute("getTop10Tracks", getTop10Tracks);
	    model.addAttribute("getRandomArtists", getRandomArtists);
	    
	    System.out.println("[/] UserDTO : " + now_user);
	    
	    return "/Mainpage";
	}	

	// 그리드 선택 컨트롤러
    @PostMapping("/getRandomTracks")
    @ResponseBody
    public List<trackinfoDTO> getRandomTracks(@RequestBody Map<String, String> requestBody,Model model) {
        String genre = requestBody.get("genre");
        //System.out.println("선택된 장르 : "+genre);
        List<trackinfoDTO> randomTracks = mainpage_service.getRandomTracksByGenre(genre);
        
        // 향상된 for 문을 사용하여 "title" 값만 출력하는 코드
        /*for (trackinfoDTO track : randomTracks) {
            System.out.println(track.getTitle());
        }*/
        
        //model.addAttribute("randomTracks", randomTracks);
        
        return randomTracks;
    }


}
