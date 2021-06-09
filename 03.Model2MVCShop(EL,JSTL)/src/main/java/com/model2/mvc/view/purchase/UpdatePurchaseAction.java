package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.domain.*;

public class UpdatePurchaseAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		
		Purchase purchase = new Purchase();
		//�����ھ��̵�, ���Ź��, �������̸�, �����ڿ���ó, �������ּ�, ���ſ�û����, ����������
		
		purchase.setPaymentOption(request.getParameter("paymentOption"));
		purchase.setReceiverName(request.getParameter("receiverName"));
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setDivyDate(request.getParameter("receiverDate"));
		purchase.setTranNo(Integer.parseInt(request.getParameter("tranNo")));
		
		

		
		
		
		PurchaseService service = new PurchaseServiceImpl();
		service.updatePurchase(purchase);
		
		return "redirect:/getPurchase.do?tranNo="+tranNo;
	}

}
