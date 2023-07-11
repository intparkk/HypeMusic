package com.study.springboot.service;

import java.util.Map;

import com.study.springboot.dto.MyPlaylistDTO;

public interface PlaylistService {
	
	int createNewPlaylist(MyPlaylistDTO myPlaylistDTO);
}
