package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.product.dao.ProductDAO;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.purchase.vo.PurchaseVO;
import com.model2.mvc.service.user.dao.UserDAO;
import com.model2.mvc.service.user.vo.UserVO;;


public class PurchaseDAO {
	
	public PurchaseDAO(){
	}

	public void insertPurchase(PurchaseVO purchaseVO) throws Exception{
		
		Connection con = DBUtil.getConnection();
		System.out.println("insertPurchase 실행");
		String sql = "INSERT INTO transaction "
				+ "(tran_no, prod_no, buyer_id, payment_option, receiver_name, receiver_phone, demailaddr, divy_request, divy_date, order_data, tran_status_code) "
				+ "VALUES(seq_product_prod_no.nextval, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, ?)";
		
		System.out.println(sql);
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, purchaseVO.getPurchaseProd().getProdNo());
		stmt.setString(2, purchaseVO.getBuyer().getUserId());
		stmt.setString(3, purchaseVO.getPaymentOption());
		stmt.setString(4, purchaseVO.getReceiverName());
		stmt.setString(5, purchaseVO.getReceiverPhone());
		stmt.setString(6, purchaseVO.getDivyAddr());
		stmt.setString(7, purchaseVO.getDivyRequest());
		stmt.setString(8, purchaseVO.getDivyDate());
		stmt.setString(9, "1");
		stmt.executeUpdate();
		
