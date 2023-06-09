package com.study.springboot.controller;

import java.io.File;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.study.springboot.dao.UserDAO;
import com.study.springboot.dto.UserDTO;
import com.study.springboot.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
/**
 * @author 이승찬
 * @apiNote
 * 	로그인/회원가입 컨트롤러입니다.
 * 	
 * 	:: 비밀번호 암호화 순서 ::
 *  1. 뷰(signupForm)의 form에서 전달받은 비밀번호를 CryptoJS(JavaScript 라이브러리)를 사용해 
 *     SHA-256 알고리즘으로 암호화(해쉬화)하여 서버로 전달합니다.
 *     
 * 	2. Encryptor 패키지에서 MessageDigest 라이브러리로 뷰에서 넘어온 암호화된 비밀번호를
 * 	   SHA-256 알고리즘으로 한 번 더 암호화하여 DB에 저장합니다. 
 * 
 *  테스트용 메인페이지 /test-main
 *  
 *  로그인 : 가능
 *  		id : admin / pw : 1234
 *  회원가입 : 가능
 *  		 등급은 가입 시 기본으로 'normal'로 설정됨
 *  
 *  TODO : kAuth, oAuth 적용하기(마지막에)
 *  	   유저 정보 페이지
 *  	   	- 내 재생목록
 *  			- 재생목록 추가/삭제/업데이트
 *  	    - 내 정보 수정
 *  			- 비밀번호 변경
 *  				- 비밀번호 확인 후 변경하게
 *			- 내가 쓴 댓글 확인/삭제
 *			- 회원 탈퇴  	   
 *			- 이용권 사면 등급 올라가게
 *				- 이용권에 만료일 지정?
 * */


