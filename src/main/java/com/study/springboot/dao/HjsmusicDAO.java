package com.study.springboot.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.study.springboot.dto.HjsmusicDTO;

import jakarta.annotation.PostConstruct;

@Mapper
public interface HjsmusicDAO {

	public abstract List<HjsmusicDTO> listDao(HjsmusicDTO musicDto);
	public abstract List<HjsmusicDTO> listDao2(HjsmusicDTO musicDto2);
	
	public abstract int writeDao(HjsmusicDTO musicDto);
	public abstract int writeDao2(HjsmusicDTO musicDto2);
	abstract HjsmusicDTO viewDao(String track_id);
	abstract int deleteDao(String track_id);
	int deleteadminDao(String track_id);
	abstract int updateDao(HjsmusicDTO musicDto);
	// 업데이트 테스트
	// 검색기능을 만들때 필요할 수도 있어서 일단 남겨둡니다. 
	List testIf(HjsmusicDTO musicDto);
//	List testForeach(HjsmusicDTO musicDto);
	
	int totalCount();
	List<HjsmusicDTO> selectHjsmusicDTO(HjsmusicDTO musicDto);
	
}	

	
