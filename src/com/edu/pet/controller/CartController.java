package com.edu.pet.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.pet.dao.CartDao;
import com.edu.pet.dao.CartItemDao;
import com.edu.pet.dao.FoodDao;
import com.edu.pet.dao.OrnamentDao;
import com.edu.pet.dao.PetDao;
import com.edu.pet.entity.Cart;
import com.edu.pet.entity.CartItem;
import com.edu.pet.entity.Food;
import com.edu.pet.entity.Ornament;
import com.edu.pet.entity.Pet;
import com.edu.pet.entity.User;

@Controller
@RequestMapping("cart")
public class CartController {
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private CartItemDao cartItemDao;
	
	@Autowired
	private PetDao petDao;
	
	@Autowired
	private FoodDao foodDao;
	
	@Autowired
	private OrnamentDao ornamentDao;
	
	@RequestMapping("add/{type}/{id}")
	public String add(@PathVariable(value="type") String type, @PathVariable(value="id") Integer id, 
			HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		Cart cart = this.cartDao.getByUid(loginUser.getId());
		//判断购物车中已经有该商品
		String goodsType = "pet".equals(type) ? "1":("food".equals(type) ? "2":"3");
		boolean exit = this.cartItemDao.queryExit(cart.getId(), id, goodsType);			
		if (!exit) {
			CartItem cartItem = new CartItem();
			cartItem.setCartId(cart.getId());
			if ("pet".equals(type)) {
				Pet goods = this.petDao.getEntryById(id);
				cartItem.setGoodsId(goods.getId());
				cartItem.setGoodsName(goods.getName());
				cartItem.setPicLocation(goods.getPicLocation());
				cartItem.setUnitPrice(goods.getUnitPrice());
				cartItem.setAmount(1);
				cartItem.setTotalPrice(goods.getUnitPrice());
				cartItem.setGoodsType("1");
			} else if ("food".equals(type)) {
				Food goods = this.foodDao.getEntryById(id);
				cartItem.setGoodsId(goods.getId());
				cartItem.setGoodsName(goods.getName());
				cartItem.setPicLocation(goods.getPicLocation());
				cartItem.setUnitPrice(goods.getUnitPrice());
				cartItem.setAmount(1);
				cartItem.setTotalPrice(goods.getUnitPrice());
				cartItem.setGoodsType("2");
			} else if ("ornament".equals(type)) {
				Ornament goods = this.ornamentDao.getEntryById(id);
				cartItem.setGoodsId(goods.getId());
				cartItem.setGoodsName(goods.getName());
				cartItem.setPicLocation(goods.getPicLocation());
				cartItem.setUnitPrice(goods.getUnitPrice());
				cartItem.setAmount(1);
				cartItem.setTotalPrice(goods.getUnitPrice());
				cartItem.setGoodsType("3");
			} else {
				
			}
			this.cartItemDao.saveEntry(cartItem);
		}
		return "redirect:/index";
	}
	
	@RequestMapping("list")
	public String list(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loginUser");
		Cart cart = this.cartDao.getByUid(user.getId());
		List<CartItem> list = this.cartItemDao.getByCartId(cart.getId());
		model.addAttribute("list", list);
		return "cart/list";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(@RequestParam(value="id") Integer id) {
		this.cartItemDao.deleteEntry(id);
		return "yes";
	}
	
	
	
	
	
	
	
	
	
	
	
}
