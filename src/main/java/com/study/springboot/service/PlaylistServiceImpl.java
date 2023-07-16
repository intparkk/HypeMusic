package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.PlaylistDAO;
import com.study.springboot.dto.MyPlaylistDTO;
import com.study.springboot.dto.PlaylistDTO;

@Service
public class PlaylistServiceImpl implements PlaylistService{
	
	@Autowired
	PlaylistDAO playlistDAO;
	
	@Override
	public int createNewPlaylist(MyPlaylistDTO myPlaylistDTO) {
		
		return playlistDAO.createNewPlaylist(myPlaylistDTO);
	}

	@Override
	public List<MyPlaylistDTO> loadPlaylist(MyPlaylistDTO myPlaylistDTO) {

		return playlistDAO.loadPlaylist(myPlaylistDTO);
	}

	@Override
	public int insertTrackIntoPlaylist(PlaylistDTO playlistDTO) {
		
		return playlistDAO.insertTrackIntoPlaylist(playlistDTO);
	}

	@Override
	public List<PlaylistDTO> loadPlaylistTracks(PlaylistDTO playlistDTO) {
		
		return playlistDAO.loadPlaylistTracks(playlistDTO);
	}


}
 