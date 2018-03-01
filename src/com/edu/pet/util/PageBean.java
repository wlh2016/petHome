package com.edu.pet.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class PageBean {
	
	@SuppressWarnings("rawtypes")
	private List list;							// 要返回的某一页的记录列表
	      
	private int allRow; 						// 总记录数
	private int totalPage; 						// 总页�?
	private int currentPage; 					// 当前�?
	private int pageSize;						// 每页记录�?
	
	@SuppressWarnings("unused")
	private boolean isFirstPage; 				// 是否为第�?�?
	@SuppressWarnings("unused")
	private boolean isLastPage;					// 是否为最后一�?
	@SuppressWarnings("unused")
	private boolean hasPreviousPage; 			// 是否有前�?�?
	@SuppressWarnings("unused")
	private boolean hasNextPage;				// 是否有下�?�?
	
	private String condition = " where 1=1";	// 查询条件
	
	public PageBean addCondition(String key, Object value) {
		if((value != null) && (value instanceof String) && (!value.equals(""))) {
			if(key.indexOf("order by") == 0) {
				this.condition += " " + key + " " + value;
				return this;
			}
			this.condition += " and " + key + " like '%" + value + "%'";
			return this;
		}
		if((value != null) && (value instanceof Long)) {
			Long i = 0L;
			if(value != i) {
				this.condition += " and " + key + " = " + value;
				return this;
			}
		}
		if((value != null) && (value instanceof Integer)) {
			Integer i = 0;
			if(value != i) {
				this.condition += " and " + key + " = " + value;
				return this;
			}
		}
		if((value != null) && (value instanceof Date)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			this.condition += " and " + key + "'" + sdf.format(value) + "'";
			return this;
		}
		if((value != null) && (value instanceof Boolean)) {
			this.condition += " and " + key + " = " + value;
			return this;
		}
		return this;
	}
	
	@SuppressWarnings("rawtypes")
	public List getList() {
	    return list;
	}
	
	@SuppressWarnings("rawtypes")
	public void setList(List list) {
	    this.list = list;
	}
	
	public int getAllRow() {
	     return allRow;
	}
	
	public void setAllRow(int allRow) {
	    this.allRow = allRow;
	}
	
	public int getTotalPage() {
	    return totalPage;
	}
	 
	public void setTotalPage(int totalPage) {
	     this.totalPage = totalPage;
	}
	
	public int getCurrentPage() {
	     return currentPage;
	}
	
	public void setCurrentPage(int currentPage) {
	     this.currentPage = currentPage;
	}
	
	public int getPageSize() {
	    return pageSize;
	}
	
	public void setPageSize(int pageSize) {
	     this.pageSize = pageSize;
	}
	
	/**
	 * 初始化分页信�?
	 */
	public void init() {
	     this.isFirstPage = isFirstPage();
	     this.isLastPage = isLastPage();
	     this.hasPreviousPage = isHasPreviousPage();
	     this.hasNextPage = isHasNextPage();
	}
	
	/**
	 * 以下判断页的信息,只需getter方法(is方法)即可
	 * 
	 * @return
	 */
	public boolean isFirstPage() {
	    return currentPage == 1; // 如是当前页是�?1�?
	}
	
	public boolean isLastPage() {
	    return currentPage == totalPage; // 如果当前页是�?后一�?
	}
	 
	public boolean isHasPreviousPage() {
	    return currentPage != 1;// 只要当前页不是第1�?
	}
	
	public boolean isHasNextPage() {
	    return currentPage != totalPage; // 只要当前页不是最�?1�?
	}
	
	/**
	 * 计算总页�?,静�?�方�?,供外部直接�?�过类名调用
	 * 
	 * @param pageSize每页记录�?
	 * @param allRow总记录数
	 * @return 总页�?
	 */
	public static int countTotalPage(final int pageSize, final int allRow) {
	    int totalPage = allRow % pageSize == 0 ? allRow / pageSize : allRow / pageSize + 1;
	    return totalPage;
	}
	
	/**
	 * 计算当前页开始记�?
	 * 
	 * @param pageSize每页记录�?
	 * @param currentPage当前第几�?
	 * @return 当前页开始记录号
	 */
	public static int countOffset(final int pageSize, final int currentPage) {
	    final int offset = pageSize * (currentPage - 1);
	     return offset;
	}
	
	/**
	 * 计算当前�?,若为0或�?�请求的URL中没�?"?page=",则用1代替
	 * 
	 * @paramPage 传入的参�?(可能为空,�?0,则返�?1)
	 * @return 当前�?
	 */
	public static int countCurrentPage(int page) {
	    final int curPage = (page == 0 ? 1 : page);
	    return curPage;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
	
}
