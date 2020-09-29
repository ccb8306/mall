<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!-- 
	Goodee Shop 메인 페이지(index)
	
	- 구성 -
	1. 상단 메뉴바_1 : 검색, 마이페이지, 주문내역, 로그인, 회원가입
	2. 카테고리, 이미지(광고, 메인)
	3. 인기 카테고리 TOP 4
	4. 오늘의 추천상품 : 카테고리별로 확인 가능
	5. 공지사항 (최신 2개)
	6. 하단 메뉴바
	
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
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
	<!-- jsp -->
	<%
		request.setCharacterEncoding("utf-8");
	
		// 카테고리 Dao
		CategoryDao categoryDao = new CategoryDao();
		
		// 카테고리 페이지
		int categoryPage = 1; // 카테고리 현재 페이지
		int categoryRow = 7; // 한 페이지당 카테고리 개수
		int categoryEndPage = 1; // 카테고리 마지막 페이지
		
		// 현재 카테고리 페이지 값 받기
		if(request.getParameter("categoryPage") != null){
			categoryPage = Integer.parseInt(request.getParameter("categoryPage"));
		}
		
		// 추천 상품의 카테고리 id 받기
		int categoryId = -1;	
		if(request.getParameter("categoryId") != null){
			categoryId = Integer.parseInt(request.getParameter("categoryId"));
		}
		
		// 카테고리 최대 페이지 저장
		categoryEndPage = categoryDao.getCategoryEndPage(categoryRow);
		
		// 전체 카테고리 리스트
		ArrayList<Category> categoryList1 = new ArrayList<Category>();
		categoryList1 = categoryDao.selectCategoryList(categoryPage,categoryRow);
		
		// 인기 카테고리 리스트
		ArrayList<Category> categoryList2 = new ArrayList<Category>();
		categoryList2 = categoryDao.selectCategoryListbyCkList();
		
	%>
	
	<!-- 메뉴바 -->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<!-- 본문 -->
	<div class="container">
		<!-- 전체 카테고리 / 이미지 배너 -->
		<div class="row align-center">
			<!-- 카테고리 -->
			<div class="col-sm-3 align-center btn-group-vertical ">
				<a class="btn btn-light btn-outline-secondary" href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=-1">전체</a>
				<%
					for(Category c : categoryList1){
				%>
						<br><a class="btn btn-light btn-outline-secondary" href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>"><%=c.getCategoryName() %></a>
				<%		
					}
				%>	
				<br>
				<!-- 카테고리 페이징 -->
				<ul class="pagination align-center">
					<%
						// 현재 페이지가 1페이지 보다 클 시
						if(categoryPage > 1){
					%>
							<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=1&categoryId=<%=categoryId%>">&#60;&#60;</a></li>
							<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=<%=categoryPage-1%>&categoryId=<%=categoryId%>">&#60;</a></li>
					<%
						// 현재 페이지가 1페이지 일 시
						}else{
					%>
							<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=1&categoryId=<%=categoryId%>">&#60;&#60;</a></li>
							<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=<%=categoryPage-1%>&categoryId=<%=categoryId%>">&#60;</a></li>
					<%
						}// 현재 페이지
					%>
							<li class="page-item"><a class="page-link"><%=categoryPage %></a></li>
					<%
						// 현재 페이지가 마지막 페이지보다 작을 시
						if(categoryPage < categoryEndPage){
					%>
							<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=<%=categoryPage+1%>&categoryId=<%=categoryId%>">&#62;</a></li>
							<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=<%=categoryEndPage%>&categoryId=<%=categoryId%>">&#62;&#62;</a></li>
					<%
						// 현재 페이지가 마지막 페이지 일 시
						}else{
					%>
							<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=<%=categoryPage+1%>&categoryId=<%=categoryId%>">&#62;</a></li>
							<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/index.jsp?categoryPage=<%=categoryEndPage%>&categoryId=<%=categoryId%>">&#62;&#62;</a></li>
					<%
						}
					%>	
				</ul>
			</div>
			
			<!-- 이미지 배너 -->
			<div class="col-sm-9">
				<img src="<%=request.getContextPath() %>/images/1.jpg" width="80%">
			</div>
		</div>
	
	
		<!-- 인기 카테고리 리스트 TOP4 -->
		<div style="margin-top: 80px;"></div>
		<div class="align-center">
			<table class="table table-borderless">
				<tr>
					<td class="align-left" colspan="4">
						<div class=row>
							<div>
								<h4>인기 카테고리 TOP 4</h4>
							</div>
							<div>
								<span class="badge badge-danger">hot</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
				<%
					for(Category c : categoryList2){
				%>
						<td><a href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>"><img class="rounded-circle" width="220px" height="220px" src="/mall-admin/images/<%=c.getCategoryPic() %>"><br><%=c.getCategoryName() %></a></td>
				<%
					}
				%>
				</tr>
			</table>
		</div>
		
		<!-- jsp -->
		<%
			// 오늘 날짜
			Calendar today = Calendar.getInstance(); 		
	
			// 카테고리 리스트
			ArrayList<Category> categoryList3 = new ArrayList<Category>();
			categoryList3 = categoryDao.selectCategoryList();
			
			// 상품 리스트 불러오기
			ProductDao productDao = new ProductDao();
			ArrayList<Product> productList = null;
			
			// 전체 카테고리의 추천 상품
			if(categoryId == -1){
				productList = productDao.selectCkProductList();
			// 선택 카테고리의 추천 상품
			}else{
				productList = productDao.selectCkProductList(categoryId);
			}
		 
		%>
		
		<!-- 오늘의 추천 상품 -->
		<div style="margin-top: 80px;"></div>
		<div>
			<div class=row>
			<div style="margin-left: 20px;"></div>
				<div><h4>오늘의 추천상품</h4></div>
				<div>
					<span class="badge badge-primary"><%=today.get(Calendar.YEAR) %>-<%=today.get(Calendar.MONTH)+1 %>-<%=today.get(Calendar.DAY_OF_MONTH) %></span>
				</div>
			</div>
			
			<!-- 카테고리 선택 -->
			<div class="align-center">	
				<table class="table table-borderless">
					<tr>
						<td><a style="width:105%" class="btn btn-light btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?categoryPage=<%=categoryPage%>&categoryId=-1">전체</a></td>
						<%
							for(int i = 0 ; i < 6 ; i++){
						%>
								<td><a style="width:105%" class="btn btn-light btn-outline-secondary" href="<%=request.getContextPath()%>/index.jsp?categoryPage=<%=categoryPage%>&categoryId=<%=categoryList3.get(i).getCategoryId()%>"><%=categoryList3.get(i).getCategoryName() %></a></td>
						<%
							}
						%>
						<td>
							<select class="btn btn-primary" name="categoryId" onChange="window.open(value,'_self')">	
								<option>더보기</option>						
							<%
								System.out.println(categoryList3.size() + "<--size");
								for(int i = 6; i < categoryList3.size(); i ++){
									System.out.println(categoryList3.get(i).getCategoryId());
							%>
									<option value="<%=request.getContextPath()%>/index.jsp?categoryPage=<%=categoryPage%>&categoryId=<%=categoryList3.get(i).getCategoryId() %>"><%=categoryList3.get(i).getCategoryName() %></option>
							<%
								}
							%>
							</select>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 선택한 카테고리 -->
			<div>
				<h4>[
				<%
					// 전체 카테고리 선택시
					if(categoryId == -1){
				%>
					전체
				<%
					// 카테고리 하나 선택시
					}else{
				%>
					<%=categoryDao.getCategoryNameByCategoryId(categoryId) %>
				<%
					}
				%>
				]</h4>
			</div>
			
			<!-- 해당 카테고리의 추천 상품 -->
			<div>
				<table class="table table-borderless">
					<tr>
				<%
					int productI = 0;
					for(Product p : productList){
				%>
						<td>
							<div class="card" style="width:350px">
								<a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=p.getProductId() %>">
									<img class="card-img-top" height="300px" src="/mall-admin/images/<%=p.getProductPic() %>" alt="Card image">	
								</a>									
								<div class="card-body">
									<h4 class="card-title">
										<a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=p.getProductId() %>" class="color-black"><%=p.getProductName() %></a>
										<%
											// 상품이 풀절일경우
											if(p.getProductSoldout().equals("Y")){
										%>
												<span class="btn btn-danger">품절</span>
										<%
											}
										%>
									</h4>
									<h5 class="card-title align-right"><%=p.getProductPrice() %>원</h5>
								</div>
							</div>	
						</td>	
						<%
							productI++;
							if(productI%3 == 0){
						%>
								</tr><tr>
				<%
							}
					}
				%>
					</tr>
				</table>
			</div>
		</div>
		
		<div style="margin-top: 50px;"></div>
		
		<%
			NoticeDao noticeDao = new NoticeDao();
			ArrayList<Notice> noticeList = noticeDao.selectNoticeListLimit2();
		%>
		<!-- 공지사항 -->
		<div>
			<table class="table table-borderless">	
				<tr>
					<td style="width:15%">
						<h4><a class="color-black" href="<%=request.getContextPath() %>/notice/noticeList.jsp">공지사항</a></h4>
					</td>
					<td>
						<%
							for(Notice n : noticeList){
						%>
								<div><a class="color-black" href="<%=request.getContextPath() %>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId()%>">● <%=n.getNoticeTitle() %></a></div>
						<%
							}
						%>
					</td>
				</tr>
			</table>
		</div>
	</div>
		
	<!-- 하단 메뉴 -->
	<div>
		<jsp:include page="/inc/bottomMenu.jsp"></jsp:include>
	</div>
</body>
</html>