<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>
<!DOCTYPE>
<html>
  <head>
    <title>生成订单</title>
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
		.t {width: 98%;text-align: center;margin-left: 1%;}
		#t {height: 80px;margin-top: 25px;color: #999;font-size: 16px;font-family: 楷体;font-weight: bold;}
		#t td {border-bottom: 2px solid rgb(178,209,255);}
		#content {margin-top: 20px;}
		#c td {display: inline-block;height: 120px;padding-top: 5px;font-size: 16px;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;}
		#totalPrice {color: #f66;}
		#tj {display: inline-block;height: 30px;width: 150px;;float: right;color: #fff;margin: 30px 20px 0 0;
				background-color: #f01;text-align: center;padding-top: 15px;text-decoration: none;font-size: 14px;font-family: '黑体';}
		#tj:HOVER {cursor: pointer;}
		.ss {color: #888;}
		textarea {overflow:hidden}
	</style>
  </head>
  <body>
	<div id="vLocation">
		当前位置&nbsp;：购物车管理&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">确认订单</a>
	</div>
	<div id="infoDiv">
		<form id="saveForm" action="${pageContext.request.contextPath}/order/submit" method="post">
			<div style="width: 100%;height: 800px;margin: 10px auto;">
				<div class="goods" style="margin-top: 0px;">
					<form id="saveForm" action="${pageContext.request.contextPath}/order/cartSubmit" method="post">
						<input type="hidden" name="cartItemId" value="${cartItemId }"/>
						<input type="hidden" name="from" value="1"/>
						<input type="hidden" name="orderType" value="1"/>
						<input type="hidden" name="orderStatus" value="1"/>
						<input type="hidden" name="userId" value="${loginUser.id }"/>
						<input type="hidden" name="username" value="${loginUser.username }"/>
						<input type="hidden" name="goodsId" value="${goods.id }"/>
						<input type="hidden" name="goodsType" value="${goods.goodType }"/>
						<input type="hidden" name="goodsName" value="${goods.name }"/>
						<input type="hidden" name="unitPrice" value="${goods.unitPrice }" id="unitPrice"/>
						<input type="hidden" name="totalPrice" value="${goods.unitPrice }" id="totalPrice"/>
						<input type="hidden" name="" value="${stock.amount }" id="stockAmount"/>
						<table id="content" class="t" cellpadding="0" cellspacing="0">
							<tr id="t">
								<td width="20%"></td>
								<td width="15%">商品名称</td>
								<td width="13%">单价(RMB)</td>
								<td width="13%">数量</td>
								<td width="13%">总价(RMB)</td>
								<td width="26%">备注</td>
							</tr>
							<tr><td style="height: 30px;"></td></tr>
							<tr style="padding-top: 20px;">
								<td width="20%"><img src="${pageContext.request.contextPath}/${goods.picLocation }" width="94%" height="120"/></td>
								<td width="15%">${goods.name }</td>
								<td width="13%">${goods.unitPrice }</td>
								<td width="13%">
									<input type="number" id="amount" name="amount" value="1" onchange="total()" 
										style="width: 60px;height: 30px;text-align: center;" min="1" required="required"/>
										&nbsp;&nbsp;<span style="color: #bbb;font-size: 12px;">库存：${stock.amount }</span>
								</td>
								<td width="13%"><strong id="total">${goods.unitPrice }</strong></td>
								<td width="26%"><textarea rows="5" cols="22" name="note"></textarea> </td>
							</tr>
							<tr><td style="height: 30px;border-bottom: 2px solid rgb(178,209,255);" colspan="6"></td></tr>
						</table>	
						<div style="margin-top: 10px;font-size: 14px;padding: 0 0 0 20px;">
							<span style="line-height: 40px;">请选择收货地址：</span>
							<c:forEach items="${list }" var="a">
								<p style="line-height: 35px;">
									<input type="radio" value="${a.id }" name="addressId" id="addressId" style="margin-left: 30px;"/>&nbsp;
									<span class="ss">手机：</span>${a.receivePhone }
									<span class="ss" style="margin-left: 20px;">地址：</span>${a.address }
								</p>
							</c:forEach>
						</div>
						<a onclick="submit()" id="tj">
							提交订单
						</a>
					</form>
				</div>
			</div>
		</form>
	</div>
  </body>
  <script type="text/javascript">
  
  	function submit() {
  		var stockAmount = $("#stockAmount").val();
		var amount = $("#amount").val();
		var addressId = $("input:radio[name='addressId']:checked").val();
		if (amount == '') {
			alert("请输入购买数量");
			return false;
		} else if (stockAmount < amount) {
			alert("对不起，已超出库存，目前库存: " + stockAmount);
			return false;
		} else if (addressId==null || addressId==undefined) {
			alert("请选择收货地址");
			return false;
		} else {
			$("#saveForm").submit();
		}
	}
	
	function total() {
		var unitPrice = $("#unitPrice").val();
		var amount = $("#amount").val();
		var totalPrice = unitPrice * amount;
		$("#totalPrice").val(totalPrice);
		$("#total").html(totalPrice);
	}
  	
  	function getObjectURL(file) {
  		var url = null ;
  		if (window.createObjectURL!=undefined) { // basic
  			url = window.createObjectURL(file) ;
  		} else if (window.URL!=undefined) { // mozilla(firefox)
  			url = window.URL.createObjectURL(file) ;
  		} else if (window.webkitURL!=undefined) { // webkit or chrome
  			url = window.webkitURL.createObjectURL(file) ;
  		}
  		return url ;
  	}

  </script>
</html>
