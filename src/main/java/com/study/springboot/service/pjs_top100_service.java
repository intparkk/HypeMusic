package com.study.springboot.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.study.springboot.dao.pjs_top100DAO;
import com.study.springboot.dto.trackinfoDTO;

@Service
public class pjs_top100_service
{
	private pjs_top100DAO top100DAO;
	
	public pjs_top100_service(pjs_top100DAO top100DAO)
	{
		this.top100DAO = top100DAO;
	}
	
	public List<trackinfoDTO> getTop100Tracks() {
	    List<trackinfoDTO> uniqueTracks = new ArrayList<>();

	    List<trackinfoDTO> tracks = top100DAO.getTop100Tracks();

	    for (trackinfoDTO track : tracks) {
	        int trackId = track.getTrack_id();
	        int likeCount = track.getLike_count();

	        boolean isDuplicate = false;
	        for (int i = 0; i < uniqueTracks.size(); i++) {
	        	trackinfoDTO existingTrack = uniqueTracks.get(i);
	            if (existingTrack.getTrack_id() == trackId) {
	                isDuplicate = true;
	                if (likeCount > existingTrack.getLike_count()) {
	                    existingTrack.setLike_count(likeCount);
	                    existingTrack.setTitle(track.getTitle());
	                    existingTrack.setArtist(track.getArtist());
	                    existingTrack.setAlbum_name(track.getAlbum_name());
	                    existingTrack.setAlbum_img(track.getAlbum_img());
	                    existingTrack.setYoutube_url(track.getYoutube_url());
	                }
	                break;
	            }
	        }

	        if (!isDuplicate) {
	            uniqueTracks.add(track);
	        }
	    }
	    return uniqueTracks;
	}
}
