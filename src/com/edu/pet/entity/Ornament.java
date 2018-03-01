package com.edu.pet.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

@Entity
@Table(name = "ornament")
public class Ornament extends Goods {

	private static final long serialVersionUID = 1L;

	private Integer id;
	private String name;
	private Date productionDate;
	private String productionMaterial;
	private Integer unitPrice;
	private String picLocation;
	private String introduction;
	private String note;
	private String goodType;
	
	public String getGoodType() {
		return goodType;
	}

	public void setGoodType(String goodType) {
		this.goodType = goodType;
	}
	
	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Type(type = "date")
	public Date getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
	}

	public String getProductionMaterial() {
		return productionMaterial;
	}

	public void setProductionMaterial(String productionMaterial) {
		this.productionMaterial = productionMaterial;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getPicLocation() {
		return picLocation;
	}

	public void setPicLocation(String picLocation) {
		this.picLocation = picLocation;
	}

	@Override
	public String toString() {
		return "Ornament [id=" + id + ", name=" + name + ", productionDate=" + productionDate + ", productionMaterial="
				+ productionMaterial + ", unitPrice=" + unitPrice + ", picLocation=" + picLocation + ", introduction="
				+ introduction + ", note=" + note + ", goodType=" + goodType + "]";
	}

}
