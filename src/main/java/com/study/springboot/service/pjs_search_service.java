package com.study.springboot.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.pjs_searchDAO;
import com.study.springboot.dto.trackinfoDTO;

/**
 * 
 * @author 박정수
 * @apiNote 검색 기능 컨트롤러 입니다.
 */
@Service
public class pjs_search_service
{
	private final pjs_searchDAO searchDao;
	
	@Autowired
	public pjs_search_service(pjs_searchDAO searchDao)
	{
		this.searchDao = searchDao;
	}
	
	// 곡 제목(keyword)의 아티스트와 일치하는 search 결과를 반환하는 메서드
	public List<trackinfoDTO> searchbytrack(String keyword) {
		
	    List<trackinfoDTO> searchbyTrackList = searchDao.searchbytrack(keyword);
	    
	    System.out.println("트랙 검색 성공");
	    
	    return searchbyTrackList;
	}	
	
	// 아티스트명(keyword)과 일치하는 search 결과를 반환하는 메서드
	public List<trackinfoDTO> searchbyartist(String keyword)
	{
		List<trackinfoDTO> searchbyArtistList = searchDao.searchbyartist(keyword);
		
		System.out.println("아티스트 검색 성공");
		
		return searchbyArtistList;
	}
	
	
	// 앨범명(keyword)과 일치하는 search 결과를 반환하는 메서드
	public List<trackinfoDTO> searchbyalbum(String keyword)
	{
		List<trackinfoDTO> searchbyAlbumList = searchDao.searchbyalbum(keyword);
		
		System.out.println("앨범 검색 성공");
		
		return searchbyAlbumList;
	}
	
	// 검색 결과 합친 후, 중복 제거 및 최신순으로 내림차순 정렬
	public List<trackinfoDTO> searchresultbind(String keyword) {
	    List<trackinfoDTO> searchByTrackList = searchbytrack(keyword);
	    List<trackinfoDTO> searchByArtistList = searchbyartist(keyword);
	    List<trackinfoDTO> searchByAlbumList = searchbyalbum(keyword);

	    List<trackinfoDTO> mergedList = new ArrayList<>();
	    mergedList.addAll(searchByTrackList);
	    mergedList.addAll(searchByArtistList);
	    mergedList.addAll(searchByAlbumList);

	    // 중복 제거를 위한 Set 활용
	    Set<Integer> trackIds = new HashSet<>();
	    List<trackinfoDTO> uniqueList = new ArrayList<>();

	    for (trackinfoDTO track : mergedList) {
	        if (!trackIds.contains(track.getTrack_id())) {
	            trackIds.add(track.getTrack_id());
	            uniqueList.add(track);
	        }
	    }

	    // release_date를 기준으로 내림차순 정렬
	    Collections.sort(uniqueList, new Comparator<trackinfoDTO>() {
	        @Override
	        public int compare(trackinfoDTO track1, trackinfoDTO track2) {
	            Date releaseDate1 = track1.getRelease_date();
	            Date releaseDate2 = track2.getRelease_date();
	            return releaseDate2.compareTo(releaseDate1);
	        }
	    });

	    return uniqueList;
	}


}
