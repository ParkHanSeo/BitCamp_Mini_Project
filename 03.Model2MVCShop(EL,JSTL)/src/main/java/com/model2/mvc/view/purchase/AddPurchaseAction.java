package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.dao.ProductDAO;
import com.model2.mvc.service.domain.*;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;


public class AddPurchaseAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		Product product = new ProductDAO().findProduct(Integer.parseInt(request.getParameter("prodNo")));
		Purchase purchase = new Purchase();

		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setPaymentOption(request.getParameter("paymentOption"));
		purchase.setReceiverName(request.getParameter("receiverName"));
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setTranCode("1");
		purchase.setDivyDate(request.getParameter("receiverDate"));

		PurchaseService service = new PurchaseServiceImpl();
		service.addPurchase(purchase);
		request.setAttribute("purchase", purchase);
		

		return "forward:/purchase/addPurchase.jsp";

	}

}
