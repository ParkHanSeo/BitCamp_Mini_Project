package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.*;

public class AddPurchaseViewAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("AddPurchaseViewAction Ω√¿€");
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		System.out.println(prodNo);
		ProductService service = new ProductServiceImpl();
		Product product = service.getProduct(prodNo);
	
		request.setAttribute("product", product);
		System.out.println("AddPurchaseViewAction ≥°");
		
		
		return "forward:/purchase/addPurchaseView.jsp";
	}

}
