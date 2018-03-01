package com.edu.pet.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.pet.dao.AddressDao;
import com.edu.pet.dao.CartItemDao;
import com.edu.pet.dao.FoodDao;
import com.edu.pet.dao.OrderDao;
import com.edu.pet.dao.OrnamentDao;
import com.edu.pet.dao.PetDao;
import com.edu.pet.dao.StockDao;
import com.edu.pet.entity.Address;
import com.edu.pet.entity.CartItem;
import com.edu.pet.entity.Food;
import com.edu.pet.entity.Order;
import com.edu.pet.entity.Ornament;
import com.edu.pet.entity.Pet;
import com.edu.pet.entity.Stock;
import com.edu.pet.entity.User;

@Controller
@RequestMapping("order")
public class OrderController {

	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private PetDao petDao;
	
	@Autowired
	private FoodDao foodDao;
	
	@Autowired
	private OrnamentDao ornamentDao;
	
	@Autowired
	private AddressDao addressDao;
	
	@Autowired
	private CartItemDao cartItemDao;
	
	@Autowired
	private StockDao stockDao;
	
	@RequestMapping("list")
	public String list(Order order, Model model) {
		if (order.getGoodsName() != null) {
			model.addAttribute("goodsName", order.getGoodsName());
		}
		List<Order> list = this.orderDao.queryAll(order);
		model.addAttribute("list", list);
		return "order/list";
	}
	
	@RequestMapping("cancel/{id}")
	@ResponseBody
	public String cancel(@PathVariable(value="id") Integer id) {
		this.orderDao.updateOrderStatus(id);
		return "yes";
	}
	
	@RequestMapping("note")
	@ResponseBody
	public String note(HttpServletRequest request) {
		String id = request.getParameter("id");
		String note = request.getParameter("note");
		this.orderDao.updateNote(id, note);
		return "yes";
	}
	
	@RequestMapping("buy/{type}/{id}")
	public String buy(@PathVariable(value="type") String type, @PathVariable(value="id") Integer id, 
			HttpSession session, Model model) {
		Stock stock = null;
		if ("pet".equals(type)) {
			Pet goods = this.petDao.getEntryById(id);
			model.addAttribute("goods", goods);
			stock = this.stockDao.getByPidAndGoodsType(goods.getId(), goods.getGoodType());
		}
		if ("food".equals(type)) {
			Food goods = this.foodDao.getEntryById(id);
			model.addAttribute("goods", goods);
			stock = this.stockDao.getByPidAndGoodsType(goods.getId(), goods.getGoodType());
		}
		if ("ornament".equals(type)) {
			Ornament goods = this.ornamentDao.getEntryById(id);
			model.addAttribute("goods", goods);
			stock = this.stockDao.getByPidAndGoodsType(goods.getId(), goods.getGoodType());
		}
		model.addAttribute("stock", stock);
		User loginUser = (User) session.getAttribute("loginUser");
		List<Address> list = this.addressDao.getByUserId(loginUser.getId());
		model.addAttribute("list", list);
		return "order/makeOrder";
	}
	
	@RequestMapping("submit")
	public String submit(Order order, HttpServletRequest request) {
		order.setCheckTime(new Date());
		//托管和护理订单
		if ((order.getOrderType() == 2) || (order.getOrderType() == 3)) {
			String tyDateT = request.getParameter("tyDateT");
			try {
				order.setTyDate(new SimpleDateFormat("yyyy-MM-dd").parse(tyDateT));
				order.setTgTianShu(order.getAmount());
				order.setTotalPrice(order.getUnitPrice() * order.getAmount());
				this.orderDao.saveEntry(order);
				this.stockDao.updateAmount(order.getGoodsId(), order.getGoodsType(), order.getAmount());
				return "redirect:/order/self";
			} catch (ParseException e) {
				order.setTyDate(null);
				e.printStackTrace();
			}
		}
		this.orderDao.saveEntry(order);
		this.stockDao.updateAmount(order.getGoodsId(), order.getGoodsType(), order.getAmount());
		String from = request.getParameter("from");
		if (from != null) {
			if ("1".equals(from)) {
				this.cartItemDao.deleteEntry(Integer.parseInt(request.getParameter("cartItemId")));
			}
			return "redirect:/order/self";
		}
		return "redirect:/index";
	}
	
	@RequestMapping("fromCart/{cartItemId}")
	public String fromCart(@PathVariable(value="cartItemId") Integer cartItemId, Model model, HttpSession session) {
		CartItem cartItem = this.cartItemDao.getEntryById(cartItemId);
		Integer id = cartItem.getGoodsId();
		String goodsType = cartItem.getGoodsType();
		if ("1".equals(goodsType)) {
			Pet goods = this.petDao.getEntryById(id);
			model.addAttribute("goods", goods);
		}
		if ("2".equals(goodsType)) {
			Food goods = this.foodDao.getEntryById(id);
			model.addAttribute("goods", goods);
		}
		if ("3".equals(goodsType)) {
			Ornament goods = this.ornamentDao.getEntryById(id);
			model.addAttribute("goods", goods);
		}
		User loginUser = (User) session.getAttribute("loginUser");
		List<Address> list = this.addressDao.getByUserId(loginUser.getId());
		model.addAttribute("list", list);
		model.addAttribute("cartItemId", cartItemId);
		Stock stock = this.stockDao.getByPidAndGoodsType(id, goodsType);
		model.addAttribute("stock", stock);
		return "order/cartOrder";
	}
	
	@RequestMapping("cartSubmit")
	public String cartSubmit(Order order, @RequestParam(value="cartItemId") Integer cartItemId) {
		order.setCheckTime(new Date());
		this.orderDao.saveEntry(order);
		this.cartItemDao.deleteEntry(cartItemId);
		this.stockDao.updateAmount(order.getGoodsId(), order.getGoodsType(), order.getAmount());
		return "redirect:/cart/list";
	}
	
	@RequestMapping("self")
	public String self(Order order, Model model, HttpSession session) {
		if (order.getGoodsName() != null) {
			model.addAttribute("goodsName", order.getGoodsName());
		}
		User loginUser = (User) session.getAttribute("loginUser");
		order.setUserId(loginUser.getId());
		List<Order> list = this.orderDao.queryAll(order);
		model.addAttribute("list", list);
		return "order/self";
	}
	
	
	
	
}
