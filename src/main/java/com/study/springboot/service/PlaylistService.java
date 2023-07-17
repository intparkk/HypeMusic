package com.study.springboot.service;

import java.util.List;
import java.util.Map;

import com.study.springboot.dto.MyPlaylistDTO;
import com.study.springboot.dto.PlaylistDTO;
import com.study.springboot.dto.UpdatePlaylistNameDTO;

public interface PlaylistService {
	
	// 유저 재생목록 생성
	int createNewPlaylist(MyPlaylistDTO myPlaylistDTO);
	
	// 유저 재생목록 삭제
	int deletePlaylist(PlaylistDTO playlistDTO);
	
	// 유저 재생목록 불러오기
	List<MyPlaylistDTO> loadPlaylist(MyPlaylistDTO myPlaylistDTO);
	
	// 재생목록 제목 변경
	int updatePlaylistName(UpdatePlaylistNameDTO updatePlaylistNameDTO);
	
	// 재생목록 이미지 업로드
	int updatePlaylistImg(MyPlaylistDTO myPlaylistDTO);
	
	// 재생목록에 곡 추가
	int insertTrackIntoPlaylist(PlaylistDTO playlistDTO);
	
	// 재생목록 곡 삭제
	int deleteTrackFromPlaylist(PlaylistDTO playlistDTO);
	
	// 재생목록 내용 불러오기
	List<PlaylistDTO> loadPlaylistTracks(PlaylistDTO playlistDTO);
}
 