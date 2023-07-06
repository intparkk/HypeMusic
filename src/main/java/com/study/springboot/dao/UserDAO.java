package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.UserDTO;

@Mapper
public interface UserDAO {
	
	// 입력받은 id와 pw가 모두 일치하는 행의 갯수를 count합니다.
	int loginCheck(UserDTO userDTO);
	
	// 입력받은 id와 pw가 모두 일치하는 유저 정보를 모두 선택합니다.
	// UserServiceImpl - Map login() 내부에서 사용
	UserDTO selectUserInfo(UserDTO userDTO);
	
	// 회원가입
	int joinUser(UserDTO userDTO);
	
	// 아이디 중복체크
	int idDupCheck(UserDTO userDTO);
	
	// 이메일 중복체크
	int emailDupCheck(UserDTO userDTO);
}
