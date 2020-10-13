<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>

<!-- 상단 메뉴바 -->
 
<%
	// 회원 Dao
	MemberDao memberDao = new MemberDao();
	request.setCharacterEncoding("utf-8");
	
	// 상품 이름 검색
	String searchProductName = ""; 
	if(request.getParameter("searchProductName") != null)
		searchProductName = request.getParameter("searchProductName");
	
 %>
<div class="container">
	<div style="margin-top: 60px;"></div>
	
	<!-- 최상당 (로고/검색/마이페이지/장바구니) -->
	<div class="row">
		<!-- 로고 -->
		<div class="col-sm-4 align-left">
			<a class="color-black" href="<%=request.getContextPath() %>/index.jsp"><h1>Goodee Shop</h1></a>
		</div>
		
		<!-- 검색 -->
		<div class="col-sm-6 align-center">
			<form method="post" action="<%=request.getContextPath() %>/product/productList.jsp">
				<div class="input-group mb-3">
					<input type="text" class="form-control" name="searchProductName" placeholder="Search Product Name" value="<%=searchProductName %>">
					<div class="input-group-prepend">	
						<button style="width:80px" class="btn btn-outline-dark" type="submit">검색</button>
					</div>
				</div>
			</form>
		</div>
		
		<!-- 마이페이지/장바구니 -->
		<div class="col-sm-2 align-right">
			<a class="color-black" href="<%=request.getContextPath()%>/member/myInfo.jsp?memberEmail=<%=session.getAttribute("loginMemberEmail")%>"><i class='fas fa-user-alt' style='font-size:36px;'></i></a>
			<a class="color-black" href="<%=request.getContextPath()%>/member/myOrdersList.jsp"><i class='fas fa-shopping-cart' style='font-size:36px'></i></a>
		</div>
	</div>
</div>
<div class="container-fluid" style="margin-top: 10px;">
	<!-- 로그인/회원가입 바 -->
	<div>
		<nav style="text-align:right" class="navbar navbar-expand-sm bg-dark navbar-dark">
			<ul class="navbar-nav mr-auto"></ul>
			<ul class="navbar-nav mr-right">
				<%
					// 비로그인 상태일 시 보여줄 메뉴바
					if(session.getAttribute("loginMemberEmail") == null){
				%>
				    <li class="nav-item">
						<a class="nav-link active" href="<%=request.getContextPath()%>/member/login.jsp">로그인</a>
				    </li>
				    <li class="nav-item">
						<a class="nav-link active" href="<%=request.getContextPath()%>/member/signup.jsp">회원가입</a>
				    </li>
				<%
					// 로그인 상태일 시 보여줄 메뉴바
					}else{
				%>
				    <li class="nav-item">
						<!-- 세션 이메일로 회원 이름 가져오기 -->
						<a class="nav-link active"><%=memberDao.selectNameByEmail(session.getAttribute("loginMemberEmail").toString()) %>님 반갑습니다.</a>
				    </li>
				    <li class="nav-item">
						<a class="nav-link active" href="<%=request.getContextPath()%>/member/logoutAction.jsp">[로그아웃]</a>
				    </li>
				 <%
					}
				 %>
			</ul>
		</nav>
	</div>
	<div style="margin-top: 20px;"></div>
</div>