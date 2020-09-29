<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 
	/*loginAction.jsp*/
	
	login.jsp에서 로그인 버튼을 누를시 넘어오는 액션
	
	MemberDao에 있는 회원 확인 쿼리로 회원 정보가 일치하는지 확인 후
	일치하면 index.jsp로, 불일치하면 login.jsp로 이동
 -->
<%
	request.setCharacterEncoding("utf-8");

	// 비정상적인 접근시
	if(session.getAttribute("loginMemberEmail") != null){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	String memberEmail = null;
	String memberPw = null;
	
	// 이메일이나 비밀번호를 입력 안했을 시 
	if(request.getParameter("memberEmail").equals("") || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
		return;
	}

	// 정보 저장
	memberPw = request.getParameter("memberPw");
	memberEmail = request.getParameter("memberEmail");

	System.out.println(memberEmail + "<--memberEmail");
	System.out.println(memberPw + "<--memberPw");
	
	Member m = new Member();
	m.setMemberEmail(memberEmail);
	m.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	// 로그인이 가능한지
	// 로그인 불가능
	if(memberDao.selectMemberCk(m) == null){
		response.sendRedirect(request.getContextPath() + "/member/login.jsp");
	// 로그인 가능
	}else{
		session.setAttribute("loginMemberEmail", memberEmail);
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>