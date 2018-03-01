package com.edu.pet.dao.impl;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.AdminDao;
import com.edu.pet.entity.Admin;

@Repository("adminDao")
public class AdminDaoImpl extends BaseDaoImpl<Admin> implements AdminDao {

	@Override
	public Admin selectByUsernameAndPwd(String username, String password) {
		return (Admin) this.sf.getCurrentSession().createSQLQuery("select * from admin where username = '" + username + "' and password = '" + password + "'").addEntity(Admin.class).uniqueResult();
	}

}
