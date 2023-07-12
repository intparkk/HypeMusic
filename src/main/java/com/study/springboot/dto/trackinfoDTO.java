package com.study.springboot.dto;

import java.sql.Date;

public class trackinfoDTO
{
	// 트랙별 아이디
	private int track_id;
	private int artist_id;
	private int album_id;
	// 트랙 관련
	private String title;
	private String lyrics;
	private int like_count;
	private String youtube_url;
	private String genre;
	// 아티스트 관련
	private String artist;
	private String artist_img;
	private String artist_brief;
	// 앨범 관련
	private String album_name;
	private Date release_date;
	private String album_img;
	private String album_brief;
		
	public int getTrack_id()
	{
		return track_id;
	}
	public void setTrack_id(int track_id)
	{
		this.track_id = track_id;
	}
	public int getArtist_id()
	{
		return artist_id;
	}
	public void setArtist_id(int artist_id)
	{
		this.artist_id = artist_id;
	}
	public int getAlbum_id()
	{
		return album_id;
	}
	public void setAlbum_id(int album_id)
	{
		this.album_id = album_id;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
	public String getLyrics()
	{
		return lyrics;
	}
	public void setLyrics(String lyrics)
	{
		this.lyrics = lyrics;
	}
	public int getLike_count()
	{
		return like_count;
	}
	public void setLike_count(int like_count)
	{
		this.like_count = like_count;
	}
	public String getYoutube_url()
	{
		return youtube_url;
	}
	public void setYoutube_url(String youtube_url)
	{
		this.youtube_url = youtube_url;
	}
	public String getGenre()
	{
		return genre;
	}
	public void setGenre(String genre)
	{
		this.genre = genre;
	}
	public String getArtist()
	{
		return artist;
	}
	public void setArtist(String artist)
	{
		this.artist = artist;
	}
	public String getArtist_img()
	{
		return artist_img;
	}
	public void setArtist_img(String artist_img)
	{
		this.artist_img = artist_img;
	}
	public String getArtist_brief()
	{
		return artist_brief;
	}
	public void setArtist_brief(String artist_brief)
	{
		this.artist_brief = artist_brief;
	}
	public String getAlbum_name()
	{
		return album_name;
	}
	public void setAlbum_name(String album_name)
	{
		this.album_name = album_name;
	}
	public Date getRelease_date()
	{
		return release_date;
	}
	public void setRelease_date(Date release_date)
	{
		this.release_date = release_date;
	}
	public String getAlbum_img()
	{
		return album_img;
	}
	public void setAlbum_img(String album_img)
	{
		this.album_img = album_img;
	}
	public String getAlbum_brief()
	{
		return album_brief;
	}
	public void setAlbum_brief(String album_brief)
	{
		this.album_brief = album_brief;
	}
}
