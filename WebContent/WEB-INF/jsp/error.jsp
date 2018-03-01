<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Error Page</title>
  </head>
  <body>
    <div style="width: 400px;height: 120px;margin: 200px 0 0 50%;position: relative;left: -200px;color: red;">
	    <h2 align="left" style="margin: 10 0 0 10;">${exception.message }</h2><br><br>
	    <button onclick="javacript:window.location.href='${pageContext.request.contextPath}/'" style="margin-left: 120px;cursor: pointer;">返回</button>
    </div>
  </body>
</html>
