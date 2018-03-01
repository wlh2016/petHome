<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>
<!DOCTYPE>
<html>
  <head>
    <title>预约</title>
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
		<c:if test="${orderType == '2' }">
			当前位置&nbsp;：预约服务&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">预约托管</a>
		</c:if>
		<c:if test="${orderType == '3' }">		
			当前位置&nbsp;：预约服务&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">预约护理</a>
		</c:if>
	</div>
	<div id="infoDiv">
		<form id="saveForm" action="${pageContext.request.contextPath}/order/submit" method="post">
			<input type="hidden" name="from" value="2"/>
			<input type="hidden" name="orderType" value="${orderType }" id="orderType"/>
			<input type="hidden" name="orderStatus" value="1"/>
			<input type="hidden" name="userId" value="${loginUser.id }"/>
			<input type="hidden" name="username" value="${loginUser.username }"/>
			<c:if test="${orderType == '2' }">
				<input type="hidden" name="goodsName" value="托管"/>
				<input type="hidden" name="unitPrice" value="200" id="unitPrice"/>
			</c:if>
			<c:if test="${orderType == '3' }">		
				<input type="hidden" name="goodsName" value="护理"/>
				<input type="hidden" name="unitPrice" value="600" id="unitPrice"/>
			</c:if>
			<table id="infoTable">
				<tr>
					<td class="leftTD">日期</td>
					<td class="rightTD"><input type="date" id="tyDateT" name="tyDateT"/></td>
				</tr>
				<tr>
					<td class="leftTD">单价</td>
					<td class="rightTD">
						<c:if test="${orderType == '2' }">200 / 天</c:if>
						<c:if test="${orderType == '3' }">600 / 次</c:if>
					</td>
				</tr>
					<tr>
						<td class="leftTD">
							<c:if test="${orderType == '2' }">天数</c:if>
							<c:if test="${orderType == '3' }">次数</c:if>
						</td>
						<td class="rightTD"><input type="number" id="amount" name="amount" width="50"/></td>
					</tr>
				<tr>
					<td class="leftTD">备注</td>
					<td class="rightTD"><textarea rows="5" cols="22" name="note"></textarea></td>
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
			var tyDateT = $("#tyDateT").val();
			var orderType = $("#orderType").val();
			var unitPrice = $("#unitPrice").val();
			if ("2" == orderType) {
				var amount = $("#amount").val();
				if (tyDateT!='' && amount!='') {
					$("#saveForm").submit();
				} else {
					alert("请将信息填写完整");
					return false;
				}
			} else {
				if (tyDateT!='') {
					$("#totalPrice").val(unitPrice);
					$("#saveForm").submit();
				} else {
					alert("请将信息填写完整");
					return false;
				}
			}
		});
  	});
  </script>
</html>
