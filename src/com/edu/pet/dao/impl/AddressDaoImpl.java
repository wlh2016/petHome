package com.edu.pet.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.AddressDao;
import com.edu.pet.entity.Address;

@Repository("addressDao")
public class AddressDaoImpl extends BaseDaoImpl<Address> implements AddressDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Address> getByUserId(Integer userId) {
		String sql = "select * from address where userId = " + userId;
		List<Address> list = this.sf.getCurrentSession().createSQLQuery(sql).addEntity(Address.class).list();
		return list;
	}

}
