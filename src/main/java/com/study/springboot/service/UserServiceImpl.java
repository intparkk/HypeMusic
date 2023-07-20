package com.study.springboot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.encryptor.Encryptor;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	Encryptor encryptor;
	
	// 로그인
	@Override
	public Map login(UserDTO userDTO) {
		// 비밀번호 암호화
		String encPw = encryptor.encryptPassword(userDTO.getPw());
		userDTO.setPw(encPw);
		
		// loginCheck() : 입력받은 id와 pw가 모두 일치하는 행의 갯수를 count합니다.
		int countAcc = userDAO.loginCheck(userDTO);
		// selectUserInfo() : 입력받은 id와 pw가 모두 일치하는 유저 정보를 모두 선택합니다.
		UserDTO dto = userDAO.selectUserInfo(userDTO);
		
		// HashMap에 저장
		Map map = new HashMap();
		map.put("count", countAcc);
		map.put("dto", dto);
		
		
		return map;
	}
	
	// 회원가입
	// 성공하면 정수 1, 실패하면 정수 0을 반환
	@Override
	public int joinUser(UserDTO userDTO) {
		// 비밀번호 암호화
		String encPw = encryptor.encryptPassword(userDTO.getPw());
		userDTO.setPw(encPw);
		
		return userDAO.joinUser(userDTO);
	}
	
	// id 중복체크
	@Override
	public int idDupCheck(UserDTO userDTO) {
		
		int result = userDAO.idDupCheck(userDTO);
		
		return result;
	}
	
	// email 중복체크
	@Override
	public int emailDupCheck(UserDTO userDTO) {
		
		int result = userDAO.emailDupCheck(userDTO);
		
		return result;
	}

	// 비밀번호 변경 - 비밀번호 체크
	@Override
	public int pwCheck(UserDTO userDTO) {
		
		String encPw = encryptor.encryptPassword(userDTO.getPw());
		userDTO.setPw(encPw);
		
		return userDAO.pwCheck(userDTO);
	}

	// 비밀번호 변경
	@Override
	public int updatePw(UserDTO userDTO) {
		
		String encPw = encryptor.encryptPassword(userDTO.getPw());
		userDTO.setPw(encPw);
		
		int result = userDAO.updatePw(userDTO);
		
		return result;
	}
	
	// 프로필 사진 업데이트
	@Override
	public int updateProfileImg(UserDTO userDTO) {
		
		int result = userDAO.updateProfileImg(userDTO);
		
		return result;
	}

	// user 이메일보기
	@Override
	public UserDTO userEmail(UserDTO userDTO) {
		
		UserDTO result = userDAO.userEmail(userDTO);
		
		return result;
	}

	// 박정수 : 이용권 구매
	@Override
	public UserDTO buyticket(int user_id)
	{
		UserDTO buy_result = new UserDTO();
		
		// 유저 아이디가 null 값이 아니거나
		if ((Integer)user_id != null) 
		{
			buy_result = userDAO.buyticket(user_id);
			System.out.println("서비스단에서 구매 성공!");
		}
		return buy_result;	
	}
	
	// 박정수 : 이용권 해제
	@Override
	public UserDTO sellticket(int user_id)
	{
		UserDTO sell_result = new UserDTO();


	



		// 유저 아이디가 null 값이 아니거나
		if ((Integer)user_id != null) 
		{
			sell_result = userDAO.sellticket(user_id);
			System.out.println("서비스단에서 구매해제 성공!");
		}
		
		return sell_result;		
	}
	
	// 박정수 : 이용권 업데이트(세션)
	public UserDTO updateticket(int user_id)
	{
		UserDTO update_result = userDAO.updateticket(user_id);
		
		return update_result;
	}

	@Override
	public List<UserDTO> listDao(UserDTO userDTO) {
		List<UserDTO> list = userDAO.listDao(userDTO);
		return list;
	}

}
