<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>

<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title></title>
	<style type="text/css">
		body {background-color: #fff;font-size: 16px;margin: 0;padding: 0;}
		#vLocation {height: 20px;padding: 1% 15px;list-style: none;background-color: #f1f1f1;font-size: 13px;}
		#searchDiv {width: 370px;height: 25px;display: inline-block;float: right;position: relative;padding-top: 15px;}
		#search {font-size: 18px;font-family: 楷体;color: RGB(221,85,68);display: inline-block;}
		#searchForm {display: inline-block;position: absolute;top: 10px;}
		#searchPng {float: right;margin-top:-8px;}
		#searchPng:HOVER {cursor: pointer;}
		.t {width: 98%;text-align: center;}
		#title {font-size: 15px;margin-left: 1%;margin-top: 5px;border-bottom: 1px solid #999;color: #999;font-family: 楷体;}
		#title tr {height: 30px;font-weight: bold;}
		#content {margin-left: 1%;}
		#content tr td {display: inline-block;height: 60px;padding-top: 5px;font-size: 13px;border-bottom: 1px solid #ddd;
						white-space: nowrap;text-overflow: ellipsis;overflow: hidden;}
		.word {line-height: 50px;}				
		.reviseColor {background-color: rgb(218,255,218);color: rgb(0,136,204);}
		#paging {font-family: verdana,arial,sans-serif;font-size: 13px;color: #666;width: 96%;padding-top: 15px;padding-left: 10px;}
		#paging td {text-align: right;}
		#paging td a {text-decoration: underline;color: #00f;}
		#paging td a:HOVER {color: #f00;}
		.number {color: #00f;}
		a {text-decoration: none;color: rgb(27,49,66);}
		a:HOVER {text-decoration: none;color: red;}
		.pic {width: 60%;height: 85px;margin: 0 0 5px 10%;}
		textarea {overflow:hidden}
	</style>
  </head>
  <body>
    <div id="mainContent">
		<div id="vLocation">
			当前位置：订单管理 / <a href="javascript:void(0)" style="color: #0088cc;">订单列表</a>
		</div>
		
		<div id="searchDiv">
			<div id="search">Search&nbsp;&nbsp;</div>
			<form id="searchForm" action="${pageContext.request.contextPath}/order/list" method="post">
				<input id="searchName" name="goodsName" type="text" placeholder="请输入商品名称" style="height: 24px;" value="${goodsName }"/>
				<input type="submit" value="搜索" style="margin-left: 15px;cursor: pointer;"/>
			 </form>
		</div>
		
		<table id="title" class="t" cellpadding="0" cellspacing="0">
			<tr>
				<td width="3%">序号</td>
				<td width="10%">商品名称</td>
				<td width="7%">单价(RMB)</td>
				<td width="5%">数量</td>
				<td width="10%">总价</td>
				<td width="10%">下单用户</td>
				<td width="12%">下单时间</td>
				<td width="18%">订单类型</td>
				<td width="15%">备注</td>
				<td width="10%">操作</td>
			</tr>
		</table>
		
		<table id="content" class="t" cellpadding="0" cellspacing="0">
				<c:if test="${list.size() == 0 }">
					<tr><td style="color: red;font-weight: bold;width: 100%;line-height: 80px;">未查询到订单信息</td></tr>
				</c:if>
				<c:if test="${list.size() > 0 }">
					<c:forEach items="${list }" var="o" varStatus="st">
						<tr>
							<td width="3%"><span class="word">${st.index + 1 }</span></td>
							<td width="10%" title="${o.goodsName }">
								<c:if test="${o.orderType == '1'}">
									<span style="color: #f66;font-weight: bold;cursor: pointer;">${o.goodsName }</span>
								</c:if>
								<c:if test="${o.orderType == '2'}"><br>托管<br><span style="color: #aaa;">&nbsp;用户：${o.username }</span></c:if>
								<c:if test="${o.orderType == '3'}"><br>护理<br><span style="color: #aaa;">&nbsp;用户：${o.username }</span></c:if>
							</td>
							<td width="7%"><span class="word">${o.unitPrice }</span></td>
							<td width="5%"><span class="word">${o.amount }</span></td>
							<td width="10%"><span class="word">${o.totalPrice }</span></td>
							<td width="10%"><span class="word">${o.username }</span></td>
							<td width="12%"><span class="word"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${o.checkTime }"/></span></td>
							<td width="18%">
								<c:choose>
									<c:when test="${o.orderType == '2'}">
										<br>托管:<span style="color: #f33;">${o.tgTianShu }</span>&nbsp;天<br>
										<span>开始日期：<fmt:formatDate pattern="yyyy-MM-dd" value="${o.tyDate }"/></span><br>
									</c:when>
									<c:when test="${o.orderType == '3'}">
										<br>护理:<span style="color: #f33;">${o.amount }</span>&nbsp;次<br>
										<span>日期：<fmt:formatDate pattern="yyyy-MM-dd" value="${o.tyDate }"/></span>
									</c:when>
									<c:otherwise>
										<br><span>购物</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td width="15%"><span title="${o.note }" class="word" style="cursor: pointer;">${o.note }</span></td>
							<td width="10%">
								<c:if test="${o.orderStatus == 1 }">
									<span class="word">
										<a onclick="note(${o.id})" title="添加备注">
											<img src="${pageContext.request.contextPath}/style/images/edit.png" border="0" style="CURSOR: hand;margin-top: -8px;">
										</a>
									</span>
									<span class="word">
										<a onclick="cancel(${o.id})" title="取消订单">
											<img src="${pageContext.request.contextPath}/style/images/delete.png" border="0" style="CURSOR: hand;margin-top: -6px;margin-left: 20px;">
										</a>
									</span>
								</c:if>
								<c:if test="${o.orderStatus == 2 }">
									<br>已取消
								</c:if>
								
							</td>
						</tr>
					</c:forEach>
				</c:if>
		</table>
	</div>
  </body>
  
  <script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery-1.9.0.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/style/js/function.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/style/js/jquery.blockUI.js"></script>
  <script type="text/javascript">
  
  	$(function(){
		altRows("content");
		reviseTdColor();
	});
  	
  	function note(id) {
		var note = prompt("请输入备注","")
		if (note!=null && note!="") {
			$.blockUI({ 
				message: "<h4>正在备注 ....</h4>", 
				css: { 
					border: '1px solid #666',
					color: '#a00',
				} 
			});
			$.ajax({
				url: '${pageContext.request.contextPath}/order/note',
				type: 'post',
				data: {id: id, note:note},
				success: function(data) {
					$.unblockUI();
					if(data=="yes"){
						window.location.reload();
					} else {
						alert("操作失败！");
					}
				},
				error: function() {
					$.unblockUI();
					alert("请求失败！");
				}
			});
		} else {
			return false;
		}
  	}	
  	
  	function cancel(id) {
		var cfm = confirm("确定取消该订单吗？");
		if(cfm){
			$.blockUI({ 
				message: "<h4>正在取消 ....</h4>", 
				css: { 
					border: '1px solid #666',
					color: '#a00',
				} 
			});
			$.ajax({
				url: "${pageContext.request.contextPath}/order/cancel/" + id,
				type: 'post',
				data: {},
				success: function(data) {
					$.unblockUI();
					if(data=="yes"){
						window.location.reload();
					} else {
						alert("操作失败！");
					}
				},
				error: function() {
					$.unblockUI();
					alert("请求失败！");
				}
			});
		}
	}
	
  	function altRows(id){
		if(document.getElementsByTagName){
			var table = document.getElementById(id);  
			var rows = table.getElementsByTagName("tr");
			for(var i = 0; i < rows.length; i++){          
				if(i % 2 == 0){
					rows[i].className = "evenrowcolor";
				} else {
					rows[i].className = "oddrowcolor";
				}      
			}
		}
	}
	
	function reviseTdColor() {
		$("#content tbody tr").mouseover(function() {
			$(this).addClass("reviseColor");
		});
		$("#content tbody tr").mouseout(function() {
			$(this).removeClass("reviseColor");
		});
	}
	
  </script>
</html>
