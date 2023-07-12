package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.study.springboot.dto.HjscommentDTO;

@Mapper
public interface HjscommentDAO {

	int writeDao(HjscommentDTO dto);
	List<HjscommentDTO> listDao(String track_id);
	int deleteDao(String comment_id);
	int updateDao(HjscommentDTO dto2);
	HjscommentDTO viewDao(String comment_id);
}
