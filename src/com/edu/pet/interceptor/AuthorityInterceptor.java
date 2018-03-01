package com.edu.pet.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AuthorityInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		System.out.println("访问路径是： " + request.getRequestURI());
		List<String> list;
		Object loginUser = (Object) request.getSession().getAttribute("loginUser");
		if(loginUser == null) {
			list = new ArrayList<String>();
			list.add("/petHome/index");
			list.add("/petHome/login");
			list.add("/petHome/logout");
			list.add("/petHome/reg");
			list.add("/petHome/pet/all");
			list.add("/petHome/food/all");
			list.add("/petHome/ornament/all");
			
			//得到用户请求路径
			String visitURL = request.getRequestURI();
			
			if(list.contains(visitURL)) {
				System.out.println("***************** 用户未登录，普通权限，放行  ***************** ");
				return true;
			} else {
				System.out.println("***************** 用户未登录，非法权限，拦截  *****************");
				response.sendRedirect("/petHome/NoAuth.html");
				return false;
			}
		}
		System.out.println("***************** 用户已登录，放行  ***************** ");
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}


}
