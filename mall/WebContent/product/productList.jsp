<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!-- 
	/*productList.jsp*/
	
	상품 리스트 페이지.
	
	전체 상품을 출력하거나
	카테고리 선택시 카테고리에 존재하는 상품만 출력해줌.
	또한 검색기능 사용 시 해당 문자가 포함된 상품만 출력해줌.
	
	한 상품 클릭 시 productOne.jsp로 이동
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productList</title>
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
		request.setCharacterEncoding("utf-8");
	
		int currentPage = 1; // 현재 페이지
		int endPage = 1; // 마지막 페이지
		int rowPage = 10; // 한 페이지당 결과 개수
		int categoryId = -1; // 카테고리 아이디 
		String searchProductName = ""; // 상품 이름 검색
		
		// 카테고리 값 받기
		if(request.getParameter("categoryId") != null)
			categoryId = Integer.parseInt(request.getParameter("categoryId"));
		
		// 페이지 값 받기
		if(request.getParameter("currentPage") != null)
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
		// 이름 검색 받기
		if(request.getParameter("searchProductName") != null)
			searchProductName = request.getParameter("searchProductName");

		
		ProductDao productDao = new ProductDao();
		ArrayList<Product> productList = null;
		
		// 전체 카테고리 상품 목록일시 && 검색 x
		if(categoryId == -1 && searchProductName == ""){
			endPage = productDao.getProductEndPage(rowPage);
			productList = productDao.selectProductList(currentPage, rowPage);
		// 선택 카테고리 상품 목록일시 && 검색 x
		}else if(categoryId != -1 && searchProductName == ""){
			endPage = productDao.getProductEndPagebyCategoryId(categoryId, rowPage);
			productList = productDao.selectProductListByCategoryId(categoryId, currentPage, rowPage);
		// 검색 상품 목록
		}else if(searchProductName != ""){
			endPage = productDao.getProductEndPagebyProductName(searchProductName, rowPage);
			productList = productDao.selectProductListByProductName(searchProductName, currentPage, rowPage);		
		}
		
		// 카테고리 Dao
		CategoryDao categoryDao = new CategoryDao();
	%>
	<!-- 상품 리스트 -->
	<div class="container">
		<table class="table">
			<thead class="thead-light">
				<!-- 카테고리 이름 -->
				<tr>
					<%
						if(categoryId == -1 && searchProductName.equals("")){
					%>
							<th colspan="3"><h5>상품 - 전체</h5></th>
					<%
						}else if(categoryId != -1 && searchProductName.equals("")){
					%>
							<th colspan="3"><h5>상품 - <%=categoryDao.getCategoryNameByCategoryId(categoryId) %></h5></th>
					<% 
						}else {
					%>
							<th colspan="3"><h5>상품 - 검색결과</h5></th>
					<%
						}
					%>
				</tr>
			</thead>
			<tbody>
				<!-- 상품 목록 -->
				<%
					for(Product p : productList){
				%>
				<tr>
					<td style="width:150px" rowspan="3"><img width="150px" src="/mall-admin/images/<%=p.getProductPic()%>"></td>	
					<td rowspan="2">
						<h3><a class="color-black" href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>"><%=p.getProductName() %></a><br></h3>
						<h5><%=p.getProductPrice() %>원</h5>
					</td>	
					<td rowspan="3"></td>			
				</tr>
				<tr>
				</tr>
				<tr>
					<td>무료배송</td>			
				</tr>
				<%
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
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=1">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=endPage %>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=endPage %>">맨끝</a></li>
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