package dao;
import java.util.*;

import commons.DBUtil;

import java.sql.*;
import vo.*;

public class ProductDao {

	// 상품 목록 출력 (카테고리 미선택(전체) 사진 o, 페이징o) 
	public ArrayList<Product> selectProductList(int currentPage, int rowPage) throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select product_id, product_name, product_price, product_pic from product where product_soldout='N' limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (currentPage - 1) * rowPage);
		stmt.setInt(2, rowPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product p = new Product();
			p.setProductId(rs.getInt("product_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductPic(rs.getString("product_pic"));
			list.add(p);
		}

		conn.close();
		return list;	
	}
	// 카테고리 id로 상품 목록 출력 (페이징 o)
	public ArrayList<Product> selectProductListByCategoryId(int categoryId, int currentPage, int rowPage) throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select product_id, product_name, product_price, product_pic from product where product_soldout='N' AND category_id=? limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		stmt.setInt(2, (currentPage-1)*rowPage);
		stmt.setInt(3, rowPage);

		ResultSet rs = stmt.executeQuery();

		while(rs.next()) {
			Product p = new Product();
			p.setProductId(rs.getInt("product_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductPic(rs.getString("product_pic"));
			list.add(p);
		}

		conn.close();
		return list;
		
	}
	
	// 상품 검색 --> 상품 이름에 검색 단어가 포함되는 상품 출력
	public ArrayList<Product> selectProductListByProductName(String productName, int currentPage, int rowPage) throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	

		String sql = "select product_id, product_name, product_price, product_pic from product where product_soldout='N' AND product_name like ? limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + productName + "%");
		stmt.setInt(2, (currentPage-1)*rowPage);
		stmt.setInt(3, rowPage);

		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product p = new Product();
			p.setProductId(rs.getInt("product_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductPic(rs.getString("product_pic"));
			list.add(p);
		}

		conn.close();
		return list;
		
	}
	
	// 추천 상품 목록 출력 (카테고리 선택 : 페이징 x, JOIN x, 사진 o -- 6개) 
	public ArrayList<Product> selectCkProductList(int categoryId) throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select product_id, product_name, product_price, product_pic from product where product_soldout='N' and category_id=? limit 0,6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product p = new Product();
			p.setProductId(rs.getInt("product_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductPic(rs.getString("product_pic"));
			list.add(p);
		}

		conn.close();
		return list;	
	}
	
	// 추천 상품 목록 출력 (카테고리 미선택(전체) : 페이징 x, JOIN x, 사진 o -- 6개) 
	public ArrayList<Product> selectCkProductList() throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select product_id, product_name, product_price, product_pic from product where product_soldout='N' limit 0,6";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product p = new Product();
			p.setProductId(rs.getInt("product_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductPic(rs.getString("product_pic"));
			list.add(p);
		}

		conn.close();
		return list;	
	}
	
	// 상품 상세보기
	public Product selectProductOne(int productId) throws Exception {
		Product p = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select product_id ,product_name, product_price, product_content, product_soldout, product_pic from product where product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productId);
		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			p = new Product();
			p.setProductId(rs.getInt("product_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductContent(rs.getString("product_content"));
			p.setProductSoldout(rs.getString("product_soldout"));
			p.setProductPic(rs.getString("product_pic"));
		}

		conn.close();
		return p;	
	}
	// 전체 카테고리 최대 페이지 구하기
	public int getProductEndPage(int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from product where product_soldout='N'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		conn.close();
		return endPage;
	}
	
	// 선택된 카테고리 최대 페이지 구하기
	public int getProductEndPagebyCategoryId(int categoryId, int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from product where product_soldout='N' and category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		conn.close();
		return endPage;
	}
	
	// 상품 이름으로 최대 페이지 구하기 --> 상품 검색시 사용
	public int getProductEndPagebyProductName(String productName, int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from product where product_soldout='N' and product_name like ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + productName + "%");
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		conn.close();
		return endPage;
	}
	
	
}
