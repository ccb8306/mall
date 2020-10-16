<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 
	/*signupAction.jsp*/
	
	signup.jsp에서 회원가입 버튼으로 올 수 있는 액션 페이지.
	
	입력한 회원 정보와 DB데이터를 확인하여 
	가입이 가능한 회원정보인지 판단.
	
	가입 가능시 가입 후 login.jsp페이지로 이동
	가입 불가능 시 signup.jsp페이지로 이동
 -->
<%
	request.setCharacterEncoding("utf-8");

	// 비정상적인 접근시
	if(session.getAttribute("loginMemberEmail") != null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	// 회원가입 처리
	String memberEmail = null;
	String memberPw = null;
	String memberPw2 = null;
	String memberName = null;
	
	// 회원 정보 값 받기
	memberEmail = request.getParameter("memberEmail");
	memberPw = request.getParameter("memberPw");
	memberName = request.getParameter("memberName");

	MemberDao memberDao = new MemberDao();	
	
	// 이미 가입된 회원일 시 
	if(memberDao.selectMemberEmailCk(memberEmail) != null){
		response.sendRedirect(request.getContextPath()+"/member/signup.jsp");
		return;
	}
	
	// 회원 정보 값 저장
	Member member = new Member();
	member.setMemberEmail(memberEmail);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	// 회원 정보 db에 저장
	memberDao.insertMember(member);
	response.sendRedirect(request.getContextPath()+"/member/login.jsp");
	
%>