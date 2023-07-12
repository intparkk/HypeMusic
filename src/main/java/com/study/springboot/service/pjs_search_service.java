package com.study.springboot.service;

import java.util.List;

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
	
	// 곡 제목(keyword)과 일치하는 search 결과를 반환하는 메서드
	public List<trackinfoDTO> searchbytrack(String keyword) {
		
	    List<trackinfoDTO> searchbyTrackList = searchDao.searchbytrack(keyword);

	        for (trackinfoDTO trackInfo : searchbyTrackList) {
	            System.out.println("track_id: " + trackInfo.getTrack_id());
	            System.out.println("artist_id: " + trackInfo.getArtist_id());
	            System.out.println("album_id: " + trackInfo.getAlbum_id());
	            System.out.println("title: " + trackInfo.getTitle());
	            System.out.println("like_count: " + trackInfo.getLike_count());
	            System.out.println("youtube_url: " + trackInfo.getYoutube_url());
	            System.out.println("artist: " + trackInfo.getArtist());
	            System.out.println("album_name: " + trackInfo.getAlbum_name());
	            System.out.println("release_date: " + trackInfo.getRelease_date());
	            System.out.println("album_img: " + trackInfo.getAlbum_img());
	            System.out.println("album_brief: " + trackInfo.getAlbum_brief());
	        }
	    
	    System.out.println("검색 성공");

	    return searchbyTrackList;
	}
	
	// 아티스트명(keyword)과 일치하는 search 결과를 반환하는 메서드
	public List<trackinfoDTO> searchbyartist(String keyword)
	{
		List<trackinfoDTO> searchbyArtistList = searchDao.searchbyartist(keyword);
		
		return searchbyArtistList;
	}
	

}
