<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*productOne.jsp*/
	
	상품 상세보기 페이지.
	
	이 페이지에서 해당 상품의 내용을 자세히 볼 수 있으며.
	원하는 개수와 배송지 입력 후 구매 버튼을 눌러 해당 상품을 구매할 수 있다.
	
	구매 버튼 클릭시 addOrdersAction.jsp로 이동
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productOne</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<style>
	.align-left{text-align:left;}
	.align-center{text-align:center;}
	.align-right{text-align:right;}
	.color-black{color:black};
</style>
</head>
<body>
	<!-- 메뉴바 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<!-- jsp -->
	<%
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		int amount = 1;
		if(request.getParameter("amount") != null){
			amount = Integer.parseInt(request.getParameter("amount"));
		}
		
		ProductDao productDao = new ProductDao();		
		Product p = productDao.selectProductOne(productId);
	%>
	
	<!-- 상품 상세보기 -->
	<div class="container form-group">
		<!-- 상품 기본정보 / 구매 -->
		<div>
			<form method="post" action="<%=request.getContextPath()%>/orders/addOrdersAction.jsp">
				<input type="hidden" name="productId" value="<%=productId %>">
				<input type="hidden" name="ordersPrice" value="<%=amount * p.getProductPrice() %>">
				<table class="table">
					<tr>
						<td rowspan="6" style="width:500px"><img src="/mall-admin/images/<%=p.getProductPic()%>" width="500px"></td>
						<td>
							<h1><%=p.getProductName() %></h1><br>
							<h4><%=p.getProductPrice() %>원</h4>
						</td>
					</tr>
					<tr>
						<td>무료배송 <br> 무이자 할부</td>
					</tr>
					<%
						// 품절이 아닐경우 (판매중)
						if(p.getProductSoldout().equals("N")){
					%>
						<tr>
							<td>
								<div class="input-group">
									<!-- 수량 선택시 총 금액 변동 -->
									<h5>수량 선택</h5>  
									<select style="width:60%" class="form-control" id="sel1" name="amount" onChange="window.open(value,'_self')">
										<%
											for(int i = 1; i < 11 ; i ++){
										%>
												<option
												<%
													if(amount == i) {
												%>
													selected="selected"
												<%
													}
												%>
												 value="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=productId%>&amount=<%=i%>"><%=i %></option>
										<%
											}
										%>
									</select>
									<input type="hidden" name="ordersAmount" value="<%=amount%>">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<h3>총 금액 :  <%=amount * p.getProductPrice() %>원</h3>
							</td>
						</tr>
						<tr>
							<td><h4>배송지 : <input type="text" class="" name="ordersAddr"></h4></td>
						</tr>
						<tr>
							<td><button type="submit" class="btn btn-outline-primary btn-block">구매하기</button></td>
						</tr>
					<%
						// 품절일 경우
						}else{
					%>
						<tr><td rowspan="2"><button type="button" disabled class="btn btn-secondary btn-block">품절</button></td></tr>
					<%
						}
					%>
				</table>
			</form>
		</div>
		
		<!-- 상품 상세설명 -->
		<div style="margin-top:5px">
			<table class="table"><tr><td></td></tr></table>
			<table class="table table-borderless">
				<tr><th><h3>상품 상세설명</h3></th></tr>
				<tr>
					<td><%=p.getProductContent() %></td>
				</tr>
			</table>
		</div>
	</div>
	
	<!-- 최하단 -->
	<div>
		<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
	</div>
</body>
</html>