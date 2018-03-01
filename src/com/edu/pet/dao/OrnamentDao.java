package com.edu.pet.dao;

import java.util.List;

import com.edu.pet.entity.Ornament;

public interface OrnamentDao extends BaseDao<Ornament> {

	List<Ornament> queryAll(Ornament ornament);

}
