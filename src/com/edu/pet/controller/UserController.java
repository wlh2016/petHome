package com.edu.pet.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.pet.dao.UserDao;
import com.edu.pet.entity.User;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	private UserDao userDao;
	
	@RequestMapping("list")
	public String list(User user, Model model) {
		List<User> list = this.userDao.queryByUsername(user.getUsername()!=null ? user.getUsername():"");
		model.addAttribute("list", list);
		return "user/users";
	}
 	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(@RequestParam(value="uid") Integer uid) {
		this.userDao.deleteEntry(uid);
		return "yes";
	}
	
	@RequestMapping(value="edit/{uid}", method=RequestMethod.GET)
	public String edit(@PathVariable(value="uid") Integer uid, Model model) {
		User user = this.userDao.getEntryById(uid);
		model.addAttribute("u", user);
		return "user/edit";
	}
	
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String update(User user) {
		this.userDao.updateUser(user);
		return "redirect:/user/list";
	}
	
	@RequestMapping(value="add", method=RequestMethod.GET)
	public String add() {
		return "user/add";
	}
	
	@RequestMapping(value="add", method=RequestMethod.POST)
	public String save(User user) {
		user.setRegTime(new Date());
		this.userDao.saveEntry(user);
		return "redirect:/user/list";
	}
	
	@RequestMapping("userInfo")
	public String userInfo() {
		return "user/userInfo";
	}
	
	@RequestMapping(value="reviseSelfInfo", method=RequestMethod.GET)
	public String reviseSelfInfo(Model model) {
		return "user/reviseSelfInfo";
	}
	
	@RequestMapping(value="reviseSelfInfo", method=RequestMethod.POST)
	public String reviseSelfInfo(User user, HttpSession session) {
		User loginUser = (User)session.getAttribute("loginUser");
		user.setRegTime(loginUser.getRegTime());
		this.userDao.updateEntry(user);
		session.setAttribute("loginUser", user);
		return "redirect:/user/userInfo";
	}
	
	
	
	
	
}
