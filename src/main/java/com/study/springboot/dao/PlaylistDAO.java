package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.MyPlaylistDTO;
import com.study.springboot.dto.PlaylistDTO;
import com.study.springboot.dto.UpdatePlaylistNameDTO;

@Mapper
public interface PlaylistDAO {
	
	// 유저 재생목록 생성
	int createNewPlaylist(MyPlaylistDTO myPlaylistDTO);
	
	// 유저 재생목록 삭제
	int deletePlaylist(PlaylistDTO playlistDTO);
	
	// 재생목록 갯수 세기
	int countNumberOfPlaylist(MyPlaylistDTO myPlaylistDTO);
	
	// 재생목록 제목 불러오기
	String selectPlaylistName(MyPlaylistDTO myPlaylistDTO);
	
	// 재생목록 제목 변경
	int updatePlaylistName(UpdatePlaylistNameDTO updatePlaylistNameDTO);
	
	// 재생목록 곡 수 불러오기
	int countTracksFromPlaylist(int playlist_id);
	
	// 재생목록 이미지 업로드
	int updatePlaylistImg(MyPlaylistDTO myPlaylistDTO);
	
	// 재생목록 이미지 불러오기
	String selectPlaylistImg(int playlist_id);
	
	// 유저 재생목록 불러오기
	List<MyPlaylistDTO> loadPlaylist(MyPlaylistDTO myPlaylistDTO);
	
	// 재생목록에 곡 추가
	int insertTrackIntoPlaylist(PlaylistDTO playlistDTO);
	
	// 재생목록 곡 삭제
	int deleteTrackFromPlaylist(PlaylistDTO playlistDTO);
	
	// 재생목록 내용 불러오기
	List<PlaylistDTO> loadPlaylistTracks(PlaylistDTO playlistDTO);
}
 