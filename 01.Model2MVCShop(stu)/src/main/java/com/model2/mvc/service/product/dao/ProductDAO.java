package com.model2.mvc.service.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.purchase.vo.PurchaseVO;


public class ProductDAO {
	
	public ProductDAO(){
	}

	
	public void insertProduct(ProductVO productVO) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = (" insert "+
		 			  " into product "+
					  " values (seq_product_prod_no.NEXTVAL, ? , ? , ? , ? , ? ,sysdate) ");
		
		PreparedStatement stmt = con.prepareStatement(sql);
		//상품명, 상품상세정보, 제조일자, 가격
		stmt.setString(1, productVO.getProdName());
		stmt.setString(2, productVO.getProdDetail());
		stmt.setString(3, productVO.getManuDate().replaceAll("[\\s\\-()]", ""));	
		stmt.setInt(4, productVO.getPrice());
		stmt.setString(5, productVO.getFileName());
		
		stmt.executeUpdate();
		
		con.close();
		
	}



	public ProductVO findProduct(int prodNo) throws Exception {
		
		Connection con = DBUtil.getConnection();
		//상품명나 달아놓고
		String sql = " select * from PRODUCT "+
					 " where PROD_NO = ? ";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);

		ResultSet rs = stmt.executeQuery();
		//상품번호, 상품명, 이미지?, 상품상세정보, 제조일자, 가격, 등록일자
		ProductVO productVO = null;
		while (rs.next()) {
			productVO = new ProductVO();
			
			productVO.setProdNo(rs.getInt("PROD_NO"));
			productVO.setProdName(rs.getString("PROD_NAME"));
			productVO.setProdDetail(rs.getString("PROD_DETAIL"));
			productVO.setManuDate(rs.getString("MANUFACTURE_DAY"));
			productVO.setPrice(rs.getInt("PRICE"));
			productVO.setFileName(rs.getString("IMAGE_FILE"));
			productVO.setRegDate(rs.getDate("REG_DATE"));
			
		}
		
		con.close();

		return productVO;
	}

	public HashMap<String,Object> getProductList(SearchVO searchVO) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = " SELECT " +
					 " p.prod_no, p.prod_name, p.prod_detail, p.manufacture_day, " +
					 " p.price, p.image_file, p.reg_date, t.tran_status_code " +
					 " FROM product p, transaction t " +
					 " WHERE p.prod_no = t.prod_no(+) ";
					 
		
		if (searchVO.getSearchCondition() != null) {
			if (searchVO.getSearchCondition().equals("0")) {
				sql += " AND p.prod_no ='" + searchVO.getSearchKeyword() + "'";
			} else if (searchVO.getSearchCondition().equals("1")) {
				sql += " AND p.prod_name ='" + searchVO.getSearchKeyword() + "'";
			}
		}
		sql += " ORDER BY p.prod_no(+) ";
		
		

		PreparedStatement stmt = 
			con.prepareStatement(	sql,
														ResultSet.TYPE_SCROLL_INSENSITIVE,
														ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery();

		//3. 총 Row수 구함
		rs.last();
		int totalUnit = rs.getRow();
		System.out.println("상품 총 줄수 : " + totalUnit);
		System.out.println("==========" +sql);
		//4. 반환할 map에 총 Row수를 저장
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("count", new Integer(totalUnit));
				
		//5. 커서를 목표 페이지에 맞게 이동시킴
		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit() + 1);
		System.out.println("searchVO.getPage():" + searchVO.getPage());
		System.out.println("searchVO.getPageUnit():" + searchVO.getPageUnit());

		//목표 page에 출력하기위해 pageUnit만큼 list에 ProductVO저장
		List<ProductVO> list = new ArrayList<ProductVO>();
		List<PurchaseVO> list2 = new ArrayList<PurchaseVO>();
		if (totalUnit > 0) {
			for (int i = 0; i < searchVO.getPageUnit(); i++) {
				ProductVO productVO = new ProductVO();
				PurchaseVO purchaseVO = new PurchaseVO();
				productVO.setProdNo(rs.getInt("prod_no"));
				productVO.setProdName(rs.getString("prod_name"));
				productVO.setPrice(rs.getInt("price"));
				productVO.setRegDate(rs.getDate("reg_date"));
				purchaseVO.setPurchaseProd(productVO);
				purchaseVO.setTranCode(rs.getString("tran_status_code"));
				list.add(productVO);
				list2.add(purchaseVO);
				System.out.println("trancode check"+purchaseVO.getTranCode());
				//목표 page의 pageUnit만큼보다 DB에 저장된 개수가 적을 경우
				if (!rs.next())
					break;
			}
		}
		System.out.println("list.size() : " + list.size());
		map.put("list", list);
		map.put("list2", list2);
		System.out.println("map.size() : " + map.size());

		con.close();

		return map;
	}

	

	
	public void updateProduct(ProductVO productVO) throws Exception {
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE product SET prod_name=?,prod_detail=?,price=?,manufacture_day=?, image_file =? where prod_no=?";
		//상품번호, 상품명, 상품상세정보, 제조일자, 가격, 등록일자
		PreparedStatement stmt = con.prepareStatement(sql);
		
		stmt.setString(1, productVO.getProdName());
		stmt.setString(2, productVO.getProdDetail());
		stmt.setInt(3, productVO.getPrice());
		stmt.setString(4, productVO.getManuDate());
		stmt.setString(5, productVO.getFileName());
		stmt.setInt(6, productVO.getProdNo());
		stmt.executeUpdate();
		
		con.close();
	}
	
}