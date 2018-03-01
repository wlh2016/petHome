package com.edu.pet.util;

import java.io.Serializable;

public class JsonResult implements Serializable {

	private static final long serialVersionUID = 1L;

	private boolean success;
	private String msg;
	private Object obj;

	public JsonResult(boolean success, String msg, Object obj) {
		super();
		this.success = success;
		this.msg = msg;
		this.obj = obj;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	@Override
	public String toString() {
		return "Json [success=" + success + ", msg=" + msg + ", obj=" + obj
				+ "]";
	}

}
