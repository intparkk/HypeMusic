package com.study.springboot.service;

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
	    
	    if (!trackInfoList.isEmpty()) {
	    	// 결과 확인용
	        /*for (trackinfoDTO trackInfo : trackInfoList) {
	            System.out.println("album_id: " + trackInfo.getAlbum_id());
	            System.out.println("track_id: " + trackInfo.getTrack_id());
	            System.out.println("artist_id: " + trackInfo.getArtist_id());
	            System.out.println("title: " + trackInfo.getTitle());
	            //System.out.println("lyrics: " + trackInfo.getLyrics());
	            System.out.println("like_count: " + trackInfo.getLike_count());
	            System.out.println("youtube_url: " + trackInfo.getYoutube_url());
	            System.out.println("genre: " + trackInfo.getGenre());
	            System.out.println("artist: " + trackInfo.getArtist());
	            System.out.println("album_name: " + trackInfo.getAlbum_name());
	            System.out.println("release_date: " + trackInfo.getRelease_date());
	            System.out.println("album_img: " + trackInfo.getAlbum_img());
	        }*/
	    }
	    return trackInfoList;
	}
	
	// artist_id 입력시 artist 데이터 리턴하는 메서드
	public List<trackinfoDTO> artistinfo(int artist_id) {
	    List<trackinfoDTO> artistInfoList = detailpageDao.artistinfo(artist_id);

	    /*if (!artistInfoList.isEmpty()) {
	        for (trackinfoDTO artistInfo : artistInfoList) {
	            System.out.println("artist_id: " + artistInfo.getArtist_id());
	            System.out.println("album_id: " + artistInfo.getAlbum_id());
	            System.out.println("track_id: " + artistInfo.getTrack_id());
	            System.out.println("title: " + artistInfo.getTitle());
	            System.out.println("album_img: " + artistInfo.getAlbum_img());
	            System.out.println("artist: " + artistInfo.getArtist());
	            System.out.println("artist_img: " + artistInfo.getArtist_img());
	            System.out.println("artist_brief: " + artistInfo.getArtist_brief());
	        }
	    }*/
		System.out.println("아티스트 관련 정보 불러오기 성공");

	    return artistInfoList;
	}
	
	// artist_id 입력시 artist 데이터 리턴하는 메서드
	public List<trackinfoDTO> albuminfo(int album_id) {
	    List<trackinfoDTO> albumInfoList = detailpageDao.albuminfo(album_id);
	    
	        /*for (trackinfoDTO albumInfo : albumInfoList) {
	            System.out.println("앨범 아티스트: " + albumInfo.getArtist());
	            System.out.println("앨범 제목: " + albumInfo.getAlbum_name());
	            System.out.println("앨범 발매일: " + albumInfo.getRelease_date());
	            System.out.println("앨범 이미지: " + albumInfo.getAlbum_img());
	            System.out.println("앨범 소개: " + albumInfo.getAlbum_brief());
	        }*/
		System.out.println("앨범 관련 정보 불러오기 성공");

	    return albumInfoList;
	}
	
	// 관련 아티스트를 추천하는 메서드
	public List<trackinfoDTO> relativeartist(String artist_name)
	{
		List<trackinfoDTO> relativeArtistList = detailpageDao.relativeartist(artist_name);
		
		return relativeArtistList;
	}

}
