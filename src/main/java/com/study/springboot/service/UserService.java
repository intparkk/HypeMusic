package com.study.springboot.service;

import java.util.List;
import java.util.Map;
import java.util.Map;

import com.study.springboot.dto.UserDTO;

public interface UserService {
	
	// id와 email이 모두 일치하는 계정의 수와 dto를 map에 각각 저장
	Map login(UserDTO userDTO);
	
	// 회원가입
	int joinUser(UserDTO userDTO);
	
	// id 중복체크
	int idDupCheck(UserDTO userDTO);
	
	// email 중복체크
	int emailDupCheck(UserDTO userDTO);
}
