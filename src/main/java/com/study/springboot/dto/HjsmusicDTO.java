package com.study.springboot.dto;

import java.sql.Date;

public class HjsmusicDTO {
	
	// 데이터 열의 이름에서 오타가 나지 않도록 해야 나중에 
	// 헤매지 않습니다. ^^;
	private String track_id; 
	private String artist_id; 
	private String album_img;
	private String title; 
	private String artist; 
	private String album_name;
	private int like_count; 
	private String genre; 
	private String release_date;
	private String lyrics;
	
	
	public String getTrack_id() {
		return track_id;
	}
	public void setTrack_id(String track_id) {
		this.track_id = track_id;
	}
	public String getArtist_id() {
		return artist_id;
	}
	public void setArtist_id(String artist_id) {
		this.artist_id = artist_id;
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
	public String getArtist() {
		return artist;
	}
	public void setArtist(String artist) {
		this.artist = artist;
	}
	public String getAlbum_name() {
		return album_name;
	}
	public void setAlbum_name(String album_name) {
		this.album_name = album_name;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRelease_date() {
		return release_date;
	}
	public void setRelease_date(String release_date2) {
		this.release_date = release_date2;
	}
	public String getLyrics() {
		return lyrics;
	}
	public void setLyrics(String lyrics) {
		this.lyrics = lyrics;
	}
	
	
	@Override
	public String toString() {
		return "HjsmusicDTO [track_id=" + track_id + ", artist_id=" + artist_id + ", album_img=" + album_img
				+ ", title=" + title + ", artist=" + artist + ", album_name=" + album_name + ", like_count="
				+ like_count + ", genre=" + genre + ", release_date=" + release_date + "]";
	}
	
		
	
	
}
