package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.MyPlaylistDTO;

@Mapper
public interface PlaylistDAO {
	
	int createNewPlaylist(MyPlaylistDTO myPlaylistDTO);
	
	String selectPlaylistName(MyPlaylistDTO myPlaylistDTO);
	
	List<MyPlaylistDTO> loadPlaylist(MyPlaylistDTO myPlaylistDTO);
}
 