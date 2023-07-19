package com.study.springboot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.HjsmusicDAO;
import com.study.springboot.dto.HjsmusicDTO;

@Service
public class HjsmusicserviceImpl implements HjsmusicService{

	@Autowired
	HjsmusicDAO hjsmusicDAO;
	
	@Override
	public Map list(HjsmusicDTO musicDto) {
		List<HjsmusicDTO> list = hjsmusicDAO.selectHjsmusicDTO(musicDto);
		int totalCount = hjsmusicDAO.totalCount();
		
		Map map = new HashMap();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

	
	
	@Override
	public List<HjsmusicDTO> listDao(HjsmusicDTO musicDto) {
		// List<TodoDTO> list = todoDAO.selectTodo(todoDTO);
		List<HjsmusicDTO> list = hjsmusicDAO.listDao(musicDto);
		return list;
	}

	@Override
	public int writeDao(HjsmusicDTO musicDto) {
		int result = hjsmusicDAO.writeDao(musicDto);
		return result;
	}

	@Override
	public HjsmusicDTO viewDao(String track_id) {
		HjsmusicDTO result = hjsmusicDAO.viewDao(track_id);
		return result;
	}

	@Override
	public int deleteDao(String track_id) {
		int result = hjsmusicDAO.deleteDao(track_id);
		return result;
	}

	@Override
	public int updateDao(HjsmusicDTO musicDto) {
		int result = hjsmusicDAO.updateDao(musicDto);
		return result;
	}

	@Override
	public List testIf(HjsmusicDTO musicDto) {
		List result = hjsmusicDAO.testIf(musicDto);
		return result;
	}



	@Override
	public int deleteadminDao(String track_id) {
		int result = hjsmusicDAO.deleteadminDao(track_id);
		return result;
	}
}
