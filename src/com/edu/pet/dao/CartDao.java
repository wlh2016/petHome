package com.edu.pet.dao;

import com.edu.pet.entity.Cart;

public interface CartDao extends BaseDao<Cart> {

	Cart getByUid(Integer id);

}
