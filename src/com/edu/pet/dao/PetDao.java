package com.edu.pet.dao;

import java.util.List;

import com.edu.pet.entity.Pet;

public interface PetDao extends BaseDao<Pet> {

	List<Pet> queryAll(Pet pet);

}
