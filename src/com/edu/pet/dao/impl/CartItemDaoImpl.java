package com.edu.pet.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.CartItemDao;
import com.edu.pet.entity.CartItem;

@Repository("cartItem")
public class CartItemDaoImpl extends BaseDaoImpl<CartItem> implements CartItemDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<CartItem> getByCartId(Integer cartId) {
		String sql = "select * from cartItem where cartId = " + cartId;
		List<CartItem> list = this.sf.getCurrentSession().createSQLQuery(sql).addEntity(CartItem.class).list();
		return list;
	}

	@Override
	public boolean queryExit(Integer cartId, Integer goodsId, String goodsType) {
		String sql = "select * from cartItem where cartId = " + cartId + " and goodsId = " + goodsId + " and goodsType='" + goodsType + "'";
		CartItem cartItem = (CartItem) this.sf.getCurrentSession().createSQLQuery(sql).addEntity(CartItem.class).uniqueResult();
		boolean flag = (cartItem!=null ? true:false);
		return flag;
	}

}
