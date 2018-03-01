<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>

<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>System Center</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.css" />
	<style type="text/css">
		.left {height: 100%;background: rgb(247,247,247);}
		div.sdmenu{ font-size:12px;background:#ccc;color:#fff;}
		div.sdmenu div{overflow:hidden; margin-top:-1px;}
		div.sdmenu div.collapsed {height: 30px;}
		div.sdmenu div span{display:block;height:30px;line-height:30px;overflow:hidden; cursor:pointer;background: url(${pageContext.request.contextPath}/style/images/syscenter/left2.png); font-size:12px; color:#38A3D5; text-indent:30px; font-weight:bold;font-family:"microsoft yahei";}
		div.sdmenu div.collapsed span{background:#ccc;background: url(${pageContext.request.contextPath}/style/images/syscenter/left.png);font-family:"microsoft yahei"; font-size:12px; color:#333; text-indent:30px; font-weight:bold;}
		div.sdmenu div{background:#fff url(${pageContext.request.contextPath}/style/images/syscenter/left_bg.png) repeat-y right;}
		div.sdmenu div a{display:block;color:#066; background:url(${pageContext.request.contextPath}/style/images/syscenter/171.png) no-repeat 30px 4px; text-indent:50px; padding:2px 0;}
		div.sdmenu div a.current{ background:#38A3D5 url(${pageContext.request.contextPath}/style/images/syscenter/171.png) no-repeat 27px 4px; border-left:3px solid #F65241; color:#fff;}
		div.sdmenu div a:hover{background-color:#e2e2e2;color:#f00;text-decoration: underline;}
		div.sdmenu div a.current:hover{background:#38A3D5 url(${pageContext.request.contextPath}/style/images/syscenter/171.png) no-repeat 27px 4px; border-left:3px solid #F65241; color:#fff;}
		#loginInfo {width: 100%;height: 100px;background: rgb(247,247,247);}
		.infoDiv {float: left;}
		#userImg {padding: 24px 0 0 5px;}
		#userInfo {margin: 10px 0 0 5px;width: 155px;overflow: hidden;}
		.infoDiv2 {width: 155px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}
		.infoDiv3 {width: 155px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}
		.info {color: rgb(221,85,68);}
	</style>
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery-1.9.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/sdmenu.js"></script>
</head>
<body>
	<div class="left">
		<div id="loginInfo">
			<div class="infoDiv" id="userImg">
				<img alt="用户默认头像" src="${pageContext.request.contextPath}/style/images/admin_male_48.png">
			</div>
			<div class="infoDiv" id="userInfo">
				<c:if test="${role=='0'}">
					<div class="infoDiv2" style="margin-top: 10px;">用户名：<font class="info">${loginUser.username }</font></div>
					<div class="infoDiv2">用户角色：<font class="info">系统用户</font></div>
				</c:if>
				<c:if test="${role == '1' }"><br>
					<div class="infoDiv3">用户名称：<font class="info">${loginUser.username }</font></div>
					<div class="infoDiv3">用户角色：<font class="info">系统管理员</font></div>
				</c:if>
			</div>
		</div>
		<c:if test="${role == '0'}">
			<div id="my_menu" class="sdmenu">
				<div>
					<span>个人资料</span>
					<a href="${pageContext.request.contextPath}/user/userInfo" target="contentFrame">我的信息</a>
					<a href="${pageContext.request.contextPath}/user/reviseSelfInfo" target="contentFrame">修改个人信息</a>
					<a href="${pageContext.request.contextPath}/address/list" target="contentFrame">收货地址</a>
				</div>
				<div class="collapsed">
					<span>购物车</span>
					<a href="${pageContext.request.contextPath}/cart/list" target="contentFrame">查看购物车</a>
				</div>
				<div class="collapsed">
					<span>预约服务</span>
					<a href="${pageContext.request.contextPath}/service/tg" target="contentFrame">托管预约</a>
					<a href="${pageContext.request.contextPath}/service/hl" target="contentFrame">护理预约</a>
				</div>
				<div class="collapsed">
					<span>订单管理</span>
					<a href="${pageContext.request.contextPath}/order/self" target="contentFrame">订单列表</a>
				</div>
			</div>
		</c:if>
		<c:if test="${role == '1'}">
			<div id="my_menu" class="sdmenu">
				<%-- <div>
					<span>个人资料</span> 
					<a href="${pageContext.request.contextPath}/userInfo" target="contentFrame">我的信息</a>
					<a href="${pageContext.request.contextPath}/revisePwd" target="contentFrame">修改密码</a>
					<a href="${pageContext.request.contextPath}/reviseSelfInfo" target="contentFrame">修改个人信息</a>
				</div> --%>
				<div class="collapsed">
					<span>用户管理</span>
					<a href="${pageContext.request.contextPath}/user/list" target="contentFrame">用户列表</a>
					<a href="${pageContext.request.contextPath}/user/add" target="contentFrame">添加用户</a>
				</div>
				<div class="collapsed">
					<span>商品管理</span>
					<a href="${pageContext.request.contextPath}/pet/list" target="contentFrame">宠物列表</a>
					<a href="${pageContext.request.contextPath}/food/list" target="contentFrame">零食列表</a>
					<a href="${pageContext.request.contextPath}/ornament/list" target="contentFrame">饰品列表</a>
				</div>
				<div class="collapsed">
					<span>订单管理</span>
					<a href="${pageContext.request.contextPath}/order/list" target="contentFrame">订单列表</a>
				</div>
			</div>
		</c:if>
	</div>
	
	<script type="text/javascript">
		var myMenu;
		window.onload = function() {
			myMenu = new SDMenu("my_menu");
			myMenu.init();
		};
	</script>
</body>
</html>

