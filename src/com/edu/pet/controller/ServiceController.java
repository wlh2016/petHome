package com.edu.pet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("service")
public class ServiceController {
	
	@RequestMapping("tg")
	public String tg(Model model) {
		model.addAttribute("orderType", "2");
		return "order/yy";
	}
	
	@RequestMapping("hl")
	public String hl(Model model) {
		model.addAttribute("orderType", "3");
		return "order/yy";
	}
	
	
	
	
}
