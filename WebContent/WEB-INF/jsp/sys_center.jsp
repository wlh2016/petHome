<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>

<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>
		<c:choose>
			<c:when test="${role == '1' }">管理中心</c:when>
			<c:otherwise>个人中心</c:otherwise>
		</c:choose>
	</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/style/css/bootstrap.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery-1.9.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/style/js/bootstrap.min.js"></script>
	<style type="text/css">
		.header { width: 100%; height: 50px; background-color: #A4E5AF;}
		#sysName {display: inline-block;margin: 20px 0 0 20px;color: rgb(0,136,204); font-style: italic;}
		.header-right {float: right; padding-left: 50px; margin: 26px 20px 0 0;}
		#mainDiv {background: #ccc;}
		.mainFrame {height: 100%;float: left;}
		#ucLeft {width: 220px;border-right: 1px solid #ccc;}
		#ucRight {background: #eee;}
	</style>
</head>
<body>
	<!-- 顶部 -->
	<div class="header">
		<%-- <img src="${pageContext.request.contextPath}/style/images/syscenter/sfrobot_sys_title.png" alt="神方机器人" /> --%>
		<h4 id="sysName">宠物之家</h4>
		<div class="header-right">
			<c:if test="${role == '0' }"><a href="${pageContext.request.contextPath}/index" style="color: #f66;">前往首页购物</a> &nbsp;&nbsp;</c:if>
			<i class="icon-user icon-white"></i> <a href="javascript:void(0)">您好，${loginUser.username }</a> &nbsp;&nbsp;
			<i class="icon-question-sign icon-white"></i> <a href="javascript:void(0)">帮助</a> &nbsp;&nbsp;
			<i class="icon-off icon-white"></i> <a id="modal-973558" href="#modal-container-973558" role="button" data-toggle="modal">注销</a>
			<div id="modal-container-973558" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width:300px; margin-left:-150px; top:30%">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"aria-hidden="true">×</button>
					<h3 id="myModalLabel">Exit</h3>
				</div>
				<div class="modal-body">
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<a class="btn btn-primary" style="line-height:20px;" href="${pageContext.request.contextPath}/logout">退出</a>
					<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 主体部分 -->
	<div id="mainDiv">
		<iframe class="mainFrame" id="ucLeft" src="${pageContext.request.contextPath}/sysMenu" scrolling="auto" frameborder="0"></iframe>
		<iframe class="mainFrame" id="ucRight" name="contentFrame" src="${pageContext.request.contextPath}/sysIndex" scrolling="auto" frameborder="0"></iframe>
	</div>
	
	<script type="text/javascript">
		$(function(){
			if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
				winHeight = document.documentElement.clientHeight;
				winWidth = document.documentElement.clientWidth;
				mainDiv_height = winHeight - 100;
				mainDiv_width = winWidth;
				ucRight_width = mainDiv_width - 221;
				$("#mainDiv").css("height", mainDiv_height + "px");
				$("#mainDiv").css("width", mainDiv_width + "px");
				$("#ucRight").css("width", ucRight_width + "px");
			}
		});
	</script>
</body>
</html>

