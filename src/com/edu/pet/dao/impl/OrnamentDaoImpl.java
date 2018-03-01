package com.edu.pet.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.OrnamentDao;
import com.edu.pet.entity.Ornament;

@Repository("ornamentDao")
public class OrnamentDaoImpl extends BaseDaoImpl<Ornament> implements OrnamentDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Ornament> queryAll(Ornament ornament) {
		String sql = "select * from ornament where name like '%" + (ornament.getName()==null ? "":ornament.getName()) + "%'";
		List<Ornament> list = this.sf.getCurrentSession().createSQLQuery(sql).addEntity(Ornament.class).list();
		return list;
	}

}
