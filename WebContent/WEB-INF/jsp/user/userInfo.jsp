<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>

<!DOCTYPE>
<html>
  <head>
    <title>我的信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery-1.9.0.min.js"></script>
	<style type="text/css">
		body {background-color: #f5f5f5;font-size: 16px;}
		#vLocation {height: 20px;padding: 10px 15px;list-style: none;background-color: #f1f1f1;font-size: 13px;}
		#infoDiv {width: 100%;}
		#infoTable {width: 40%;margin: 50px 0 0 30%;}
		.leftTD {width: 130px;height: 40px;text-align: right;font-family: 微软雅黑,宋体, 'Arial Narrow', HELVETICA;}
		.rightTD {height: 40px;padding-left: 20px;text-align: left;font-family: 微软雅黑,宋体, 'Arial Narrow', HELVETICA;font-weight: bold;color: #08c;}
		textarea {overflow:hidden}
	</style>
  </head>
  <body>
	<div id="vLocation">
		当前位置&nbsp;：个人资料&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">我的信息</a>
	</div>
	<div id="infoDiv">
		<table id="infoTable">
			<tr>
				<td class="leftTD">用户名</td>
				<td class="rightTD">${loginUser.username }</td>
			</tr>
			<tr>
				<td class="leftTD">手机</td>
				<td class="rightTD">${loginUser.phone }</td>
			</tr>
			<tr>
				<td class="leftTD">邮箱</td>
				<td class="rightTD">${loginUser.email }</td>
			</tr>
		</table>
	</div>
  </body>
</html>
