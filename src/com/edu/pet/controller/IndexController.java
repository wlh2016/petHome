package com.edu.pet.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.edu.pet.dao.AdminDao;
import com.edu.pet.dao.CartDao;
import com.edu.pet.dao.FoodDao;
import com.edu.pet.dao.OrnamentDao;
import com.edu.pet.dao.PetDao;
import com.edu.pet.dao.UserDao;
import com.edu.pet.entity.Admin;
import com.edu.pet.entity.Cart;
import com.edu.pet.entity.Food;
import com.edu.pet.entity.Ornament;
import com.edu.pet.entity.Pet;
import com.edu.pet.entity.User;
import com.edu.pet.util.MD5Util;

@Controller
@RequestMapping
public class IndexController {
	
	@Autowired
	private PetDao petDao;
	
	@Autowired
	private FoodDao foodDao;
	
	@Autowired
	private OrnamentDao ornamentDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping("/index")
	public String index(Model model) {
		List<Pet> pets = this.petDao.getAllEntry();
		model.addAttribute("pets", pets);
		List<Food> foods = this.foodDao.getAllEntry();
		model.addAttribute("foods", foods);
		List<Ornament> ornaments = this.ornamentDao.getAllEntry();
		model.addAttribute("ornaments", ornaments);
		return "toIndex";
	}
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String role = request.getParameter("role");
		//用户
		if ("0".equals(role)) {
			User user = this.userDao.selectByUsernameAndPwd(username, MD5Util.encryption(password));
			model.addAttribute("msg", "信息有误，请重新登录");
			List<Pet> pets = this.petDao.getAllEntry();
			model.addAttribute("pets", pets);
			List<Food> foods = this.foodDao.getAllEntry();
			model.addAttribute("foods", foods);
			List<Ornament> ornaments = this.ornamentDao.getAllEntry();
			model.addAttribute("ornaments", ornaments);
			request.getSession().setAttribute("loginUser", user);
			request.getSession().setAttribute("role", role);
			model.addAttribute("user", user);
		}
		if ("1".equals(role)) {
			Admin admin = this.adminDao.selectByUsernameAndPwd(username, MD5Util.encryption(password));
			if (admin == null) {
				List<Pet> pets = this.petDao.getAllEntry();
				model.addAttribute("pets", pets);
				List<Food> foods = this.foodDao.getAllEntry();
				model.addAttribute("foods", foods);
				List<Ornament> ornaments = this.ornamentDao.getAllEntry();
				model.addAttribute("ornaments", ornaments);
				model.addAttribute("msg", "信息有误，请重新登录");
			}
			request.getSession().setAttribute("loginUser", admin);
			model.addAttribute("user", admin);
			request.getSession().setAttribute("role", role);
			return "sys_center";
		}
		return "toIndex";
	}
	
	@RequestMapping("/sysMenu")
	public String sysMenu() {
		return "sys_menu";
	}
	
	@RequestMapping("/sysIndex")
	public String sysIndex() {
		return "sys_index";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, Model model) {
		request.getSession().removeAttribute("role");
		request.getSession().removeAttribute("loginUser");
		return "redirect:/index";
	}
	
	@RequestMapping(value="/reg", method=RequestMethod.GET)
	public String reg() {
		return "user/reg";
	}
	
	@RequestMapping(value="/reg", method=RequestMethod.POST)
	public String doReg(User user) {
		user.setRegTime(new Date());
		user.setPassword(MD5Util.encryption(user.getPassword()));
		this.userDao.saveEntry(user);
		User u = this.userDao.selectByUsernameAndPwd(user.getUsername(), user.getPassword());
		Cart cart = new Cart();
		cart.setUserId(u.getId());
		this.cartDao.saveEntry(cart);
		return "redirect:/index";
	}
	
	@RequestMapping("center")
	public String center() {
		return "sys_center";
	}
	
	
}
