package com.study.springboot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class lju_maincontroller {
	
	
	@RequestMapping({"/lju_main"})
	public String lju_main() {
		
		return "/lju_main";
	}
	
	
	
	
	

}
