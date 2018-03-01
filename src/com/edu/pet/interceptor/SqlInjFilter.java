package com.edu.pet.interceptor;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SqlInjFilter implements Filter {

	@Override
	public void destroy() {
		System.out.println("结束sql注入排查");
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		//获得所有请求参数名  
        Enumeration params = request.getParameterNames();  
        String sql = "";
        while (params.hasMoreElements()) {
        	String name = params.nextElement().toString();
        	//得到参数对应值  
            String[] value = request.getParameterValues(name);
            for (int i = 0; i < value.length; i++) {
            	sql += value[i];
            }
        }
        if (sql_inj(sql)) {
        	response.sendRedirect(request.getContextPath()+"/sqlInj.html");
		} else {
			arg2.doFilter(arg0, arg1);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		System.out.println("开始sql注入排查");
	}
	
	//输入信息过滤
	public static boolean sql_inj(String str) {
		//过滤掉的sql关键字，可以手动添加
		String inj_str = "'|and|exec|execute|insert|select|delete|update|count|drop|*|%|chr|mid|master|truncate|" +  
                "char|declare|sitename|net user|xp_cmdshell|;|or|-|+|,|like'|and|exec|execute|insert|create|drop|" +  
                "table|from|grant|use|group_concat|column_name|" +  
                "information_schema.columns|table_schema|union|where|select|delete|update|order|by|count|*|" +  
                "chr|mid|master|truncate|char|declare|or|;|-|--|+|,|like|//|/|%|#";
		String[] inj_stra = inj_str.split("\\|");
		for (int i=0 ; i < inj_stra.length ; i++ ) {
			if (str.indexOf(inj_stra[i]) >= 0) {
				return true;
			}
		}
		return false;
	}

}
