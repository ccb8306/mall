<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	/*addOrdersAction.jsp*/
	
	물건을 구매하는 액션 페이지
	
	productOne.jsp에서 구매버튼 클릭시 올 수 있음.
	
	구매자의 주문 목록에 해당상품 구매 내역을 추가해 줌.
	
	구매 성공 시 myOrdersList.jsp로 이동
 -->
<%
	// 로그인 안했을 시 
	if(session.getAttribute("loginMemberEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	
	// 주문 정보 받아오기
	int productId = Integer.parseInt(request.getParameter("productId"));
	int ordersAmount = Integer.parseInt(request.getParameter("ordersAmount"));
	int ordersPrice = Integer.parseInt(request.getParameter("ordersPrice")); // productOne에서 가격을 이미 계산해서 넘겨옴
	String memberEmail = session.getAttribute("loginMemberEmail").toString();
	String ordersAddr = request.getParameter("ordersAddr");
	
	OrdersDao ordersDao = new OrdersDao();
	
	
	// 주문 정보 저장
	Orders o = new Orders();
	o.setMemberEmail(memberEmail);
	o.setOrdersAddr(ordersAddr);
	o.setOrdersAmount(ordersAmount);
	o.setOrdersPrice(ordersPrice);
	o.setProductId(productId);
	
	// 주문 내역 추가
	ordersDao.insertOrders(o);
	
	response.sendRedirect(request.getContextPath() + "/member/myOrdersList.jsp");
%>