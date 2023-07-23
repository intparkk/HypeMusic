package com.study.springboot.service;

import java.util.List;
import java.util.Map;

import com.study.springboot.dto.HjsmusicDTO;


public interface HjsmusicService {

//	public abstract List<HjsmusicDTO> listDao();
	
	public abstract int writeDao(HjsmusicDTO musicDto);
	abstract HjsmusicDTO viewDao(String track_id);
	abstract int deleteDao(String track_id);
	int deleteadminDao(String track_id);
	
	abstract int updateDao(HjsmusicDTO musicDto);

	List<HjsmusicDTO> listDao(HjsmusicDTO musicDto);
	// 업데이트 테스트
	// 검색기능 만들때에 필요할 수도 있어서 남깁니다. 
	List testIf(HjsmusicDTO musicDto);
//	List testForeach(HjsmusicDTO musicDto);
	Map list(HjsmusicDTO musicDto);
	
	List<HjsmusicDTO> youtubeDao(String youtube_url);
}
