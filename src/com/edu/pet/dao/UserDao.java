package com.edu.pet.dao;

import java.util.List;

import com.edu.pet.entity.User;

public interface UserDao extends BaseDao<User> {

	User selectByUsernameAndPwd(String username, String password);

	List<User> queryByUsername(String username);

	void updateUser(User user);

}
