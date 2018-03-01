package com.edu.pet.dao.impl;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.CartDao;
import com.edu.pet.entity.Cart;

@Repository("cartDao")
public class CartDaoImpl extends BaseDaoImpl<Cart> implements CartDao {

	@Override
	public Cart getByUid(Integer id) {
		String sql = "select * from cart where userId = " + id;
		return (Cart) this.sf.getCurrentSession().createSQLQuery(sql).addEntity(Cart.class).uniqueResult();
	}

}
