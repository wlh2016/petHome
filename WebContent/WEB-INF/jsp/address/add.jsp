<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>
<!DOCTYPE>
<html>
  <head>
    <title>添加地址信息</title>
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
	</style>
  </head>
  <body>
	<div id="vLocation">
		当前位置&nbsp;：个人资料&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">添加地址</a>
	</div>
	<div id="infoDiv">
		<form id="saveForm" action="${pageContext.request.contextPath}/address/save" method="post">
			<input type="hidden" name="userId" value="${loginUser.id }"/>
			<table id="infoTable">
				<tr>
					<td class="leftTD">手机</td>
					<td class="rightTD"><input type="text" id="receivePhone" name="receivePhone"/></td>
				</tr>
				<tr>
					<td class="leftTD">地址</td>
					<td class="rightTD">
						<textarea rows="5" cols="40" style="overflow: hidden;" name="address" id="address"></textarea>
					</td>
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
			var receivePhone = $("#receivePhone").val().trim();
			var address = $("#address").val().trim();
			if (receivePhone!='' && address!='') {
				$("#saveForm").submit();
			} else {
				alert("请将信息填写完整");
				return false;
			}
		});
  	});
  </script>
</html>
