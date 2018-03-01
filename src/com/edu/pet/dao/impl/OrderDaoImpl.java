package com.edu.pet.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.OrderDao;
import com.edu.pet.entity.Order;

@Repository("orderDao")
public class OrderDaoImpl extends BaseDaoImpl<Order> implements OrderDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Order> queryAll(Order order) {
		String sql = "SELECT * FROM `orders` WHERE 1=1 ";
		if (order.getGoodsName() != null) {
			sql += " and goodsName LIKE '%" + order.getGoodsName() + "%'";
		}
		if (order.getUserId() != null) {
			sql += " and userId = " + order.getUserId() + "";
		}
		List<Order> list = this.sf.getCurrentSession().createSQLQuery(sql).addEntity(Order.class).list();
		return list;
	}

	@Override
	public void updateOrderStatus(Integer id) {
		this.sf.getCurrentSession().createSQLQuery("UPDATE `orders` SET orderStatus = 2 where id = " + id).executeUpdate();
	}

	@Override
	public void updateNote(String id, String note) {
		this.sf.getCurrentSession().createSQLQuery("UPDATE `orders` SET note = '" + note + "' where id = " + id).executeUpdate();
	}

}
