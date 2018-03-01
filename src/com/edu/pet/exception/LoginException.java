package com.edu.pet.exception;

/**
 * <p>Title: LoginException</p>
 * <p>Description: 鐢ㄦ埛鐧诲綍寮傚父绫�?</p>
 * @author WLH
 * @date 2016-7-19
 */
public class LoginException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	public LoginException() {
		// TODO Auto-generated constructor stub
	}
	
	public LoginException(String msg) {
		super(msg);
	}

}
