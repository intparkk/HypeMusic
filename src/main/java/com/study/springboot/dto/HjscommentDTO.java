package com.study.springboot.dto;

import java.time.LocalDateTime;

public class HjscommentDTO {

	private String track_id;
	private String comment_id;
	private int user_id;
	private String comment_content;
	private LocalDateTime comment_time;
	private String parent_id;
	
	private Integer rnum;
	
	public Integer getRnum() {
		return rnum;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public String getTrack_id() {
		return track_id;
	}
	public void setTrack_id(String track_id) {
		this.track_id = track_id;
	}
	public String getComment_id() {
		return comment_id;
	}
	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public LocalDateTime getComment_time() {
		return comment_time;
	}
	public void setComment_time(LocalDateTime comment_time) {
		this.comment_time = comment_time;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	
	
	@Override
	public String toString() {
		return "HjscommentDTO [track_id=" + track_id + ", comment_id=" + comment_id + ", user_id=" + user_id
				+ ", comment_content=" + comment_content + ", comment_time=" + comment_time + ", parent_id=" + parent_id
				+ "]";
	}
	
}
