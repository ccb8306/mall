<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	/*logoutAction.jsp*/
	
	로그아웃 버튼을 누르거나 회원 탈퇴시 
	세션을 초기화 시켜주는 액션
	
	세션 초기화 후 index.jsp로 이동
 -->
<%
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>