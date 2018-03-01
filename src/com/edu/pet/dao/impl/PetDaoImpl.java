package com.edu.pet.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.PetDao;
import com.edu.pet.entity.Pet;

@Repository("petDao")
public class PetDaoImpl extends BaseDaoImpl<Pet> implements PetDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Pet> queryAll(Pet pet) {
		String sql = "select * from pet where name like '%" + (pet.getName()==null ? "":pet.getName()) + "%'";
		List<Pet> pets = this.sf.getCurrentSession().createSQLQuery(sql).addEntity(Pet.class).list();
		return pets;
	}
	

}
