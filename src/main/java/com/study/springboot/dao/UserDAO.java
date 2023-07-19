package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.HjsmusicDTO;
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
	
	// 비밀번호 변경 - 비밀번호 확인
	int pwCheck(UserDTO userDTO);
	
	// 비밀번호 변경 수행
	int updatePw(UserDTO userDTO);
	
	// 프로필 사진 업데이트
	int updateProfileImg(UserDTO userDTO);
	
	// 이메일 보기
	UserDTO userEmail(UserDTO userDTO);
	
	// 이용권 구매	
	UserDTO buyticket(int user_id);
	
	// 이용권 해제
	UserDTO sellticket(int user_id);
	
	// 이용권 업데이트(세션)
	UserDTO updateticket(int user_id);
	
}
