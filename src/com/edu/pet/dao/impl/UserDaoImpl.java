package com.edu.pet.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.UserDao;
import com.edu.pet.entity.User;

@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {

	@Override
	public User selectByUsernameAndPwd(String username, String password) {
		return (User) this.sf.getCurrentSession().createSQLQuery("select * from user where username = '" + username + "' and password = '" + password + "'").addEntity(User.class).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> queryByUsername(String username) {
		String sql = "select * from user where username like '%" + username + "%'";
		List<User> list = this.sf.getCurrentSession().createSQLQuery(sql).addEntity(User.class).list();
		return list;
	}

	@Override
	public void updateUser(User user) {
		String sql = "update user set email = '" + user.getEmail() + "', phone = '" + user.getPhone() + "' where id = " + user.getId();
		this.sf.getCurrentSession().createSQLQuery(sql).executeUpdate();
	}

}
