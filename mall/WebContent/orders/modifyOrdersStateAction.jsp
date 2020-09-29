<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<!-- 
	/*modifyOrdersStateAction.jsp*/
	
	주문내역의 상태를 변경해 주는 페이지
	
	회원이 myOrdersList.jsp에서 한 상품의 주문을 취소할 떄 실행되는 액션.
	
	해당 주문의 상태를 '주문취소'로 변경 시켜줌
 -->
<%
	// 비로그인 시
	if(session.getAttribute("loginMemberEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/login.jsp");
		return;
	}
	
	// 주문 id
	int ordersId = Integer.parseInt(request.getParameter("ordersId"));
	
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.updateOrdersState(ordersId);
	
	response.sendRedirect(request.getContextPath() + "/member/myOrdersList.jsp?memberEmail");
%>