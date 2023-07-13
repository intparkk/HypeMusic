package com.study.springboot.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.pjs_detailpageDAO;
import com.study.springboot.dto.trackinfoDTO;

/**
 * 
 * @author 박정수
 * @apiNote 곡 상세페이지, 아티스트 상세페이지, 앨범 상세페이지를 처리하는 서비스 입니다
 * 			
 */

@Service
public class pjs_detailpage_service
{
	private final pjs_detailpageDAO detailpageDao;
	
	@Autowired
	public pjs_detailpage_service(pjs_detailpageDAO detailpageDao)
	{
		this.detailpageDao = detailpageDao;
	}
	
	// track_id 입력시 관련 데이터 리턴하는 메서드
	public List<trackinfoDTO> musicinfo(int track_id) {
		
	    List<trackinfoDTO> trackInfoList = detailpageDao.musicinfo(track_id);
	    
	    return trackInfoList;
	}
	
	// artist_id 입력시 artist 데이터 리턴하는 메서드
	public List<trackinfoDTO> artistinfo(int artist_id) {
	    List<trackinfoDTO> artistInfoList = detailpageDao.artistinfo(artist_id);

		System.out.println("아티스트 관련 정보 불러오기 성공");

	    return artistInfoList;
	}
	
	// album_id 입력시 album 데이터 리턴하는 메서드
	public List<trackinfoDTO> albuminfo(int album_id) {
	    List<trackinfoDTO> albumInfoList = detailpageDao.albuminfo(album_id);
	    
	    // release_date를 기준으로 내림차순 정렬
	    Collections.sort(albumInfoList, new Comparator<trackinfoDTO>() {
	        @Override
	        public int compare(trackinfoDTO track1, trackinfoDTO track2) {
	            Date releaseDate1 = track1.getRelease_date();
	            Date releaseDate2 = track2.getRelease_date();
	            return releaseDate2.compareTo(releaseDate1);
	        }
	    });
	    
		System.out.println("앨범 관련 정보 불러오기 성공");

	    return albumInfoList;
	}
	
	// 관련 아티스트를 추천하는 메서드
	public List<trackinfoDTO> relativeartist(int artist_id) {
	    List<trackinfoDTO> relativeArtistList = detailpageDao.relativeartist(artist_id);

	    List<Integer> processedArtistIds = new ArrayList<>();
	    List<trackinfoDTO> filteredList = new ArrayList<>();

	    // 중복 처리
	    for (trackinfoDTO artist : relativeArtistList) {
	        int currentArtistId = artist.getArtist_id();

	        // 중복된 artist_id인 경우 건너뛰기
	        if (processedArtistIds.contains(currentArtistId)) {
	            continue;
	        }

	        processedArtistIds.add(currentArtistId);
	        filteredList.add(artist);
	    }

	    return filteredList;
	}

}
