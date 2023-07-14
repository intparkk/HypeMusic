package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.HjscommentDAO;
import com.study.springboot.dto.HjscommentDTO;

@Service
public class HjscommentServiceImpl implements HjscommentService{

	@Autowired
	HjscommentDAO hjscommentDAO;
	
	@Override
	public int deleteDao(String comment_id) {
		int result = hjscommentDAO.deleteDao(comment_id);
		return result;
	}

	@Override
	public int updateDao(HjscommentDTO dto2) {
		int result = hjscommentDAO.updateDao(dto2);
		return result;
	}

	@Override
	public HjscommentDTO viewDao(String comment_id) {
		HjscommentDTO result = hjscommentDAO.viewDao(comment_id);
		return result;
	}

	@Override
	public int writeDao(HjscommentDTO dto) {
		int result = hjscommentDAO.writeDao(dto);
		return result;
	}

	@Override
	public List<HjscommentDTO> listDao(String track_id) {
		List<HjscommentDTO> list = hjscommentDAO.listDao(track_id);
		return list;
	}

	// 업데이트 테스트

}
