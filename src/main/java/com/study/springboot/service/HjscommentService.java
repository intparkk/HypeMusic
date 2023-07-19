package com.study.springboot.service;

import java.util.List;

import com.study.springboot.dto.HjscommentDTO;

public interface HjscommentService {
	int writeDao(HjscommentDTO dto);
	int deleteDao(String comment_id);
	int updateDao(HjscommentDTO dto2);
	List<HjscommentDTO> listDao(String track_id);
	List<HjscommentDTO> listDao2(HjscommentDTO hjscommentDTO);
	HjscommentDTO viewDao(String comment_id);
}
