package com.edu.pet.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.FoodDao;
import com.edu.pet.entity.Food;

@Repository("foodDao")
public class FoodDaoImpl extends BaseDaoImpl<Food> implements FoodDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Food> queryAll(Food food) {
		String sql = "select * from food where name like '%" + (food.getName()==null ? "":food.getName()) + "%'";
		List<Food> list = this.sf.getCurrentSession().createSQLQuery(sql).addEntity(Food.class).list();
		return list;
	}

	

}
