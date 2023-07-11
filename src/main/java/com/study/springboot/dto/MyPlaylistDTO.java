package com.study.springboot.dto;

public class MyPlaylistDTO {
	
	private int playlist_id;
	private String playlist_name;
	private int playlist_quantity;
	private int user_id;
	private int track_id;
	
	public int getPlayList_id() {
		return playlist_id;
	}
	public void setPlayList_id(int playList_id) {
		this.playlist_id = playList_id;
	}
	public String getPlayList_name() {
		return playlist_name;
	}
	public void setPlayList_name(String playList_name) {
		this.playlist_name = playList_name;
	}
	public int getPlayList_quantity() {
		return playlist_quantity;
	}
	public void setPlayList_quantity(int playList_quantity) {
		this.playlist_quantity = playList_quantity;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getTrack_id() {
		return track_id;
	}
	public void setTrack_id(int track_id) {
		this.track_id = track_id;
	}
	 
	@Override
	public String toString() {
		return "MyPlaylistDTO [playlist_id=" + playlist_id + ", playlist_name=" + playlist_name + ", playlist_quantity="
				+ playlist_quantity + ", user_id=" + user_id + ", track_id=" + track_id + "]";
	}
	

	
}
