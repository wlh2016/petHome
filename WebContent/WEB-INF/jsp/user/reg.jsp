<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>宠物之家</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery-1.9.0.min.js"></script>
	<style type="text/css">
		* {margin: 0;padding: 0;}
		a {text-decoration: none;}
		a:HOVER {text-decoration: underline;}
		#top {width: 100%;height: 140px;background-color: rgb(152,234,255);text-align: center;}
		#top_center {width: 1000px;height: 105px;margin: 0 auto;}
		.inp {width: 100%;height: 33px;}
		.inp input {background-color: #fff;}
		.ins {display: inline-block;width: 50px;}
		.banner {display: inline-block;float: left;width: 80px;height: 30px;font-size: 17px;padding-top: 10px;font-family: '黑体';color: #fff;}
		.banner:HOVER {background-color: rgb(0,127,204);cursor: pointer;}
		.row {width: 100%;height: 60px;margin: 10px 0 0 0;}
		.row input {margin-left: 40px;height: 30px;}
		.key {display: inline-block;width: 100px;font-size: 20px;text-align: right;}
		textarea {overflow:hidden}
	</style>
	<script type="text/javascript">
	
		function reg() {
			var username = $("#username").val();
			var password = $("#password").val();
			var cfmPwd = $("#cfmPwd").val();
			var email = $("#email").val();
			var phone = $("#phone").val();
			if (username=='' || password == '' || cfmPwd == '' || email == '' || phone == '') {
				alert("请将信息填写完成再提交");
				return false;
			}
			if (password != cfmPwd) {
				alert("两次输入的密码不一致，请重新输入");
				return false;
			} else {
				$("#regForm").submit();
			}
		}	
	
	</script>
</head>
<body>
	<div id="top">
		 <div style="width: 100%;height: 22px;background-color: rgb(249,249,249);padding: 10px 0 0 0;text-align: left;font-size: 12px;">
		 	<span style="margin-left: 10px;">欢迎来到宠物之家</span>
		 </div>
		 <div style="width: 100%;height: 3px;background-color: rgb(0,139,217);"></div>
		 <div id="top_center">
		 	<img alt="" src="${pageContext.request.contextPath}/img/logo.png" style="float: left;margin: 30px 0 0 0;">
		 	<div style="height: 100px;width: 400px;float: right;text-align: left;font-size: 12px;padding-top: 10px;">
	 			<form action="${pageContext.request.contextPath}/login" method="post">
	 				<p class="inp">
	 					<span class="ins">用户名</span><input type="text" name="username" required/>
	 					<span style="margin-left: 13px;color: red;">${msg }</span>
	 				</p>
	 				<p class="inp">
	 					<span class="ins">密码</span><input type="password" name="password" required/>
	 					<input type="submit" value="登录" style="width: 60px;height: 25px;margin-left: 15px;cursor: pointer;"/>
	 				</p>
	 				<p class="inp">
	 					<span class="ins">角色</span>
	 					<input type="radio" name="role" value="0" checked="checked"/>&nbsp;用户
	 					<input type="radio" name="role" value="1" style="margin-left: 20px;"/>&nbsp;管理员
	 					<a href="${pageContext.request.contextPath}/reg">
	 						<input type="button" value="注册" style="width: 60px;height: 25px;margin-left: 54px;cursor: pointer;"/>
	 					</a>
	 				</p>
	 			</form>
		 	</div>
		 </div>
		 <div style="width: 100%;height: 40px;background-color: rgb(0,139,217);">
		 	<div style="width: 1000px;margin: 0 auto;">
		 		<div class="banner">
			 		首页
			 	</div>
			 	<div class="banner">
			 		汪星人
			 	</div>
			 	<div class="banner">
			 		喵星人
			 	</div>
			 	<div class="banner">
			 		商城
			 	</div>
			 	<div class="banner">
			 		论坛
			 	</div>
		 	</div>
		 </div>
	
		<div style="text-align: center;width: 600px;height: 600px;padding-top: 15px;color: #555;margin: 20px auto;">
			<form id="regForm" action="${pageContext.request.contextPath}/reg" method="post">
				<div class="row">
					<strong class="key">用户名</strong>
					<input type="text" id="username" name="username" required="required"/>
				</div>
				<div class="row">
					<strong class="key">密码</strong>
					<input type="password" id="password" name="password" required="required"/>
				</div>
				<div class="row">
					<strong class="key">确认密码</strong>
					<input type="password" id="cfmPwd" name="cfmPwd" required="required"/>
				</div>
				<div class="row">
					<strong class="key">邮箱</strong>
					<input type="text" id="email" name="email" required="required"/>
				</div>
				<div class="row">
					<strong class="key">手机</strong>
					<input type="text" id="phone" name="phone" required="required"/>
				</div>
				<div class="row">
					<input type="button" value="提交" style="width: 100px;font-size: 16px;margin-left: 80px;cursor: pointer;" onclick="reg()"/>
				</div>
			</form>
		</div>
				
		<h4 style="text-align: center;width: 100%;height: 30px;background-color: rgb(152,234,255);padding-top: 15px;color: #555;">
			版权所有 <span style="cursor: pointer;">宠物之家</span>
		</h4>
	
	</div>
	
	
	
</body>
</html>