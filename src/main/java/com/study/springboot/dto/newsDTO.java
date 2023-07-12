package com.study.springboot.dto;

public class newsDTO
{
	private String news_title;
	private String news_brief;
	private String news_img;
	private String news_url;
	
	public String getNews_title()
	{
		return news_title;
	}
	public void setNews_title(String news_title)
	{
		this.news_title = news_title;
	}
	public String getNews_brief()
	{
		return news_brief;
	}
	public void setNews_brief(String news_brief)
	{
		this.news_brief = news_brief;
	}
	public String getNews_img()
	{
		return news_img;
	}
	public void setNews_img(String news_img)
	{
		this.news_img = news_img;
	}
	public String getNews_url()
	{
		return news_url;
	}
	public void setNews_url(String news_url)
	{
		this.news_url = news_url;
	}

}
