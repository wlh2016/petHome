package com.edu.pet.controller;

import java.io.File;
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

import com.edu.pet.dao.PetDao;
import com.edu.pet.dao.StockDao;
import com.edu.pet.entity.Pet;
import com.edu.pet.entity.Stock;

@Controller
@RequestMapping("pet")
public class PetController {
	
	@Autowired
	private PetDao petDao;
	
	@Autowired
	private StockDao stockDao;
	
	@RequestMapping("list")
	public String list(Pet pet, Model model) {
		if (pet.getName() != null) {
			model.addAttribute("name", pet.getName());
		}
		List<Pet> list = this.petDao.queryAll(pet);
		model.addAttribute("list", list);
		return "pet/pets";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(@RequestParam(value="id") Integer id) {
		this.petDao.deleteEntry(id);
		return "yes";
	}
	
	@RequestMapping(value="edit/{pid}", method=RequestMethod.GET)
	public String edit(@PathVariable(value="pid") Integer pid, Model model) {
		model.addAttribute("p", this.petDao.getEntryById(pid));
		Stock s = this.stockDao.getByPidAndGoodsType(pid, "1");
		model.addAttribute("stock", s);
		return "pet/edit";
	}
	
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String update(Pet pet, @RequestParam(value = "file", required = false) MultipartFile file, 
			HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("/") + "img/pet";
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        try {  
            file.transferTo(targetFile);
            pet.setPicLocation("img/pet/" + fileName);
        } catch (Exception e) {  
            e.printStackTrace();
        }
		this.petDao.updateEntry(pet);
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
        stock.setGoodsId(pet.getId());
        stock.setGoodsType(pet.getGoodType());
        this.stockDao.updateEntry(stock);
		return "redirect:/pet/list";
	}
	
	@RequestMapping(value="add", method=RequestMethod.GET)
	public String add() {
		return "pet/add";
	}
	
	@RequestMapping(value="add", method=RequestMethod.POST)
	public String save(Pet pet, @RequestParam(value = "file", required = false) MultipartFile file, 
			HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/") + "img/pet";
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        try {  
            file.transferTo(targetFile);
            pet.setPicLocation("img/pet/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pet.setGoodType("1");
        this.petDao.saveEntry(pet);
        Integer amount = Integer.parseInt(request.getParameter("amount"));
        String storeNum = request.getParameter("storeNum");
        String areaNum = request.getParameter("areaNum");
        String placeNum = request.getParameter("placeNum");
        Stock stock = new Stock();
        stock.setAmount(amount);
        stock.setStoreNum(storeNum);
        stock.setAreaNum(areaNum);
        stock.setPlaceNum(placeNum);
        List<Pet> list = this.petDao.getAllEntry();
        int pid = list.get(list.size()-1).getId();
        stock.setGoodsId(pid);
        stock.setGoodsType(pet.getGoodType());
        this.stockDao.saveEntry(stock);
		return "redirect:/pet/list";
	}
	
	@RequestMapping("all")
	public String all(Model model) {
		List<Pet> list = this.petDao.getAllEntry();
		model.addAttribute("list", list);
		return "pet/all";
	}
	
	
	
	
	
	
	
}
