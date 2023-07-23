package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.trackinfoDTO;

@Mapper
public interface pjs_nowmusicDAO
{
	List<trackinfoDTO> getnowmusictracks();
}
