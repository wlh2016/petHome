package com.edu.pet.dao;

import java.util.List;

import com.edu.pet.entity.Food;

public interface FoodDao extends BaseDao<Food> {

	List<Food> queryAll(Food food);
	
	
	
}
