package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.product.dao.ProductDAO;
import com.model2.mvc.service.user.dao.UserDao;
import com.model2.mvc.service.domain.*;

//import com.model2.mvc.service.user.dao.UserDao;



public class PurchaseDAO {
	
	public PurchaseDAO(){
	}

	public void insertPurchase(Purchase Purchase) throws Exception {
		System.out.println("::insertPurchase 시작");
		Connection con = DBUtil.getConnection();
		String sql = "INSERT INTO transaction VALUES(seq_transaction_tran_no.NEXTVAL, ?,?,?,?,?,?,?,?,sysdate,?)";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, Purchase.getPurchaseProd().getProdNo());
		stmt.setString(2, Purchase.getBuyer().getUserId());
		stmt.setString(3, Purchase.getPaymentOption());
		stmt.setString(4, Purchase.getReceiverName());
		stmt.setString(5, Purchase.getReceiverPhone());
		stmt.setString(6, Purchase.getDivyAddr());
		stmt.setString(7, Purchase.getDivyRequest());
		stmt.setString(8, Purchase.getTranCode());
		stmt.setString(9, Purchase.getDivyDate());

		System.out.println("insertPurchase : " + stmt.executeUpdate());

		stmt.close();
		con.close();
	}



	public Purchase findPurchase(int tranNo) throws Exception {
		//구매상세보기
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM transaction WHERE tran_no = ?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, tranNo);

		ResultSet rs = stmt.executeQuery();

		rs.next();
		Purchase purchase = new Purchase();
		purchase.setTranNo(rs.getInt("tran_no"));
		purchase.setPurchaseProd(new ProductDAO().findProduct(rs.getInt("prod_no")));
		purchase.setBuyer(new UserDao().findUser(rs.getString("buyer_id")));
		purchase.setPaymentOption(rs.getString("payment_option").trim());
		purchase.setReceiverName(rs.getString("receiver_name"));
		purchase.setReceiverPhone(rs.getString("receiver_phone"));
		purchase.setDivyAddr(rs.getString("demailaddr"));
		purchase.setDivyRequest(rs.getString("divy_request"));
		purchase.setTranCode(rs.getString("tran_status_code").trim());
		purchase.setOrderDate(rs.getDate("order_data"));
		purchase.setDivyDate(rs.getString("divy_date"));

		System.out.println("purchase" + purchase);

		return purchase;
	}
	
	public Purchase findPurchase2(int prodNo) throws Exception {

		Connection con = DBUtil.getConnection();

		String sql = "SELECT tran_no, tran_status_code FROM transaction WHERE prod_no=?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);

		
		ResultSet rs = stmt.executeQuery();

		rs.next();
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(rs.getInt("tran_No"));
		purchase.setTranCode(rs.getString("tran_status_code"));
		
		
		
		con.close();

		return purchase;
	}

	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {

		Map<String , Object>  map = new HashMap<String, Object>();
		
		Connection con = DBUtil.getConnection();
		
		// Original Query 구성
		String sql =("SELECT " +
			     	 "t.tran_no, t.buyer_id, t.receiver_name,  t.receiver_phone, t.tran_status_code " +
			     	 "FROM users u, product p, transaction t " +
			     	 "WHERE t.prod_no = p.prod_no AND u.user_id = t.buyer_id ");	
		sql += " ORDER BY p.prod_no ";
		
		System.out.println("PurchaseDAO::Original SQL :: " + sql);
		
		//==> TotalCount GET
		System.out.println("오류1");
		int totalCount = this.getTotalCount(sql);
		System.out.println("PurchaseDAO :: totalCount  :: " + totalCount);
		System.out.println("오류2");
		//==> CurrentPage 게시물만 받도록 Query 다시구성
		sql = makeCurrentPageSql(sql, search);
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();

		System.out.println("search : "+search);

		List<Purchase> list = new ArrayList<Purchase>();
		
		while(rs.next()) {
			Purchase purchase = new Purchase();
			purchase.setTranNo(rs.getInt("tran_no"));
			purchase.setBuyer(new UserDao().findUser(rs.getString("buyer_id")));
			purchase.setReceiverName(rs.getString("receiver_name"));
			purchase.setReceiverPhone(rs.getString("receiver_phone"));
			purchase.setTranCode(rs.getString("tran_status_code").trim());
			System.out.println(purchase);
			list.add(purchase);
		}
		//==> totalCount 정보 저장
		map.put("totalCount", new Integer(totalCount));
		//==> currentPage 의 게시물 정보 갖는 List 저장
		map.put("list", list);
		
		rs.close();
		pStmt.close();
		con.close();
		

		return map;
	}
	
	public HashMap<String, Object> getSaleList(Search search) throws Exception {

		Connection con = DBUtil.getConnection();

		PreparedStatement stmt = con.prepareStatement("SELECT * FROM transaction", ResultSet.TYPE_SCROLL_INSENSITIVE,
				ResultSet.CONCUR_UPDATABLE);

		ResultSet rs = stmt.executeQuery();

		rs.last();
		int total = rs.getRow();

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("count", new Integer(total));

		rs.absolute(search.getCurrentPage() * search.getPageSize() - search.getPageSize() + 1);
		List<Purchase> list = new ArrayList<Purchase>();

		if (total > 0) {
			for (int i = 0; i < search.getPageSize(); i++) {
				Purchase vo = new Purchase();

				vo.setTranNo(rs.getInt("tran_no"));
				vo.setBuyer(new UserDao().findUser(rs.getString("buyer_id")));
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

	public void updateTranCode(Purchase purchase) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET tran_status_code=? WHERE tran_no=?";
		// 트랜스코드, 구매번호
		PreparedStatement stmt = con.prepareStatement(sql);

		stmt.setString(1, purchase.getTranCode());
		stmt.setInt(2, purchase.getTranNo());
		
		stmt.executeUpdate();
		
		con.close();
	}
	public void updatePurchase(Purchase purchase) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET payment_option=?,receiver_name=?,receiver_phone=?,demailAddr=?,divy_request=?,divy_date=? WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		
		
		stmt.setString(1, purchase.getPaymentOption());
		stmt.setString(2, purchase.getReceiverName());
		stmt.setString(3, purchase.getReceiverPhone());
		stmt.setString(4, purchase.getDivyAddr());
		stmt.setString(5, purchase.getDivyRequest());
		stmt.setString(6, purchase.getDivyDate());
		stmt.setInt(7, purchase.getTranNo());
		
		stmt.executeUpdate();
		
		con.close();
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	private int getTotalCount(String sql) throws Exception {
		
		sql = "SELECT COUNT(*) "+
		          "FROM ( " +sql+ ") countTable";
		
		Connection con = DBUtil.getConnection();
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();
		
		int totalCount = 0;
		if( rs.next() ){
			totalCount = rs.getInt(1);
		}
		
		pStmt.close();
		con.close();
		rs.close();
		
		return totalCount;
	}
	
	// 게시판 currentPage Row 만  return 
	private String makeCurrentPageSql(String sql , Search search){
		sql = 	"SELECT * "+ 
					"FROM (		SELECT inner_table. * ,  ROWNUM AS row_seq " +
									" 	FROM (	"+sql+" ) inner_table "+
									"	WHERE ROWNUM <="+search.getCurrentPage()*search.getPageSize()+" ) " +
					"WHERE row_seq BETWEEN "+((search.getCurrentPage()-1)*search.getPageSize()+1) +" AND "+search.getCurrentPage()*search.getPageSize();
		
		System.out.println("PurchaseDAO :: make SQL :: "+ sql);	
		
		return sql;
	}
}
