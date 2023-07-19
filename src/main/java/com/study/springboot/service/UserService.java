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
	
	// 비밀번호 변경 - 비밀번호 체크
	int pwCheck(UserDTO userDTO);
	
	// 비밀번호 변경
	int updatePw(UserDTO userDTO);
	
	// 프로필 사진 업데이트
	int updateProfileImg(UserDTO userDTO);
	
	// 이메일보기
	UserDTO userEmail(UserDTO userDTO);
	
	List<UserDTO> listDao(UserDTO userDTO);
}
