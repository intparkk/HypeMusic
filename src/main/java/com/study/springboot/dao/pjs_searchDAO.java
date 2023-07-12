package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.trackinfoDTO;

@Mapper
public interface pjs_searchDAO
{
	List<trackinfoDTO> searchbytrack(String keyword);
	List<trackinfoDTO> searchbyartist(String keyword);
}
