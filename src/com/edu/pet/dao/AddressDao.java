package com.edu.pet.dao;

import java.util.List;

import com.edu.pet.entity.Address;

public interface AddressDao extends BaseDao<Address> {

	List<Address> getByUserId(Integer userId);

}
