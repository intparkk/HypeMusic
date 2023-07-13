package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.trackinfoDTO;

@Mapper
public interface pjs_detailpageDAO
{
	List<trackinfoDTO> musicinfo(int track_id);
	List<trackinfoDTO> artistinfo(int artist_id);
	List<trackinfoDTO> albuminfo(int album_id);
	List<trackinfoDTO> relativeartist(int album_id);
	
	public String artistNameById(int artist_id);
}
