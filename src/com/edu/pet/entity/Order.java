package com.edu.pet.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(name = "orders")
public class Order implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer id;
	private Integer orderType;//1：购买商品，2：托管，3：护理
	private Integer orderStatus;//订单状态：1：正常，2：取消，3：已付款
	private Integer userId;
	private String username;
	private Integer goodsId;
	private Integer goodsType;
	private Integer addressId;
	private String goodsName;
	private Integer unitPrice;
	private Integer amount;
	private Integer totalPrice;
	private Date checkTime;
	private Date tyDate;
	private Integer tgTianShu;
	private String note;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}

	public Integer getOrderType() {
		return orderType;
	}

	public void setOrderType(Integer orderType) {
		this.orderType = orderType;
	}

	public Integer getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Integer getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(Integer goodsType) {
		this.goodsType = goodsType;
	}

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Type(type = "timestamp")
	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	@Type(type = "timestamp")
	public Date getTyDate() {
		return tyDate;
	}

	public void setTyDate(Date tyDate) {
		this.tyDate = tyDate;
	}

	public Integer getTgTianShu() {
		return tgTianShu;
	}

	public void setTgTianShu(Integer tgTianShu) {
		this.tgTianShu = tgTianShu;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "Order [id=" + id + ", orderType=" + orderType + ", orderStatus=" + orderStatus + ", userId=" + userId
				+ ", username=" + username + ", goodsId=" + goodsId + ", goodsType=" + goodsType + ", addressId="
				+ addressId + ", goodsName=" + goodsName + ", unitPrice=" + unitPrice + ", amount=" + amount
				+ ", totalPrice=" + totalPrice + ", checkTime=" + checkTime + ", tyDate=" + tyDate + ", tgTianShu="
				+ tgTianShu + ", note=" + note + "]";
	}

}
