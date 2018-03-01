package com.edu.pet.dao;

import java.util.List;

import com.edu.pet.entity.CartItem;

public interface CartItemDao extends BaseDao<CartItem> {

	List<CartItem> getByCartId(Integer cartId);

	boolean queryExit(Integer cartId, Integer goodsId, String goodsType);

}
