package com.study.springboot.service;

import java.util.List;

import com.study.springboot.dto.HjsmusicDTO;

// HjsmusicDAO와 똑같지만 인터페이스를 하나더 만들었습니다. 
// HjsmusicDAO를 추상메소드로 인식해서 구현클래스가 필요하다고 하여
// 만들었는데, 선생님께 여쭈어 보고 수정할 수도 있습니다. 
public interface HjsmusicService {

//	public abstract List<HjsmusicDTO> listDao();
	
	public abstract int writeDao(HjsmusicDTO musicDto);
	abstract HjsmusicDTO viewDao(String track_id);
	abstract int deleteDao(String track_id);
	abstract int updateDao(HjsmusicDTO musicDto);

	List<HjsmusicDTO> listDao(HjsmusicDTO musicDto);
	
	// 검색기능 만들때에 필요할 수도 있어서 남깁니다. 
//	List testIf(HjsmusicDTO musicDto);
//	List testForeach(HjsmusicDTO musicDto);
}
