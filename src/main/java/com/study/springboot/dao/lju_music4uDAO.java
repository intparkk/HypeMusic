package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.dto.lju_music4uDTO;

@Mapper
public interface lju_music4uDAO {
	List<lju_music4uDTO> musiclist();
	List<lju_music4uDTO> good_fast_id();
	List<lju_music4uDTO> bad_slow_id();
	List<lju_music4uDTO> genre();
	List<lju_music4uDTO> runresult();
	List<lju_music4uDTO> endRunresult();
	List<lju_music4uDTO> updateRunresult();
	List<lju_music4uDTO> checkIfIdExists();
	void updateRunresult(@Param("track_Id") int trackId, @Param("runresult") int runresult);
}

