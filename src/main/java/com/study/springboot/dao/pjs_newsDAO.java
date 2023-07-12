package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.newsDTO;

@Mapper
public interface pjs_newsDAO
{
	List<newsDTO> getNewsList();
	List<newsDTO> getNewsByPage(int page);
}
