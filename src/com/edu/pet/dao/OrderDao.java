package com.edu.pet.dao;

import java.util.List;

import com.edu.pet.entity.Order;

public interface OrderDao extends BaseDao<Order> {

	List<Order> queryAll(Order order);

	void updateOrderStatus(Integer id);

	void updateNote(String id, String note);

}
