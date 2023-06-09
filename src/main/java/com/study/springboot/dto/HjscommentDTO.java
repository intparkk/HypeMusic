package com.study.springboot.dto;

import java.time.LocalDateTime;

public class HjscommentDTO {

	private String track_id;
	private String comment_id;
	private String member_id;
	private String comment_content;
	private LocalDateTime comment_time;
	private String parent_id;
	
	
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
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
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
		return "HjscommentDTO [track_id=" + track_id + ", comment_id=" + comment_id + ", member_id=" + member_id
				+ ", comment_content=" + comment_content + ", comment_time=" + comment_time + ", parent_id=" + parent_id
				+ "]";
	}
	
}
