package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class ProductServiceTest {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDAO;

	//@Test
	/*public void testAddProduct() throws Exception {

		Product product = new Product();
		product.setProdName("testPnam");
		product.setProdDetail("testDeta");
		product.setManuDate("testManu");
		product.setPrice(1234);
		product.setFileName("testFile");
		
		productService.addProduct(product);
		
		Assert.assertEquals("testPnam", product.getProdName());
		Assert.assertEquals("testDeta", product.getProdDetail());
		Assert.assertEquals("testManu", product.getManuDate());
		Assert.assertEquals(1234, product.getPrice());
		Assert.assertEquals("testFile", product.getFileName());
	}*/
	
	//@Test
	/*public void testGetProduct() throws Exception {

		Product product = new Product();
		
		product = productService.getProduct(10130);
		
		Assert.assertEquals("testPnam", product.getProdName());
		Assert.assertEquals("testDeta", product.getProdDetail());
		Assert.assertEquals("testManu", product.getManuDate());
		Assert.assertEquals(1234, product.getPrice());
		Assert.assertEquals("testFile", product.getFileName());
		
		Assert.assertNotNull(productService.getProduct(10130));

	}*/
	
	
	
	/*@Test
	public void testUpdateProduct() throws Exception {
		
		Product product = productService.getProduct(10130);
		System.out.println(product+"여기는 product");
		Assert.assertNotNull(product);
	
		Assert.assertEquals("testPnam", product.getProdName());
		Assert.assertEquals("testDeta", product.getProdDetail());
		Assert.assertEquals("testManu", product.getManuDate());
		Assert.assertEquals(1234, product.getPrice());
		Assert.assertEquals("testFile", product.getFileName());
		
		product.setProdName("estPnam");
		product.setProdDetail("estDeta");
		product.setManuDate("estManu");
		product.setPrice(5678);
		product.setFileName("estFile");
		
		productService.updateProduct(product);
		
		product = productService.getProduct(10130);
		Assert.assertNotNull(product);
		
		Assert.assertEquals("estPnam", product.getProdName());
		Assert.assertEquals("estDeta", product.getProdDetail());
		Assert.assertEquals("estManu", product.getManuDate());
		Assert.assertEquals(5678, product.getPrice());
		Assert.assertEquals("estFile", product.getFileName());
		 
	}*/
	
		
	
	@Test
	public void testGetProductListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	System.out.println("여긴 search"+search);
	 	Map<String,Object> map = productService.getProductList(search);
	 	System.out.println("여긴 map "+map);
	 	List<Object> list = (List<Object>)map.get("list");
	 	System.out.println("여기는 list "+list.size());
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console 확인
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	
	//@Test
	public void testGetOrderedProductList() throws Exception {
		
		//판매중인 상품 테스트
		Search search = new Search();
		search.setCurrentPage(1);
	 	search.setPageSize(3);
		//search.setOrderCondition("0");
		Map<String, Object> map = productService.getProductList(search);
		
		List<Object> list = (List<Object>) map.get("list");
		System.out.println("총 검색 갯수 :: "+map.get("totalCount"));
		
		Assert.assertEquals(3, list.size());
		
	}
	
	//@Test
	public void testGetUserListByUserId() throws Exception{
			 
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("0");
		search.setSearchKeyword("10020");
		Map<String,Object> map = productService.getProductList(search);
		 	
		List<Object> list = (List<Object>)map.get("list");
		Assert.assertEquals(1, list.size());
		 	
		//==> console 확인
		//System.out.println(list);
		 	
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		 	
		System.out.println("=======================================");
		 	
		search.setSearchCondition("0");
		search.setSearchKeyword(""+System.currentTimeMillis());
		map = productService.getProductList(search);
		 	
		list = (List<Object>)map.get("list");
		Assert.assertEquals(0, list.size());
		 	
		//==> console 확인
		//System.out.println(list);
		 	
		totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		}

	//@Test
	 public void testGetUserListByUserName() throws Exception{
			 
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("1");
		Map<String,Object> map = productService.getProductList(search);
		 	
		List<Object> list = (List<Object>)map.get("list");
		Assert.assertEquals(2, list.size());
		 	
		//==> console 확인
		System.out.println(list);
		 	
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		 	
		System.out.println("=======================================");
		 	
		search.setSearchCondition("1");
		search.setSearchKeyword(""+System.currentTimeMillis());
		map = productService.getProductList(search);
		 	
		list = (List<Object>)map.get("list");
		Assert.assertEquals(0, list.size());
		 	
		//==> console 확인
		System.out.println(list);
		 	
		totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	 }

}// end of class
