<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE>
<html>
  <head>
    <title>用户修改个人信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery-1.9.0.min.js"></script>
	<style type="text/css">
		body {background-color: #f5f5f5;font-size: 16px;}
		#vLocation {height: 20px;padding: 10px 15px;list-style: none;background-color: #f1f1f1;font-size: 13px;}
		#infoDiv {width: 100%;}
		#infoTable {width: 40%;margin: 20px 0 0 30%;font-size: 16px;}
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
		当前位置&nbsp;：个人资料&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">修改个人信息</a>
	</div>
	<div id="infoDiv">
		<form id="reviseForm" action="${pageContext.request.contextPath}/user/reviseSelfInfo" method="post">
			<input type="hidden" name="id" value="${loginUser.id }"/>
			<table id="infoTable">
				<tr>
					<td class="leftTD">用户名</td>
					<td class="rightTD"><input type="text" id="username" name="username" value="${loginUser.username }"/></td>
				</tr>
				<tr>
					<td class="leftTD">密码</td>
					<td class="rightTD"><input type="password" id="password" name="password" value="${loginUser.password }"/></td>
				</tr>
				<tr>
					<td class="leftTD">确认密码</td>
					<td class="rightTD"><input type="password" id="cfmPwd" name="cfmPwd" value="${loginUser.password }"/></td>
				</tr>
				<tr>
					<td class="leftTD">邮箱</td>
					<td class="rightTD"><input type="text" id="email" name="email" value="${loginUser.email }"/></td>
				</tr>
				<tr>
					<td class="leftTD">手机号码</td>
					<td class="rightTD"><input type="text" id="phone" name="phone" value="${loginUser.phone }"/></td>
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
			var username = $("#username").val().trim();
			var password = $("#password").val().trim();
			var cfmPwd = $("#cfmPwd").val().trim();
			var email = $("#email").val().trim();
			var phone = $("#phone").val().trim();
			if (username!='' && password!='' && cfmPwd!='' && email!='' && phone!='') {
				if (password != cfmPwd) {
					alert("请确定两次填写的密码相同");
					return false;
				} else {
					$("#saveForm").submit();
				}
			} else {
				alert("请将信息填写完整");
				return false;
			}
		});
	});
  </script>
</html>
