<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>
<!DOCTYPE>
<html>
  <head>
    <title>修改用户信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery-1.9.0.min.js"></script>
	<style type="text/css">
		body {background-color: #f5f5f5;font-size: 16px;}
		#vLocation {height: 20px;padding: 10px 15px;list-style: none;background-color: #f1f1f1;font-size: 13px;}
		#infoDiv {width: 100%;}
		#infoTable {width: 40%;margin: 20px 0 0 25%;font-size: 16px;}
		.leftTD {width: 130px;height: 40px;text-align: right;font-family: 微软雅黑,宋体, 'Arial Narrow', HELVETICA;}
		.rightTD {height: 40px;padding-left: 20px;text-align: left;/* font-family: 微软雅黑,宋体, 'Arial Narrow', HELVETICA;font-weight: bold; */color: #08c;}
		.rightTD input {height: 25px;}
		#subBtn {display: inline-block;width: 80px;margin-left: 30px;}
		h4 {margin: 20px 15px;color: #777;}
		textarea {overflow:hidden}
	</style>
  </head>
  <body>
	<div id="vLocation">
		当前位置&nbsp;：用户管理&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">修改用户信息</a>
	</div>
	<div id="infoDiv">
		<h4>${prompt }</h4>
		<form id="reviseForm" action="${pageContext.request.contextPath}/user/edit" method="post">
			<input type="hidden" name="id" value="${u.id }"/>
			<table id="infoTable">
				<tr>
					<td class="leftTD">用户名</td>
					<td class="rightTD"><input type="text" id="username" name="username" readonly="readonly" value="${u.username }"/></td>
				</tr>
				<tr>
					<td class="leftTD">邮箱</td>
					<td class="rightTD"><input type="text" id="email" name="email" required="required" value="${u.email }"/></td>
				</tr>
				<tr>
					<td class="leftTD">手机号码</td>
					<td class="rightTD"><input type="text" id="phone" name="phone" required="required" value="${u.phone }"/></td>
				</tr>
				<tr>
					<td class="leftTD"></td>
					<td class="rightTD"><button id="subBtn">提交</button></td>
				</tr>
			</table>
		</form>
	</div>
  </body>
  <script type="text/javascript">
  	$(function(){
  		$("#subBtn").click(function() {
			var cfm = confirm("确定要修改吗？");
			if(cfm) {
				$("#reviseForm").submit();
			} else {
				return false;
			}
		});
  	});
  </script>
</html>
