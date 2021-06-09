package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.purchase.vo.PurchaseVO;

public class UpdateTranCodeByProdAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("UpdateTranCodeByProdAction 시작");
		
		String prodNo = request.getParameter("prodNo");
		String tranCode = request.getParameter("tranCode");
		
		PurchaseService service = new PurchaseServiceImpl();
		
		PurchaseVO purchaseVO = service.getPurchase2(Integer.parseInt(prodNo));
		purchaseVO.setTranCode(tranCode);
		System.out.println(purchaseVO);
		
		
		
		service.updateTranCode(purchaseVO);
		System.out.println(purchaseVO);
		

		

		System.out.println("UpdateTranCodeByProdAction 시작");
		
		return "redirect:/listProduct.do?menu=manage";
	}

}
