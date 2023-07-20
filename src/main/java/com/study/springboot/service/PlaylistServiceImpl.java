package com.study.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.PlaylistDAO;
import com.study.springboot.dto.MyPlaylistDTO;
import com.study.springboot.dto.PlaylistDTO;
import com.study.springboot.dto.UpdatePlaylistNameDTO;

@Service
public class PlaylistServiceImpl implements PlaylistService{
	
	@Autowired
	PlaylistDAO playlistDAO;
	
	/**
	 * @author 이승찬
	 * */
	
	// 새 재생목록 생성
	@Override
	public int createNewPlaylist(MyPlaylistDTO myPlaylistDTO) {
		
		return playlistDAO.createNewPlaylist(myPlaylistDTO);
	}
	
	// 유저 재생목록 불러오기
	@Override
	public List<MyPlaylistDTO> loadPlaylist(MyPlaylistDTO myPlaylistDTO) {

		return playlistDAO.loadPlaylist(myPlaylistDTO);
	}
	
	// 재생목록에 곡 추가
	@Override
	public int insertTrackIntoPlaylist(PlaylistDTO playlistDTO) {
		
		return playlistDAO.insertTrackIntoPlaylist(playlistDTO);
	}

	// 재생목록 내용 불러오기
	@Override
	public List<PlaylistDTO> loadPlaylistTracks(PlaylistDTO playlistDTO) {
		
		return playlistDAO.loadPlaylistTracks(playlistDTO);
	}

	// 재생목록에서 곡 삭제
	@Override
	public int deleteTrackFromPlaylist(PlaylistDTO playlistDTO) {

		return playlistDAO.deleteTrackFromPlaylist(playlistDTO);
	}

	// 재생목록 삭제
	@Override
	public int deletePlaylist(PlaylistDTO playlistDTO) {
		
		return playlistDAO.deletePlaylist(playlistDTO);
	}

	// 재생목록 이름 변경
	@Override
	public int updatePlaylistName(UpdatePlaylistNameDTO updatePlaylistNameDTO) {

		return playlistDAO.updatePlaylistName(updatePlaylistNameDTO);
	}

	// 재생목록 사진 변경
	@Override
	public int updatePlaylistImg(MyPlaylistDTO myPlaylistDTO) {

		return playlistDAO.updatePlaylistImg(myPlaylistDTO);
	}


}
 