package com.study.springboot.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.PlaylistDAO;
import com.study.springboot.dto.MyPlaylistDTO;

@Service
public class PlaylistServiceImpl implements PlaylistService{
	
	@Autowired
	PlaylistDAO playlistDAO;
	
	@Override
	public int createNewPlaylist(MyPlaylistDTO myPlaylistDTO) {
		
		return playlistDAO.createNewPlaylist(myPlaylistDTO);
	}


}
 