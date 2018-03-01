package com.edu.pet.dao.impl;

import org.springframework.stereotype.Repository;

import com.edu.pet.dao.StockDao;
import com.edu.pet.entity.Stock;

@Repository("stockDao")
public class StockDaoImpl extends BaseDaoImpl<Stock> implements StockDao {

	@Override
	public Stock getByPidAndGoodsType(Integer goodsId, String goodsType) {
		Stock stock = (Stock) this.sf.getCurrentSession().createSQLQuery("select * from stock where goodsId = " + goodsId + " and goodsType = '" + goodsType + "'").addEntity(Stock.class).uniqueResult();
		return stock;
	}

	@Override
	public void updateAmount(Integer goodsId, Integer goodsType, Integer amount) {
		String sql = "update stock set amount = amount - " + amount + 
						" where goodsId = '" + goodsId + "' and goodsType = '" + goodsType + "'";
		this.sf.getCurrentSession().createSQLQuery(sql).executeUpdate();
	}

	
}
