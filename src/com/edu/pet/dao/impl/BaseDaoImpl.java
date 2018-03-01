package com.edu.pet.dao.impl;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import com.edu.pet.util.PageBean;

@Transactional
public class BaseDaoImpl<T> implements com.edu.pet.dao.BaseDao<T> {
	
	private Class<T> classt;
	/**
	 * 1、在父类中要执行�?段代码，这个代码的执行时间为子类创建对象的时候，这段代码已经执行完了，根据这个需求，有两种方案供选择
	 *      *  利用static语句�?
	 *      *  利用父类的构造函�?
	 * 2、分析：
	 *      因为得到ParameterizedType�?要用到this关键字，而this关键字不能出现在static语句块中
	 *    �?以只能�?�择父类的构造器
	 */
	@SuppressWarnings("unchecked")
	public BaseDaoImpl(){
		ParameterizedType type = (ParameterizedType)this.getClass().getGenericSuperclass();
		this.classt = (Class<T>)type.getActualTypeArguments()[0];
	}
	
	@Resource(name="sessionFactory")
	protected SessionFactory sf;
	
	protected Session getSession() {
		return sf.getCurrentSession();
	}

	public void saveEntry(T entity) {
		this.getSession().save(entity);
	}

	public void deleteEntry(Serializable id) {
		T entity = this.getEntryById(id);
		if(entity != null) this.getSession().delete(entity);
	}

	@SuppressWarnings("unchecked")
	public T getEntryById(Serializable id) {
		return (T) this.getSession().get(this.classt, id);
	}

	public void updateEntry(T entity) {
		this.getSession().update(entity);
	}

	@SuppressWarnings("unchecked")
	public List<T> getAllEntry() {
		return this.getSession().createQuery("From " + this.classt.getSimpleName()).list();
	}

	//分页查询准备
	@SuppressWarnings("unchecked")
	public List<T> queryForPageList(String hql, int offset, int length) {
		Query q = this.getSession().createQuery(hql);
		q.setFirstResult(offset);
		q.setMaxResults(length);
		return q.list();
	}

	//总记录数
	public int getCount(String hql) {
		Query q = this.getSession().createQuery(hql);
		return Integer.parseInt(q.list().get(0).toString());	//q.list().get(0)的返回�?�为long，所以要转换�?�?
	}

	//分页查询
	public PageBean queryForPage(int pageSize, int page, String condition) {
		String hql = "select count(*) from " + this.classt.getSimpleName() + condition;
		int count = this.getCount(hql);	//总记录数
		int totalPage = PageBean.countTotalPage(pageSize, count);	//总页�?
		int offset = PageBean.countOffset(pageSize, page);	//当前页开始记�?
		int length = pageSize;	//每页记录�?
		int currentPage = PageBean.countCurrentPage(page);
		List<T> list = this.queryForPageList(
				"from " + this.classt.getSimpleName() + condition, offset, length);	//该分页的记录
		//把分页信息保存到PageBean�?
		PageBean pageBean = new PageBean();
		pageBean.setPageSize(pageSize);
		pageBean.setCurrentPage(currentPage);
		pageBean.setAllRow(count);
		pageBean.setTotalPage(totalPage);
		pageBean.setList(list);
		pageBean.init();
		return pageBean;
	}
	
	
	

}
