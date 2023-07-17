package com.study.springboot.dto;

public class PlaylistDTO {

	private int playlist_id;
	private int track_id;
	private String album_img;
	private String title;
	private String album_name;
	private String Artist;
	
	public int getPlaylist_id() {
		return playlist_id;
	}
	public void setPlaylist_id(int playlist_id) {
		this.playlist_id = playlist_id;
	}
	public int getTrack_id() {
		return track_id;
	}
	public void setTrack_id(int track_id) {
		this.track_id = track_id;
	}
	public String getAlbum_img() {
		return album_img;
	}
	public void setAlbum_img(String album_img) {
		this.album_img = album_img;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAlbum_name() {
		return album_name;
	}
	public void setAlbum_name(String album_name) {
		this.album_name = album_name;
	}
	public String getArtist() {
		return Artist;
	}
	public void setArtist(String artist) {
		Artist = artist;
	}
	
	@Override
	public String toString() {
		return "PlaylistDTO [playlist_id=" + playlist_id + ", track_id=" + track_id + ", album_img=" + album_img
				+ ", title=" + title + ", album_name=" + album_name + ", Artist=" + Artist + "]";
	}
	

	
	
}
