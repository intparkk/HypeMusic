package com.study.springboot.dto;

public class lju_music4uDTO {
	
	private String TB_MUSIC;
	private int track_id;
	private String album_img;
	private String title;
	private String score;
	private String magnitude;
	private String genre;
	private String runresult;
	private String endRunresult;
	private String updateRunresult;
	private int checkIfIdExists;
	
	
	
	@Override
	public String toString() {
		return "lju_music4uDTO [track_id=" + track_id + ", runresult=" + runresult + "]";
	}
	
	public String getTB_MUSIC() {
		return TB_MUSIC;
	}
	public void setTB_MUSIC(String tB_MUSIC) {
		TB_MUSIC = tB_MUSIC;
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
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getMagnitude() {
		return magnitude;
	}
	public void setMagnitude(String magnitude) {
		this.magnitude = magnitude;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRunresult() {
		return runresult;
	}
	public void setRunresult(String runresult) {
		this.runresult = runresult;
	}
	public String getUpdateRunresult() {
		return updateRunresult;
	}
	public void setUpdateRunresult(String updateRunresult) {
		this.updateRunresult = updateRunresult;
	}
	public int getCheckIfIdExists() {
		return checkIfIdExists;
	}
	public void setCheckIfIdExists(int checkIfIdExists) {
		this.checkIfIdExists = checkIfIdExists;
	}

	public String getEndRunresult() {
		return endRunresult;
	}

	public void setEndRunresult(String endRunresult) {
		this.endRunresult = endRunresult;
	}
	
	
	
}
