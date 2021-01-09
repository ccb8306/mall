package dao;
import java.util.*;

import commons.DBUtil;
import vo.*;
import java.sql.*;

public class OrdersDao {
	// �ֹ� �߰�
	public void insertOrders(Orders orders)throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "insert into orders(product_id, orders_amount, orders_price, member_email, orders_addr, orders_state, orders_date) value(?,?,?,?,?,?,now())";;
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orders.getProductId());
		stmt.setInt(2, orders.getOrdersAmount());
		stmt.setInt(3, orders.getOrdersPrice());
		stmt.setString(4, orders.getMemberEmail());
		stmt.setString(5, orders.getOrdersAddr());
		stmt.setString(6, "결제완료");
		stmt.executeUpdate();
		
		conn.close();
	}

	// ȸ�� �̸��Ϸ� �ֹ� ����Ʈ ���
	public ArrayList<OrdersAndProduct> selectOrderListByEmail(String memberEmail, int currentPage, int rowPage) throws Exception {
		ArrayList<OrdersAndProduct> list = new ArrayList<OrdersAndProduct>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select o.orders_id, o.product_id, o.orders_amount, o.orders_price, o.orders_addr, o.orders_state, o.orders_date, p.product_name, p.product_id, p.product_pic from orders o inner join product p on o.product_id = p.product_id where o.member_email=? order by o.orders_date desc limit ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		stmt.setInt(2, (currentPage - 1) * rowPage);
		stmt.setInt(3, rowPage);
		ResultSet rs = stmt.executeQuery();

		while(rs.next()) {
			Orders o = new Orders();
			Product p = new Product();
			OrdersAndProduct op = new OrdersAndProduct();
			o.setOrdersId(rs.getInt("orders_id"));
			o.setProductId(rs.getInt("product_id"));
			o.setOrdersAmount(rs.getInt("orders_amount"));
			o.setOrdersPrice(rs.getInt("orders_price"));
			o.setOrdersAddr(rs.getString("orders_addr"));
			o.setOrdersState(rs.getString("orders_state"));
			o.setOrdersDate(rs.getString("orders_date"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPic(rs.getString("product_pic"));
			p.setProductId(rs.getInt("product_id"));
			
			op.setOrders(o);
			op.setProduct(p);
			list.add(op);
		}
		
		conn.close();
		
		return list;
	}
	
	// �ֹ� ��� --> �ֹ� ���¸� �ֹ���ҷ� �ٲ�
	public void updateOrdersState(int ordersId)throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		String sql = "update orders set orders_state='주문취소' where orders_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersId);
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// �ֹ�����Ʈ �ִ� ������ ���ϱ�
	public int getCategoryEndPage(int rowPage, String memberEmail) throws Exception {
		int endPage = 1;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from orders where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
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
