package com.study.springboot.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.pjs_mainpageDAO;
import com.study.springboot.dto.trackinfoDTO;

@Service
public class pjs_mainpage_service
{
	private final pjs_mainpageDAO pjs_mainpageDAO;
	
	@Autowired
	public pjs_mainpage_service(pjs_mainpageDAO pjs_mainpageDAO)
	{
		this.pjs_mainpageDAO = pjs_mainpageDAO;
	}
	
	// 최신곡 그리드
	public List<trackinfoDTO> getgridtracks()
	{
		List<trackinfoDTO> getGridTracks = pjs_mainpageDAO.getgridtracks();
		
		// 리스트를 랜덤하게 섞음
		Collections.shuffle(getGridTracks);
		
		return getGridTracks;
	}
	
	/*// 최신곡 장르별 그리드
	public List<trackinfoDTO> gettracksbygenre(String genre) {
	    List<trackinfoDTO> tracksByGenre = pjs_mainpageDAO.getgridtracks();
	    
	    // 해당하는 장르가 없을 시 널값 반환 
	    if (genre == "최신") {
	        return tracksByGenre;
	    }
	    
	    // genre를 기준으로 tracksByGenre 리스트에서 해당 장르에 해당하는 트랙들을 필터링하여 새로운 리스트로 반환합니다.
	    // 필터링된 결과를 새로운 리스트에 저장하고 반환합니다.
	    List<trackinfoDTO> filteredTracks = new ArrayList<>();
	    
	    for (trackinfoDTO track : tracksByGenre) {
	        if (track.getGenre().equals(genre)) {
	            filteredTracks.add(track);
	        }
	    }
	    
	    // 리스트를 랜덤하게 섞어줍니다.
	    Collections.shuffle(filteredTracks);
	    
	    return filteredTracks;
	}*/
	
	// 그리드 부분 랜덤 8곡
    public List<trackinfoDTO> getRandomTracksByGenre(String genre) {
        return pjs_mainpageDAO.getRandomTracksByGenre(genre);
    }
	
	// 탑텐 차트
	public List<trackinfoDTO> gettop10tracks()
	{
		List<trackinfoDTO> getTop100Tracks = pjs_mainpageDAO.gettop10tracks();
		
		return getTop100Tracks;
	}
	
	// 하단쪽 아티스트
	public List<trackinfoDTO> getrandomartists() {
	    List<trackinfoDTO> getRandomArtists = pjs_mainpageDAO.getrandomartists();

	    List<trackinfoDTO> filteredArtists = new ArrayList<>();
	    for (trackinfoDTO artist : getRandomArtists) {
	        if (!"https://cdnimg.melon.co.kr".equals(artist.getArtist_img())) {
	            filteredArtists.add(artist);
	        }
	    }

	    return filteredArtists;
	}

	


}
