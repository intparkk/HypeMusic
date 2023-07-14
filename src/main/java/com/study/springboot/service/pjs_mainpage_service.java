package com.study.springboot.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.pjs_mainpageDAO;
import com.study.springboot.dto.trackinfoDTO;

@Service
public class pjs_mainpage_service
{
	private final pjs_mainpageDAO pjs_mainpageDAO;
	
	@Autowired
	public pjs_mainpage_service(pjs_mainpageDAO pjs_mainpageDAO)
	{
		this.pjs_mainpageDAO = pjs_mainpageDAO;
	}
	
	// 최신곡 그리드
	public List<trackinfoDTO> getgridtracks()
	{
		List<trackinfoDTO> getGridTracks = pjs_mainpageDAO.getgridtracks();
		
		// 리스트를 랜덤하게 섞음
		Collections.shuffle(getGridTracks);
		
		return getGridTracks;
	}
	
	// 탑텐 차트
	public List<trackinfoDTO> gettop10tracks()
	{
		List<trackinfoDTO> getTop100Tracks = pjs_mainpageDAO.gettop10tracks();
		
		return getTop100Tracks;
	}
	


}
