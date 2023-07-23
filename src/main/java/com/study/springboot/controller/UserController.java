package com.study.springboot.controller;

import java.io.File;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
 * 	계정 관련 컨트롤러입니다.
 * 	
 * 	:: 비밀번호 암호화 순서 ::
 *  1. 뷰(signupForm)의 form에서 전달받은 비밀번호를 CryptoJS(JavaScript 라이브러리)를 사용해 
 *     SHA-256 알고리즘으로 암호화(해쉬화)하여 서버로 전달합니다.
 *     
 * 	2. Encryptor 패키지에서 MessageDigest 라이브러리로 뷰에서 넘어온 암호화된 비밀번호를
 * 	   SHA-256 알고리즘으로 한 번 더 암호화하여 DB에 저장합니다. 
 * 
 * */


@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDAO userDAO;
	 
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
		
		if(countAcc == 1) {
			// 계정 있음
			HttpSession session = req.getSession();
			session.setAttribute("isLoggedIn", "ok");
			
			if(userInfo != null) {
				
				session.setAttribute("userInfo", userInfo);
//				System.out.println("[/doLogin]로그인 성공 id : " + userInfo.getId());
				
				return "redirect:/Mainpage";
			}
		} else {
				System.out.println("로그인 실패");
				// 계정 없음
				String errMsg = "계정 정보가 일치하지 않습니다.";
				model.addAttribute("errMsg", errMsg);
			  }
		
		return "loginForm";
	}

	
	// 비밀번호 찾기 페이지
	@RequestMapping("/findPw")
	public String findPw() {
		
		return "findPw";
	}
	
	// 비밀번호 찾기 수행
	@RequestMapping(value="/doFindPw", method=RequestMethod.POST)
	public String doFindPw(
			RedirectAttributes redirectAttributes,
			@ModelAttribute
			UserDTO userDTO
			) {
		int countedAccout = userDAO.findPwById(userDTO);
		
		if(countedAccout == 1 ) {
			
			redirectAttributes.addFlashAttribute("userDTO", userDTO);
			
			return "redirect:/findPw/updatePw";
		}
		
		redirectAttributes.addFlashAttribute("errMsg", "일치하는 계정 정보가 없습니다.");
		
		return "redirect:/findPw";
	}
	
	// 로그아웃 수행
	@RequestMapping("/logout")
	public String logout (
			HttpServletRequest req
			) {
		HttpSession session = req.getSession();
		session.invalidate();
//		System.out.println("로그아웃");
		
		return "redirect:/Mainpage";
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
			@ModelAttribute 
			UserDTO userDTO,
			Model model
			) {
		
		int countId = userService.idDupCheck(userDTO);
		int countEmail = userService.emailDupCheck(userDTO);
		
		if (countId == 0 && countEmail == 0) {
			// 이미 가입된 id와 email 가 아닐 경우 
			userService.joinUser(userDTO);
//			System.out.println("회원가입 성공 id : " + userDTO.getId());
			
			return "redirect:/Mainpage";
			
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
//			System.out.println("회원가입 실패");
			
			return "error";
		}
				
	}
	
	// 내 정보 페이지
	@RequestMapping("/myInfo")
	public String myInfo(
			HttpServletRequest req,
			Model model) {
		
		HttpSession session = req.getSession();
		
		UserDTO userDTO = (UserDTO) session.getAttribute("userInfo");
		model.addAttribute("userDTO", userDTO);
		
		if (userDTO != null) {
			return "myInfo";
		}
		
		return "redirect:/login";
		
	}
	
	// 비밀번호 변경 전 비밀번호 확인 페이지
	@RequestMapping("/myInfo/checkPw")
	public String checkPw(
			HttpSession session,
			Model model
			) {
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		model.addAttribute("userInfo", userInfo);
//		System.out.println("[/checkPw]" + userInfo);
		
		return "checkPw";
	}
	
	// 비밀번호 확인 수행
	@RequestMapping(value="/doCheckPw", method=RequestMethod.POST)
	public String doCheckPw(
			HttpSession session,
			@ModelAttribute
			UserDTO userDTO,
			Model model
			) {
		if (userDTO == null) {
			return "redirect:/login";
		}
		
		UserDTO userInfo = (UserDTO) session.getAttribute("userInfo");
		
		String id = userInfo.getId();
		model.addAttribute("id", id);
		
        int count = userService.pwCheck(userDTO);
//      System.out.println("[/doCheckPw]Count : " + count);
        
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
	
	// 비밀번호 찾기 - 비밀번호 변경 페이지
	@RequestMapping("/findPw/updatePw")
	public String findAndUpdatePw(
			@ModelAttribute
			UserDTO userDTO,
			Model model
			) {
		System.out.println(userDTO);
		
		if (userDTO == null) {
			
			return "redirect:/findPw";
		}
		model.addAttribute("userDTO", userDTO);
		
		return "findAndUpdatePw";
	}
	
	// 내 정보 - 비밀번호 변경 수행
	@RequestMapping("/findPw/doUpdatePw")
	public String findAndDoUpdatePw (
			@ModelAttribute
			UserDTO userDTO,
			Model model
			) {

		int count = userService.updatePw(userDTO);
//		System.out.println("[/doUpdatePw] count : " + count );
		
		try {
			if (count == 1) {
				// 변경 성공
				return "redirect:/login";
			} else {
				return "redirect:/error2";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/myInfo";
		}
	}
	
	// 내 정보 - 비밀번호 변경 페이지
	@RequestMapping("/myInfo/updatePw")
	public String updatePw(
			HttpServletRequest req,
			Model model
			) {
		
		HttpSession session = req.getSession();
		
		UserDTO dto = (UserDTO) session.getAttribute("userInfo");
		
		model.addAttribute("dto", dto);
//		System.out.println("[./udpatePw]Dto : " + dto);
		
		return "updatePw";
	}
	
	// 내 정보 - 비밀번호 변경 수행
	@RequestMapping("/doUpdatePw")
	public String doUpdatePw (
			HttpServletRequest req,
			@ModelAttribute
			UserDTO userDTO,
			Model model
			) {

		HttpSession session = req.getSession();

		int count = userService.updatePw(userDTO);
//		System.out.println("[/doUpdatePw] count : " + count );
		
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
	
	// 박정수 : 이용권 구매 페이지 컨트롤러
	@RequestMapping("pjs_ticket")
	public String buyticket(HttpSession session)
	{
		// 전체 유저 정보(세션)
		UserDTO userinfo = (UserDTO)session.getAttribute("userInfo");
		
		//Integer test_user_id = (Integer)session.getAttribute("userInfo");
		
		// 유저정보 확인용
		Integer now_userid;
		String now_rank;
		
		if (userinfo == null) {
			now_userid = null;
			now_rank = null;
		} else {
			now_userid = userinfo.getUser_id();
			now_rank = userinfo.getRank();
		}
		//System.out.println("세션에서 직접 가져온 유저아뒤 :" +test_user_id);
		//System.out.println("현재 유저id : "+now_userid);
		//System.out.println("현재 등급 : " +now_rank);
		
		return "pjs_ticket";
	}
	
	// 박정수 : 이용권 구매
	@PostMapping("/buyTicket")
	@ResponseBody
	public UserDTO getticket(@RequestBody UserDTO requestBody, HttpSession session) {
		
		// 페이지 에서 전달받는 user_id
		Integer now_user_id = requestBody.getUser_id();
		// getTicket 쿼리문 호출
		UserDTO getTicket = userService.buyticket(now_user_id);
		// 등급 티켓으로 변경 후, 업데이트 쿼리문 호출
		UserDTO updateTicket = userService.updateticket(now_user_id);
		
		// 세션에 담고 다시 받기
		session.setAttribute("userInfo", updateTicket);
		session.getAttribute("userInfo");
		
		//System.out.println("구매 후"+updateTicket);	    

		System.out.println("컨트롤러에서 구매 성공!");
		
		return getTicket;
	}
	
	// 박정수 : 이용권 해제
	@PostMapping("/cancelTicket")
	@ResponseBody
	public UserDTO sellticket(@RequestBody UserDTO requestBody,HttpSession session) {
		
		// 페이지에서 전달받는 user_id
		Integer now_user_id = requestBody.getUser_id();
		// getTicket 쿼리문 호출    	
		UserDTO sellTicket = userService.sellticket(now_user_id);
		// 등급 티켓으로 변경 후, 업데이트 쿼리문 호출        
		UserDTO updateTicket = userService.updateticket(now_user_id);
		
		// 세션에 담고 다시 받기
		session.setAttribute("userInfo", updateTicket);
		session.getAttribute("userInfo");
		
		//System.out.println("구매 후 rank : "+updateTicket.getRank());
		System.out.println("컨트롤러에서 구매 취소 성공!");
				
		return sellTicket;
	}
}











