package com.study.springboot.service;

import java.util.List;
import java.util.Map;

import com.study.springboot.dto.MyPlaylistDTO;

public interface PlaylistService {
	
	int createNewPlaylist(MyPlaylistDTO myPlaylistDTO);
	
	List<MyPlaylistDTO> loadPlaylist(MyPlaylistDTO myPlaylistDTO);
}
 