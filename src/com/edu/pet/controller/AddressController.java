package com.edu.pet.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.pet.dao.AddressDao;
import com.edu.pet.entity.Address;
import com.edu.pet.entity.User;

@Controller
@RequestMapping("address")
public class AddressController {
	
	@Autowired
	private AddressDao addressDao;
	
	@RequestMapping("list")
	public String list(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loginUser");
		List<Address> list = this.addressDao.getByUserId(user.getId());
		model.addAttribute("list", list);
		return "address/list";
	}
	
	@RequestMapping("update")
	public String update(Address address) {
		this.addressDao.updateEntry(address);
		return "redirect:/address/list";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(@RequestParam(value="id") Integer id) {
		this.addressDao.deleteEntry(id);
		return "yes";
	}
	
	@RequestMapping("add")
	public String add() {
		return "address/add";
	}
	
	@RequestMapping("save")
	public String save(Address address) {
		this.addressDao.saveEntry(address);
		return "redirect:/address/list";
	}
	
	
}
