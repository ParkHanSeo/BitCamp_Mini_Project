package com.model2.mvc.service.purchase.test;

import java.util.HashMap;
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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class PurchaseServiceTest {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDAO;
		
	/*@Test
	public void testAddPurchase() throws Exception {
		Product product = new Product();
		product.setProdNo(10003);
		
		User user = new User();
		user.setUserId("user01");
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		
		Assert.assertEquals(1, purchaseService.addPurchase(purchase));
	}*/
	
	/*@Test
	public void testAddPurchase() throws Exception{
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		
		product.setProdNo(10020);
		user.setUserId("user01");
		purchase.setPaymentOption("1");
		purchase.setReceiverName("박지훈");
		purchase.setReceiverPhone("010-8623-8243");
		purchase.setDivyAddr("경기파주");
		purchase.setDivyRequest("감사합니다");
		purchase.setTranCode("1");
		purchase.setDivyDate("2020-05-11");
		
		purchaseService.addPurchase(purchase);
		
		Assert.assertEquals(10020, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("박지훈", purchase.getReceiverName());
		Assert.assertEquals("010-8623-8243", purchase.getReceiverPhone());
		Assert.assertEquals("경기파주", purchase.getDivyAddr());
		Assert.assertEquals("감사합니다", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode());
		Assert.assertEquals("2020-05-11", purchase.getDivyDate());
			
	}*/
	
	/*@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		purchase = purchaseService.getPurchase(10083);
		
		System.out.println(purchase);
		
		Assert.assertEquals(10020, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("박지훈", purchase.getReceiverName());
		Assert.assertEquals("010-8623-8243", purchase.getReceiverPhone());
		Assert.assertEquals("경기파주", purchase.getDivyAddr());
		Assert.assertEquals("감사합니다", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode().trim());
		//Assert.assertEquals("2020-05-11", purchase.getDivyDate());
	}*/
	
	/*@Test
	public void testUpdatePurchase() throws Exception{
		
		Purchase purchase = purchaseService.getPurchase(10083);	
		Product product = new Product();
		User user = new User();
		System.out.println(purchase);
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("박지훈", purchase.getReceiverName());
		Assert.assertEquals("010-8623-8243", purchase.getReceiverPhone());
		Assert.assertEquals("경기파주", purchase.getDivyAddr());
		Assert.assertEquals("감사합니다", purchase.getDivyRequest());
		//Assert.assertEquals("2020-05-11", purchase.getDivyDate());
		
		
		purchase.setPaymentOption("2");
		purchase.setReceiverName("박한서");
		purchase.setReceiverPhone("010-3014-8243");
		purchase.setDivyAddr("문산읍");
		purchase.setDivyRequest("바뀐요청");
		//purchase.setDivyDate("2020-06-21");
		
		purchaseService.updatePurchase(purchase);
		
		System.out.println("여기는 purchase : "+purchase);
		
		purchase = purchaseService.getPurchase(10083);
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("박지훈", purchase.getReceiverName());
		Assert.assertEquals("010-8623-8243", purchase.getReceiverPhone());
		Assert.assertEquals("경기파주", purchase.getDivyAddr());
		Assert.assertEquals("감사합니다", purchase.getDivyRequest());
		//Assert.assertEquals("2021-06-21", purchase.getDivyDate());

	}*/
	
	/*@Test
	public void testUpdateTranNo() throws Exception{
		
		Purchase purchase = new Purchase();
		
		purchase.setTranNo(10083);
		purchase.setTranCode("2");
		
		purchaseService.updateTranCode(purchase);
		
		Purchase updatedPurchase = purchaseService.getPurchase(purchase.getTranNo());
		
		Assert.assertEquals("2", purchase.getTranCode().trim());
		
	}*/
	
	@Test
	public void testGetPurchaseListAll() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map = purchaseService.getPurchaseList(search, "user01");
		
		List<Object> list = (List<Object>) map.get("list");
		
		System.out.println("totalCount : " + map.get("count"));
		
		Assert.assertEquals(3, list.size());
		
		
	}
	
	
	
}











