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

import com.edu.pet.dao.OrnamentDao;
import com.edu.pet.dao.StockDao;
import com.edu.pet.entity.Ornament;
import com.edu.pet.entity.Stock;


@Controller
@RequestMapping("ornament")
public class OrnamentController {
	
	@Autowired
	private OrnamentDao ornamentDao;
	
	@Autowired
	private StockDao stockDao;
	
	@RequestMapping("list")
	public String list(Ornament ornament, Model model) {
		if (ornament.getName() != null) {
			model.addAttribute("name", ornament.getName());
		}
		List<Ornament> list = this.ornamentDao.queryAll(ornament);
		model.addAttribute("list", list);
		return "ornament/list";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public String delete(@RequestParam(value="id") Integer id) {
		this.ornamentDao.deleteEntry(id);
		return "yes";
	}
	
	@RequestMapping(value="edit/{oid}", method=RequestMethod.GET)
	public String edit(@PathVariable(value="oid") Integer oid, Model model) {
		model.addAttribute("o", this.ornamentDao.getEntryById(oid));
		Stock s = this.stockDao.getByPidAndGoodsType(oid, "3");
		model.addAttribute("stock", s);
		return "ornament/edit";
	}
	
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String update(Ornament ornament, @RequestParam(value = "file", required = false) MultipartFile file, 
			HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("/") + "img/ornament";
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        try {  
            file.transferTo(targetFile);
            ornament.setPicLocation("img/ornament/" + fileName);
        } catch (Exception e) {  
            e.printStackTrace();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
			Date productionDate = sdf.parse(request.getParameter("productionDateT"));
			ornament.setProductionDate(productionDate);
		} catch (ParseException e) {
			ornament.setProductionDate(null);
			e.printStackTrace();
		}
		this.ornamentDao.updateEntry(ornament);
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
        stock.setGoodsId(ornament.getId());
        stock.setGoodsType(ornament.getGoodType());
        this.stockDao.updateEntry(stock);
		return "redirect:/ornament/list";
	}
	
	@RequestMapping(value="add", method=RequestMethod.GET)
	public String add() {
		return "ornament/add";
	}
	
	@RequestMapping(value="add", method=RequestMethod.POST)
	public String save(Ornament ornament, @RequestParam(value = "file", required = false) MultipartFile file, 
			HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/") + "img/ornament";
        String fileName = file.getOriginalFilename();
        File targetFile = new File(path, fileName);
        try {  
            file.transferTo(targetFile);
            ornament.setPicLocation("img/ornament/" + fileName);
        } catch (Exception e) {  
            e.printStackTrace();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
			Date productionDate = sdf.parse(request.getParameter("productionDateT"));
			ornament.setProductionDate(productionDate);
		} catch (ParseException e) {
			ornament.setProductionDate(null);
			e.printStackTrace();
		}
        ornament.setGoodType("2");
        this.ornamentDao.saveEntry(ornament);
        Integer amount = Integer.parseInt(request.getParameter("amount"));
        String storeNum = request.getParameter("storeNum");
        String areaNum = request.getParameter("areaNum");
        String placeNum = request.getParameter("placeNum");
        Stock stock = new Stock();
        stock.setAmount(amount);
        stock.setStoreNum(storeNum);
        stock.setAreaNum(areaNum);
        stock.setPlaceNum(placeNum);
        List<Ornament> list = this.ornamentDao.getAllEntry();
        int pid = list.get(list.size()-1).getId();
        stock.setGoodsId(pid);
        stock.setGoodsType(ornament.getGoodType());
        this.stockDao.saveEntry(stock);
		return "redirect:/ornament/list";
	}
	
	@RequestMapping("all")
	public String all(Model model) {
		List<Ornament> list = this.ornamentDao.getAllEntry();
		model.addAttribute("list", list);
		return "ornament/all";
	}
	
	
	
}
