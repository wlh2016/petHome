package com.edu.pet.dao;

import com.edu.pet.entity.Admin;

public interface AdminDao extends BaseDao<Admin> {

	Admin selectByUsernameAndPwd(String username, String password);

}
