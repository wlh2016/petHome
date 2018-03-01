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
		#content tr td {display: inline-block;height: 90px;padding-top: 5px;font-size: 13px;border-bottom: 1px solid #ddd;
						white-space: nowrap;text-overflow: ellipsis;overflow: hidden;}
		.word {line-height: 80px;}				
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
			当前位置：商品管理 / <a href="javascript:void(0)" style="color: #0088cc;">宠物列表</a>
		</div>
		
		<div id="searchDiv">
			<div id="search">Search&nbsp;&nbsp;</div>
			<form id="searchForm" action="${pageContext.request.contextPath}/pet/list" method="post">
				<input id="searchName" name="name" type="text" placeholder="请输入宠物名称" style="height: 24px;" value="${name }"/>
				<input type="submit" value="搜索" style="margin-left: 15px;cursor: pointer;"/>
				<a href="${pageContext.request.contextPath}/pet/add"><input type="button" value="新增" style="margin-left: 15px;cursor: pointer;"/></a>
			 </form>
		</div>
		
		<table id="title" class="t" cellpadding="0" cellspacing="0">
			<tr>
				<td width="5%">序号</td>
				<td width="20%">图片</td>
				<td width="9%">名称</td>
				<td width="9%">年龄(月)</td>
				<td width="9%">价格(RMB)/只</td>
				<td width="9%">体重(kg)</td>
				<td width="15%">介绍</td>
				<td width="9%">备注</td>
				<td width="15%">操作</td>
			</tr>
		</table>
		
		<table id="content" class="t" cellpadding="0" cellspacing="0">
				<c:if test="${list.size() == 0 }">
					<tr><td style="color: red;font-weight: bold;width: 100%;line-height: 80px;">未查询到宠物信息</td></tr>
				</c:if>
				<c:if test="${list.size() > 0 }">
					<c:forEach items="${list }" var="p" varStatus="st">
						<tr>
							<td width="5%"><span class="word">${st.index + 1 }</span></td>
							<td width="20%">
								<img alt="" src="${pageContext.request.contextPath}/${p.picLocation }" class="pic">
							</td>
							<td width="9%" style="color: #f66;font-weight: bold;" class="word"><span class="word">${p.name }</span></td>
							<td width="9%"><span class="word">${p.age }</span></td>
							<td width="9%"><span class="word">${p.unitPrice }</span></td>
							<td width="9%"><span class="word">${p.weight }</span></td>
							<td width="15%" title="${p.introduction }" style="cursor: pointer;"><span class="word">${p.introduction }</span></td>
							<td width="9%"><span class="word">${p.note }</span></td>
							<td width="15%">
								<span class="word">
									<a href="${pageContext.request.contextPath}/pet/edit/${p.id }" title="修改宠物信息">
										<img src="${pageContext.request.contextPath}/style/images/edit.png" border="0" style="CURSOR: hand;margin-top: -8px;">
									</a>
								</span>
								<span class="word">
									<a onclick="deletePet(${p.id})" title="删除用户" style="margin-left: 20px;">
										<img src="${pageContext.request.contextPath}/style/images/delete.png" border="0" style="CURSOR: hand;margin-top: -6px;">
									</a>
								</span>
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
	
	function deletePet(id) {
		var cfm = confirm("确定删除该宠物信息吗？");
		if(cfm){
			$.blockUI({ 
				message: "<h4>正在删除 ....</h4>", 
				css: { 
					border: '1px solid #666',
					color: '#a00',
				} 
			});
			$.ajax({
				url: '${pageContext.request.contextPath}/pet/delete',
				type: 'post',
				data: {id: id},
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
