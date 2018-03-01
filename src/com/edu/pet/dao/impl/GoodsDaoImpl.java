package com.edu.pet.dao.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.edu.pet.dao.GoodsDao;

@Repository("goods")
public class GoodsDaoImpl implements GoodsDao {
	
	@Autowired
	private SessionFactory sf;
	
	
	
	
	
	
	
	
	
	
}
