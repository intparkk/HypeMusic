package com.study.springboot.service;

import com.study.springboot.dao.lju_music4uDAO;
import com.study.springboot.dto.lju_music4uDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class lju_music4uService {

	@Autowired
    private final lju_music4uDAO musicDAO;

    public lju_music4uService(lju_music4uDAO musicDAO) {
        this.musicDAO = musicDAO;
    }

    public List<lju_music4uDTO> musiclist() {
    	return musicDAO.good_fast_id();
    }
    public List<lju_music4uDTO> good_fast_id() {
    	return musicDAO.good_fast_id();
    }
    public List<lju_music4uDTO> bad_slow_id() {
        return musicDAO.bad_slow_id();
    }
    public List<lju_music4uDTO> genre() {
    	return musicDAO.genre();
    }
    public List<lju_music4uDTO> runresult() {
    	return musicDAO.runresult();
    }
    public List<lju_music4uDTO> endRunresult() {
    	return musicDAO.endRunresult();
    }
    public List<lju_music4uDTO> updateRunresult() {
    	return musicDAO.updateRunresult();
    }
    public List<lju_music4uDTO> checkIfIdExists() {
    	return musicDAO.checkIfIdExists();
    }

    public void updateRunresultByTrackId(int trackId) {
        // 데이터베이스 업데이트를 수행하는 로직을 작성합니다.
        int runresult = 1; // 예시로 runresult 값을 1로 설정했습니다.
        musicDAO.updateRunresult(trackId, runresult);
    }

	public int icheckIfIdExists() {
		// TODO Auto-generated method stub
		return 0;
	}


}