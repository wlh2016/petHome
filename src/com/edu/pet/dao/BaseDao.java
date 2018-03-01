package com.edu.pet.dao;

import java.io.Serializable;
import java.util.List;

import com.edu.pet.util.PageBean;


public interface BaseDao<T> {
	
	public void saveEntry(T entity);
	
	public void deleteEntry(Serializable id);
	
	public T getEntryById(Serializable id);
	
	public void updateEntry(T entity);
	
	public List<T> getAllEntry();
	
	//分页查询准备
	public List<T> queryForPageList(String hql, int offset, int length);
	//总记录数
	public int getCount(String hql);
	//分页查询
	public PageBean queryForPage(int pageSize, int page, String condition);
	
}