		con.close();
				
		
	}



	public PurchaseVO findPurchase(int tranNo) throws Exception {
		//구매상세보기
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM transaction WHERE tran_no = ?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, tranNo);

		ResultSet rs = stmt.executeQuery();

		rs.next();
		PurchaseVO purchaseVO = new PurchaseVO();
		purchaseVO.setTranNo(rs.getInt("tran_no"));
		purchaseVO.setPurchaseProd(new ProductDAO().findProduct(rs.getInt("prod_no")));
		purchaseVO.setBuyer(new UserDAO().findUser(rs.getString("buyer_id")));
		purchaseVO.setPaymentOption(rs.getString("payment_option").trim());
		purchaseVO.setReceiverName(rs.getString("receiver_name"));
		purchaseVO.setReceiverPhone(rs.getString("receiver_phone"));
		purchaseVO.setDivyAddr(rs.getString("demailaddr"));
		purchaseVO.setDivyRequest(rs.getString("divy_request"));
		purchaseVO.setTranCode(rs.getString("tran_status_code"));
		purchaseVO.setOrderDate(rs.getDate("order_data"));
		purchaseVO.setDivyDate(rs.getString("divy_date"));

		System.out.println("purchaseVO" + purchaseVO);

		return purchaseVO;
	}
	
	public PurchaseVO findPurchase2(int prodNo) throws Exception {

		Connection con = DBUtil.getConnection();

		String sql = "SELECT tran_no, tran_status_code FROM transaction WHERE prod_no=?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);

		
		ResultSet rs = stmt.executeQuery();

		rs.next();
		
		PurchaseVO purchaseVO = new PurchaseVO();
		purchaseVO.setTranNo(rs.getInt("tran_No"));
		purchaseVO.setTranCode(rs.getString("tran_status_code"));
		
		
		
		con.close();

		return purchaseVO;
	}

	public HashMap<String, Object> getPurchaseList(SearchVO searchVO, String buyerId) throws Exception {

		Connection con = DBUtil.getConnection();
		String sql =("SELECT purchase.* " +
			     "FROM(SELECT ROW_NUMBER() OVER(order by user_id) rn , " +
			     "ts.tran_no, u.user_id, NVL(ts.tran_status_code,0) tran_code, COUNT(*)OVER() count " +
			     "FROM users u, transaction ts " +
			     "WHERE u.user_id = ts.buyer_id AND u.user_id = ? )purchase ");
		

		PreparedStatement stmt = con.prepareStatement(sql.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_UPDATABLE);

		System.out.println("searchVO.getPage():" + searchVO.getPage());
		System.out.println("searchVO.getPageUnit():" + searchVO.getPageUnit());

		stmt.setString(1, buyerId);

		ResultSet rs = stmt.executeQuery();

		HashMap<String, Object> map = new HashMap<String, Object>();
		if (rs.next()) {
		} else {
			return map;
		}

		int total = rs.getInt("count");
		

		map.put("count", new Integer(total));
		int max = searchVO.getPageUnit();
		List<PurchaseVO> list = new ArrayList<PurchaseVO>();
		if (total > 0) {
			if (total < max) {
				max = total;
			} else {
				total = max;
			}
			rs.first();
			
			for (int i = 0; i < total; i++) {
			
				PurchaseVO vo = new PurchaseVO();
				vo.setTranNo(rs.getInt("tran_no"));
				vo.setBuyer(new UserDAO().findUser(rs.getString("user_id")));
				vo.setTranCode(rs.getString("tran_code").trim());
				System.out.println(vo);
				list.add(vo);
				if (!rs.next()) {
					break;
				}
			}
		}

		System.out.println("list.size() : " + list.size());
		map.put("list", list);
		System.out.println("map().size() : " + map.size());

		con.close();

		return map;
	}
	
	public HashMap<String, Object> getSaleList(SearchVO searchVO) throws Exception {

		Connection con = DBUtil.getConnection();

		PreparedStatement stmt = con.prepareStatement("SELECT * FROM transaction", ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_UPDATABLE);

		ResultSet rs = stmt.executeQuery();

		rs.last();
		int total = rs.getRow();

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("count", new Integer(total));

		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit() + 1);
		List<PurchaseVO> list = new ArrayList<PurchaseVO>();

		if (total > 0) {
			for (int i = 0; i < searchVO.getPageUnit(); i++) {
				PurchaseVO vo = new PurchaseVO();

				vo.setTranNo(rs.getInt("tran_no"));
				vo.setBuyer(new UserDAO().findUser(rs.getString("buyer_id")));
				vo.setDivyAddr(rs.getString("demailaddr"));
				vo.setDivyDate(rs.getString("dlvy_date"));
				vo.setDivyRequest(rs.getString("dlvy_request"));
				vo.setOrderDate(rs.getDate("order_date"));
				vo.setPaymentOption(rs.getString("payment_option"));
				vo.setPurchaseProd(new ProductDAO().findProduct(rs.getInt("prod_no")));
				vo.setReceiverName(rs.getString("receiver_name"));
				vo.setReceiverPhone(rs.getString("receiver_phone"));
				vo.setTranCode(rs.getString("tran_status_code"));

				list.add(vo);

				if (!rs.next())
					break;
			}
		}

		map.put("list", list);
		con.close();

		return map;
	}

	public void updateTranCode(PurchaseVO purchaseVO) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET tran_status_code=? WHERE tran_no=?";
		// 트랜스코드, 구매번호
		PreparedStatement stmt = con.prepareStatement(sql);
		
		System.out.println("여기는 sql : "+sql);
		
		stmt.setString(1, purchaseVO.getTranCode());
		stmt.setInt(2, purchaseVO.getTranNo());
		
		stmt.executeUpdate();
		
		con.close();
	}
	
	public void updatePurchase(PurchaseVO purchaseVO) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET payment_option=?,receiver_name=?,receiver_phone=?,demailAddr=?,divy_request=?,divy_date=? WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		
		
		stmt.setString(1, purchaseVO.getPaymentOption());
		stmt.setString(2, purchaseVO.getReceiverName());
		stmt.setString(3, purchaseVO.getReceiverPhone());
		stmt.setString(4, purchaseVO.getDivyAddr());
		stmt.setString(5, purchaseVO.getDivyRequest());
		stmt.setString(6, purchaseVO.getDivyDate());
		stmt.setInt(7, purchaseVO.getTranNo());
		
		stmt.executeUpdate();
		
		con.close();
	}
}
