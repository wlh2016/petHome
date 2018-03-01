package com.edu.pet.dao;

import com.edu.pet.entity.Stock;

public interface StockDao extends BaseDao<Stock> {

	Stock getByPidAndGoodsType(Integer goodsId, String goodsType);

	void updateAmount(Integer goodsId, Integer goodsType, Integer amount);

}
