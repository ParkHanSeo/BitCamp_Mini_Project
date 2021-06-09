package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.dao.ProductDAO;
import com.model2.mvc.service.domain.Product;

public class ProductServiceImpl implements ProductService{
	
	private ProductDAO productDAO;
	
	public ProductServiceImpl() {
		productDAO=new ProductDAO();
	}

	public void addProduct(Product product) throws Exception {
		productDAO.insertProduct(product);
	}


	public Product getProduct(int prodNo) throws Exception {
		return productDAO.findProduct(prodNo);
	}
	

	public void updateProduct(Product product) throws Exception {
		productDAO.updateProduct(product);
	}

	@Override
	public HashMap<String, Object> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return (HashMap<String, Object>) productDAO.getProductList(search);
	}

	

	

}
