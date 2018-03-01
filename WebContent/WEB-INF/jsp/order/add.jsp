<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/util/tag.jsp" %>
<!DOCTYPE>
<html>
  <head>
    <title>添加零食信息</title>
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
		.rightTD input {height: 25px;width: 200px;}
		#subBtn {display: inline-block;width: 80px;margin-left: 30px;}
		h4 {margin: 20px 15px;color: #777;}
	</style>
  </head>
  <body>
	<div id="vLocation">
		当前位置&nbsp;：零食管理&nbsp;&nbsp;<span class="divider">/</span>&nbsp;&nbsp;<a href="javascript:void(0)">添加零食</a>
	</div>
	<div id="infoDiv">
		<form id="saveForm" action="${pageContext.request.contextPath}/food/add" method="post" enctype="multipart/form-data">
			<table id="infoTable">
				<tr>
					<td class="leftTD">名称</td>
					<td class="rightTD"><input type="text" id="name" name="name"/></td>
				</tr>
				<tr>
					<td class="leftTD">单价</td>
					<td class="rightTD"><input type="number" id="unitPrice" name="unitPrice"/>&nbsp;元</td>
				</tr>
				<tr>
					<td class="leftTD">生产日期</td>
					<td class="rightTD"><input type="date" id="productionDateT" name="productionDateT" required="required"/></td>
				</tr>
				<tr>
					<td class="leftTD">有效日期</td>
					<td class="rightTD"><input type="date" id="effectiveDateT" name="effectiveDateT" required="required"/></td>
				</tr>
				<tr>
					<td class="leftTD">重量</td>
					<td class="rightTD"><input type="number" id="weight" name="weight" required="required"/>&nbsp;kg</td>
				</tr>
				<tr>
					<td class="leftTD">介绍</td>
					<td class="rightTD"><input type="text" id="introduction" name="introduction" required="required"/></td>
				</tr>
				<tr>
					<td class="leftTD">备注</td>
					<td class="rightTD">
						<textarea id="note" rows="5" cols="15" name="note"></textarea>
					</td>
				</tr>
				<tr>
					<td class="leftTD">图片</td>
					<td class="rightTD"><input type="file" id="file" name="file" required="required"/></td>
				</tr>
				<tr>
					<td class="leftTD" style="color: #ccc;">预览</td>
					<td class="rightTD">
						<img id="ImgPr" width="180" height="100" />
					</td>
				</tr>
				<tr>
					<td class="leftTD">库存信息：</td>
					<td class="rightTD"></td>
				</tr>
				<tr>
					<td class="leftTD">仓库编号</td>
					<td class="rightTD"><input type="text" id="storeNum" name="storeNum" required="required"/></td>
				</tr>
				<tr>
					<td class="leftTD">区域编号</td>
					<td class="rightTD"><input type="text" id="areaNum" name="areaNum" required="required"/></td>
				</tr>
				<tr>
					<td class="leftTD">位置编号</td>
					<td class="rightTD"><input type="text" id="placeNum" name="placeNum" required="required"/></td>
				</tr>
				<tr>
					<td class="leftTD">库存数量</td>
					<td class="rightTD"><input type="number" id="amount" name="amount" required="required"/></td>
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
  			$("#file").on("change",function(){
	  			var objUrl = getObjectURL(this.files[0]) ; //获取图片的路径，该路径不是图片在本地的路径
	  			if (objUrl) {
	  				$("#ImgPr").attr("src", objUrl) ; //将图片路径存入src中，显示出图片
  				}
  			})

  		$("#subBtn").click(function() {
			var  name = $("#name").val().trim();
			var  unitPrice = $("#unitPrice").val().trim();
			var  productionDateT = $("#productionDateT").val();
			var  effectiveDateT = $("#effectiveDateT").val();
			var  weight = $("#weight").val().trim();
			var  introduction = $("#introduction").val().trim();
			var  note = $("#note").val().trim();
			var  file = $("#file").val();
			var  storeNum= $("#storeNum").val();
			var  areaNum= $("#areaNum").val();
			var  placeNum= $("#placeNum").val();
			var  amount= $("#amount").val();
			if (name!='' && unitPrice!='' && productionDateT!='' && effectiveDateT!='' && weight!='' && introduction!='' && note!='' && storeNum!='' && areaNum!='' && placeNum!='' && amount!='') {
				if (file == '') {
					alert("请选择零食图片");
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
