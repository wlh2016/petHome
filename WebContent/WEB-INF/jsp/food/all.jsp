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
		.goods {width: 1000px;height: 615px;margin: 10 auto;text-align: left;}
		.lb {background-color: rgb(204,235,247);width: 100%;height: 20px;padding: 10px 0;font-size: 16px;color: rgb(51,102,164);}
		.more {float: right;margin-right: 10px;font-size: 14px;color: #333;}
		.pets {display: inline-block;float: left;width: 300px;height: 270px;margin: 10px 0 0 25px;background-color: rgb(204,235,247);}
		.pic {width: 280px;height: 170px;margin: 10 10;}
		.info {margin: 5px 0 0 0px;text-align: center;}
		.info button {cursor: pointer;}
		.buy {display: inline-block;width: 50px;margin-left: 20px;}
	</style>
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
	 			<c:if test="${loginUser == null }">
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
		 		</c:if>
	 			<c:if test="${loginUser != null }">
	 				<p class="inp">
	 					<span class="ins"></span>
	 					<span style="margin-left: 13px;color: red;"></span>
	 				</p>
	 				<p class="inp">
	 					您好，&nbsp;<span style="color: red;">${loginUser.username }</span>&nbsp;，您已登录成功
	 				</p>
	 				<p class="inp">
	 					<a href="${pageContext.request.contextPath}/center">
	 						<c:choose>
								<c:when test="${role == '1' }">管理中心</c:when>
								<c:otherwise>个人中心</c:otherwise>
							</c:choose>
	 					</a>
	 					&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/logout" style="color: #111">退出系统</a>
	 				</p>
	 			</c:if>
		 	</div>
		 </div>
		 <div style="width: 100%;height: 40px;background-color: rgb(0,139,217);">
		 	<div style="width: 1000px;margin: 0 auto;">
		 		<a class="banner" href="${pageContext.request.contextPath}">
			 		首页
			 	</a>
			 	<a class="banner" href="${pageContext.request.contextPath}/pet/all">
			 		宠物
			 	</a>
			 	<a class="banner" href="${pageContext.request.contextPath}/food/all">
			 		零食
			 	</a>
			 	<a class="banner" href="${pageContext.request.contextPath}/ornament/all">
			 		饰品
			 	</a>
		 	</div>
		 </div>
	
		<div style="width: 1000px;height: 1870px;border: 1px solid #ccc;margin: 10px auto;">
			<div class="goods" style="margin-top: 0px;">
				<div class="lb">&nbsp;&nbsp;&nbsp;零食</div>
				<c:forEach items="${list }" var="f" varStatus="st">
					<div class="pets">
						<img alt="${f.name }" src="${pageContext.request.contextPath}/${f.picLocation }" class="pic">
						<div style="height: 70px;width: 100%;">
							<p class="info">
								<strong style="font-family: '黑体';color: #EF617E;">${f.name }</strong>
							</p>
							<p class="info">
								<span style="color: #777;font-size: 12px;">RMB: ${f.unitPrice }.00</span>
								<span style="color: #777;font-size: 12px;margin-left: 10px;">${f.weight }kg</span>
							</p>
							<p class="info">
								<c:if test="${loginUser != null && role == '0' }">
									<a href="${pageContext.request.contextPath}/order/buy/food/${f.id }"><button class="buy">购买</button></a>
									<a href="${pageContext.request.contextPath}/cart/add/food/${f.id }"><button class="buy" style="width: 80px;">加入购物车</button></a>
								</c:if>
							</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
				
		<h4 style="text-align: center;width: 100%;height: 30px;background-color: rgb(152,234,255);padding-top: 15px;color: #555;">
			版权所有 <span style="cursor: pointer;">宠物之家</span>
		</h4>
	
	</div>
	
	
	
</body>
</html>