package com.model2.mvc.service.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;


public class ProductDAO {
	
	public ProductDAO(){
	}

	
	public void insertProduct(Product productVO) throws Exception {
		
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



	public Product findProduct(int prodNo) throws Exception {
		
		Connection con = DBUtil.getConnection();
		//상품명나 달아놓고
		String sql = " select * from PRODUCT "+
					 " where PROD_NO = ? ";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);

		ResultSet rs = stmt.executeQuery();
		//상품번호, 상품명, 이미지?, 상품상세정보, 제조일자, 가격, 등록일자
		Product productVO = null;
		while (rs.next()) {
			productVO = new Product();
			
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

	public Map<String , Object> getProductList(Search search) throws Exception {
		
		Map<String , Object>  map = new HashMap<String, Object>();
		
		Connection con = DBUtil.getConnection();
		
		// Original Query 구성
		String sql = " SELECT " +
					 " p.prod_no, p.prod_name, " +
					 " p.price, p.reg_date, t.tran_status_code " +
					 " FROM product p, transaction t " +
					 " WHERE p.prod_no = t.prod_no(+) ";
		
		if (search.getSearchCondition() != null) {
			if ( search.getSearchCondition().equals("0") &&  !search.getSearchKeyword().equals("") ) {
				sql += " AND p.prod_no like '%" + search.getSearchKeyword()+"%'";
			} else if ( search.getSearchCondition().equals("1") && !search.getSearchKeyword().equals("")) {
				sql += " AND p.prod_name like '%" + search.getSearchKeyword()+"%'";			}
		}
		
		sql += " ORDER BY p.prod_no(+) ";
		
		System.out.println("ProductDAO::Original SQL :: " + sql);
		
		//==> TotalCount GET
		int totalCount = this.getTotalCount(sql);
		System.out.println("ProductDAO :: totalCount  :: " + totalCount);
		
		//==> CurrentPage 게시물만 받도록 Query 다시구성
		sql = makeCurrentPageSql(sql, search);
		PreparedStatement stmt =  con.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
	
		System.out.println(search);
		//목표 page에 출력하기위해 pageUnit만큼 list에 ProductVO저장
		List<Product> list = new ArrayList<Product>();
		
		while(rs.next()) {
				Product product = new Product();
				product.setProdNo(rs.getInt("prod_no"));
				product.setProdName(rs.getString("prod_name"));
				product.setPrice(rs.getInt("price"));
				product.setRegDate(rs.getDate("reg_date"));
				product.setProTranCode(rs.getString("tran_status_code").trim());
				list.add(product);
				//목표 page의 pageUnit만큼보다 DB에 저장된 개수가 적을 경우
				
			
		}		
				map.put("totalCount", new Integer(totalCount));
				System.out.println("list.size() : " + list.size());
				map.put("list", list);
				System.out.println("map.size() : " + map.size());

				rs.close();
				stmt.close();
				con.close();

				return map;
		}
	

	
	public void updateProduct(Product productVO) throws Exception {
		
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
				
				System.out.println("ProductDAO :: make SQL :: "+ sql);	
				
				return sql;
			}
	
}