<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*myOrdersList.jsp*/
	
	세션의 저장된 회원 이메일로 해당 회원의 주문 내역을 DB에서 불러와 출력시켜 준다.
	
	해당 페이지에선 회원의 주문리스트를 출력해주며
	주문 취소가 가능하다
 -->
<%
	// 비로그인 시
	if(session.getAttribute("loginMemberEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ordersList</title>
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
	
	<%
		int currentPage = 1; // 현재 페이지
		int rowPage = 10; // 한 페이지당 글 개수
		int endPage = 1; // 최대 페이지

		OrdersDao ordersDao = new OrdersDao();
		
		// 현재 페이지 받기
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 최대 페이지 구하기
		endPage = ordersDao.getCategoryEndPage(rowPage, session.getAttribute("loginMemberEmail").toString());
	
		// 리스트
		ArrayList<OrdersAndProduct> oapList = ordersDao.selectOrderListByEmail((session.getAttribute("loginMemberEmail")).toString(), currentPage, rowPage);
	%>
	
	<!-- 주문 리스트 -->
	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th colspan="9" class="table-active"><h4>주문 목록</h4></th>
				</tr>
				<tr>
					<th>주문번호</th>
					<th colspan="2">상품이름</th>
					<th>주문상품</th>
					<th>결제금액</th>
					<th>배송지</th>
					<th>주문상태</th>
					<th>주문일</th>
					<th>주문취소</th>
				</tr>
			</thead>
			<tbody>
					<%
						for(OrdersAndProduct oap : oapList){
							// 주문 취소된 상품 일 시
							if(oap.getOrders().getOrdersState().equals("주문취소")){
					%>
						<tr>
							<td><del><%=oap.getOrders().getOrdersId() %></del></td>
							<td><img src="/mall-admin/images/<%=oap.getProduct().getProductPic()%>" width="70px" height="70px"></td>
							<td><del><a class="color-black" href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=oap.getProduct().getProductId()%>"><%=oap.getProduct().getProductName() %></a></del></td>
							<td><del><%=oap.getOrders().getOrdersAmount() %></del></td>
							<td><del><%=oap.getOrders().getOrdersPrice() %>원</del></td>
							<td><del><%=oap.getOrders().getOrdersAddr() %></del></td>
							<td style="color:red"><%=oap.getOrders().getOrdersState() %></td>
							<td><del><%=oap.getOrders().getOrdersDate() %></del></td>
							<td>-</td>
						</tr>
					<%
							// 그 외
							}else{
					%>
						<tr>
							<td><%=oap.getOrders().getOrdersId() %></td>
							<td><img src="/mall-admin/images/<%=oap.getProduct().getProductPic()%>" width="70px" height="70px"></td>
							<td><a class="color-black" href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=oap.getProduct().getProductId()%>"><%=oap.getProduct().getProductName() %></a></td>
							<td><%=oap.getOrders().getOrdersAmount() %></td>
							<td><%=oap.getOrders().getOrdersPrice() %>원</td>
							<td><%=oap.getOrders().getOrdersAddr() %></td>
							<td><%=oap.getOrders().getOrdersState() %></td>
							<td><%=oap.getOrders().getOrdersDate() %></td>
							<td><a href="<%=request.getContextPath() %>/orders/modifyOrdersStateAction.jsp?ordersId=<%=oap.getOrders().getOrdersId() %>">주문취소</a></td>
						</tr>
					<%
							}
						}
					%>
			</tbody>
		</table>
		
		<!-- 페이징 -->
		<ul class="pagination">
			<%
				// 현재 페이지가 1페이지 보다 클 시
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=1">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=<%=endPage %>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath()%>/member/myOrdersList.jsp?currentPage=<%=endPage %>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
	</div>
	
	<!-- 최하단 -->
	<div>
		<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
	</div>
</body>
</html>