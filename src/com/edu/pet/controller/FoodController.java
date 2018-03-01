package com.edu.pet.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.edu.pet.dao.FoodDao;
import com.edu.pet.dao.StockDao;
import com.edu.pet.entity.Food;
import com.edu.pet.entity.Stock;

@Controller
@RequestMapping("food")
public class FoodController {
	
	@Autowired
	private FoodDao foodDao;
	
	@Autowired
	private StockDao stockDao;
	
	@RequestMapping("list")
	public String list(Food food, Model model) {
		if (food.getName() != null) {
			model.addAttribute("name", food.getName());
		}
		List<Food> list = this.foodDao.queryAll(food);
		model.addAttribute("list", list);
		return "food/list";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(@RequestParam(value="id") Integer id) {
		this.foodDao.deleteEntry(id);
		return "yes";
	}
	
	@RequestMapping(value="edit/{fid}", method=RequestMethod.GET)
	public String edit(@PathVariable(value="fid") Integer fid, Model model) {
		model.addAttribute("f", this.foodDao.getEntryById(fid));
		Stock s = this.stockDao.getByPidAndGoodsType(fid, "2");
		model.addAttribute("stock", s);
		return "food/edit";
	}
	
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String update(Food food, @RequestParam(value = "file", required = false) MultipartFile file, 
			HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("/") + "img/food";
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        try {  
            file.transferTo(targetFile);
            food.setPicLocation("img/food/" + fileName);
        } catch (Exception e) {  
            e.printStackTrace();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
			Date productionDate = sdf.parse(request.getParameter("productionDateT"));
			food.setProductionDate(productionDate);
			Date effectiveDate = sdf.parse(request.getParameter("effectiveDateT"));
			food.setEffectiveDate(effectiveDate);
		} catch (ParseException e) {
			food.setProductionDate(null);
			food.setEffectiveDate(null);
			e.printStackTrace();
		}
		this.foodDao.updateEntry(food);
		Integer sid = Integer.parseInt(request.getParameter("sid"));
		Integer amount = Integer.parseInt(request.getParameter("amount"));
        String storeNum = request.getParameter("storeNum");
        String areaNum = request.getParameter("areaNum");
        String placeNum = request.getParameter("placeNum");
        Stock stock = new Stock();
        stock.setId(sid);
        stock.setAmount(amount);
        stock.setStoreNum(storeNum);
        stock.setAreaNum(areaNum);
        stock.setPlaceNum(placeNum);
        stock.setGoodsId(food.getId());
        stock.setGoodsType(food.getGoodType());
        this.stockDao.updateEntry(stock);
		return "redirect:/food/list";
	}
	
	@RequestMapping(value="add", method=RequestMethod.GET)
	public String add() {
		return "food/add";
	}
	
	@RequestMapping(value="add", method=RequestMethod.POST)
	public String save(Food food, @RequestParam(value = "file", required = false) MultipartFile file, 
			HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/") + "img/food";
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        try {  
            file.transferTo(targetFile);
            food.setPicLocation("img/food/" + fileName);
        } catch (Exception e) {  
            e.printStackTrace();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
			Date productionDate = sdf.parse(request.getParameter("productionDateT"));
			food.setProductionDate(productionDate);
			Date effectiveDate = sdf.parse(request.getParameter("effectiveDateT"));
			food.setEffectiveDate(effectiveDate);
		} catch (ParseException e) {
			food.setProductionDate(null);
			food.setEffectiveDate(null);
			e.printStackTrace();
		}
        food.setGoodType("2");
        this.foodDao.saveEntry(food);
        Integer amount = Integer.parseInt(request.getParameter("amount"));
        String storeNum = request.getParameter("storeNum");
        String areaNum = request.getParameter("areaNum");
        String placeNum = request.getParameter("placeNum");
        Stock stock = new Stock();
        stock.setAmount(amount);
        stock.setStoreNum(storeNum);
        stock.setAreaNum(areaNum);
        stock.setPlaceNum(placeNum);
        List<Food> list = this.foodDao.getAllEntry();
        int pid = list.get(list.size()-1).getId();
        stock.setGoodsId(pid);
        stock.setGoodsType(food.getGoodType());
        this.stockDao.saveEntry(stock);
		return "redirect:/food/list";
	}
	
	@RequestMapping("all")
	public String all(Model model) {
		List<Food> list = this.foodDao.getAllEntry();
		model.addAttribute("list", list);
		return "food/all";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
