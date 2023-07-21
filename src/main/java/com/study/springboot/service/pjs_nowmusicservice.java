package com.study.springboot.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.pjs_nowmusicDAO;
import com.study.springboot.dto.trackinfoDTO;

@Service
public class pjs_nowmusicservice
{
	private pjs_nowmusicDAO pjs_nowmusicDAO;
	
	@Autowired
	public pjs_nowmusicservice(pjs_nowmusicDAO pjs_nowmusicDAO)
	{
		this.pjs_nowmusicDAO = pjs_nowmusicDAO;
	}
	
	// 최신음악 파트
	public List<trackinfoDTO> getnowmusictracks() {
	    List<trackinfoDTO> uniqueTracks = pjs_nowmusicDAO.getnowmusictracks();

	    Collections.shuffle(uniqueTracks);
	    
	    return uniqueTracks;
	}
}