@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	 
	// 메인페이지
	@RequestMapping("/test-main")
	public String main(
			HttpServletRequest req,
			Model model
			) {
		HttpSession session = req.getSession();
		
		// 로그인할 때 userInfo 라는 key 에 저장한 dto 가져오기
		UserDTO dto = (UserDTO) session.getAttribute("userInfo");
		System.out.println("[/] UserDTO : " + dto);
		System.out.println("[/]is Logged In? : " + session.getAttribute("isLoggedIn"));
		
		// jsp에 dto 라는 key 값으로 dto 전달
		model.addAttribute("dto", dto);
		
		return "lsc_main_test2";
	}
	
	// 로그인 폼
	@RequestMapping("/login")
	public String loginForm() {
		
		return "loginForm";
	}
	
	// 로그인 수행
	@RequestMapping(value="/doLogin", method=RequestMethod.POST)
	public String doLogin(
			HttpServletRequest req,
			@ModelAttribute
			UserDTO userDTO,
			Model model
			) {
		
		Map map = userService.login(userDTO);
		UserDTO userInfo = (UserDTO) map.get("dto");
		int countAcc = (int) map.get("count");
		
		System.out.println("[/doLogin]count : " + countAcc);	
		System.out.println("[/doLogin]userInfo : " + userInfo);	
		
		if(countAcc == 1) {
			// 계정 있음
			HttpSession session = req.getSession();
			session.setAttribute("isLoggedIn", "ok");
			
			if(userInfo != null) {
				
				session.setAttribute("userInfo", userInfo);
				System.out.println("[/doLogin]로그인 성공 id : " + userDTO.getId());
				System.out.println("[/doLogin]userInfo : " + userInfo);
				
				return "redirect:/test-main";
			}
		} else {
				System.out.println("로그인 실패");
				// 계정 없음
				String errMsg = "계정 정보가 일치하지 않습니다.";
				model.addAttribute("errMsg", errMsg);
			  }
		
		return "loginForm";
	}
	
	// 로그아웃 수행
	@RequestMapping("/logout")
	public String logout (
			HttpServletRequest req
			) {
		HttpSession session = req.getSession();
		session.invalidate();
		System.out.println("로그아웃");
		
		return "redirect:/test-main";
	}
	
	// 회원가입 폼
	@RequestMapping("/signup")
	public String signupForm() {
		
		return "signupForm";
	}
	
	// 회원가입 수행
	@RequestMapping(value="/doSignup", method=RequestMethod.POST)
	public String doSignup(
			HttpServletRequest req,
			@ModelAttribute UserDTO userDTO,
			Model model
			) {
		
		int countId = userService.idDupCheck(userDTO);
		int countEmail = userService.emailDupCheck(userDTO);
		
		if (countId == 0 && countEmail == 0) {
			// 이미 가입된 id와 email 가 아닐 경우 
			userService.joinUser(userDTO);
			System.out.println("회원가입 성공 id : " + userDTO.getId());
			
			return "redirect:/test-main";
			
		} else if (countId > 0){
			// countID가 0 보다 크면 이미 DB에 같은 ID가 한 개 이상 존재
			String idErrMsg = "이미 사용중인 아이디입니다.";
			model.addAttribute("idErrMsg", idErrMsg);
			
			return "signupForm";
			
		} else if (countEmail > 0){
			// countEmail이 0 보다 크면 DB에 같은 Email이 한 개 이상 존재
			String emailErrMsg = "이미 가입된 이메일입니다.";
			model.addAttribute("emailErrMsg", emailErrMsg);
			
			return "signupForm";
			
		} else {
			System.out.println("회원가입 실패");
			
			return "error2";
		}
				
	}
	
	// 내 정보 페이지
	@RequestMapping("/myInfo")
	public String myInfo(
			HttpServletRequest req,
			Model model) {
		
		HttpSession session = req.getSession();
		session.getAttribute("isLoggedIn");
		
		UserDTO dto = (UserDTO) session.getAttribute("userInfo");
		model.addAttribute("dto", dto);
		
		System.out.println("[/myInfo]Dto : " + dto);
		
		return "myInfo";
	}
	
	// 비밀번호 변경 전 비밀번호 확인 페이지
	@RequestMapping("/myInfo/checkPw")
	public String checkPw(
			HttpServletRequest req,
			Model model
			) {
		
		HttpSession session = req.getSession();
		session.getAttribute("isLoggedIn");

		UserDTO dto = (UserDTO) session.getAttribute("userInfo");
		model.addAttribute("dto", dto);
		System.out.println("[./checkPw]" + dto);
		
		return "checkPw";
	}
	
	// 비밀번호 확인 수행
	@RequestMapping(value="/doCheckPw", method=RequestMethod.POST)
	public String doCheckPw(
			HttpServletRequest req,
			@ModelAttribute
			UserDTO userDTO,
			Model model
			) {
		
		HttpSession session = req.getSession();
        session.getAttribute("isLoggedIn");
        
        int count = userService.pwCheck(userDTO);
        System.out.println("[/doCheckPw]Count : " + count);
        if (count == 1) {
        	// 비밀번호 일치
        	System.out.println("비밀번호 일치");
        	return "redirect:/myInfo/updatePw";
        } else {
        	System.out.println("실패");
        	String errMsg = "비밀번호가 일치하지 않습니다.";
        	model.addAttribute("errMsg", errMsg);
        	return "redirect:/myInfo/checkPw";
        }        
	}
	
	// 비밀번호 변경 페이지
	@RequestMapping("/myInfo/updatePw")
	public String updatePw(
			HttpServletRequest req,
			Model model
			) {
		
		HttpSession session = req.getSession();
		System.out.println("[./updatePw]" + session.getAttribute("isLoggedIn"));
		
		UserDTO dto = (UserDTO) session.getAttribute("userInfo");
		model.addAttribute("dto", dto);
		System.out.println("[./udpatePw]Dto : " + dto);
		
		return "updatePw";
	}
	
	// 비밀번호 변경 수행
	@RequestMapping("/doUpdatePw")
	public String doUpdatePw (
			HttpServletRequest req,
			@ModelAttribute
			UserDTO userDTO,
			Model model
			) {
		System.out.println("업데이트 하러 들어옴");
		HttpSession session = req.getSession();
		System.out.println("DAO호출 직전임");
		int count = userService.updatePw(userDTO);
		System.out.println("[/doUpdatePw] count : " + count );
		try {
			if (count == 1) {
				// 변경 성공
				return "redirect:/myInfo";
			} else {
				
				return "redirect:/error2";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/myInfo";
		}
		
	}
	
	// 프로필 사진 업로드
	@RequestMapping(value="/upload", method=RequestMethod.POST)
	@ResponseBody
	public String uploadProfileImg(
			@RequestParam("file") MultipartFile file,
			RedirectAttributes redirectAttributes,
			HttpSession session,
			Model model
			) {

//		System.out.println("/upload 접속");
//		System.out.println("/ : "+ file.isEmpty());
		
		if (!file.isEmpty()) {
			try {
				
				String filePath = "C:\\Users\\User\\Desktop\\HypeMusic\\src\\main\\resources\\static\\user_profile_img";
				String fileName = file.getOriginalFilename();
				String fullFilePath = filePath + "\\" + fileName;
		
				File destination = new File(fullFilePath);
				file.transferTo(destination);
				
				// 이미지 주소 반환
				String imageUrl = "/user_profile_img/" + fileName;
				
				// 데이터베이스에 이미지 주소 업데이트
				UserDTO userDTO = (UserDTO) session.getAttribute("userInfo");
				userDTO.setProfile_img(imageUrl);
				userService.updateProfileImg(userDTO);
				
				redirectAttributes.addFlashAttribute("imageUrl", imageUrl);
				return imageUrl;
				
			} catch(Exception e) {
				e.printStackTrace();
			  }
		}
		
		return "redirect:/myInfo";
	}

}











