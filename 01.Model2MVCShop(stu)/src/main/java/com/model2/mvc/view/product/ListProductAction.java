package com.model2.mvc.view.product;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.model2.mvc.common.SearchVO;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;


public class ListProductAction extends Action {

	@Override
	public String execute(	HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("ListProductAction ����");
		SearchVO searchVO=new SearchVO();
		HttpSession session = request.getSession();
		
		String menu = "";
		
		int page=1;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
			if(request.getParameter("menu")==null) {
				session.getAttribute("menu");
			}
		}else{
			if(request.getParameter("menu")!= null) {
				if(request.getParameter("menu").equals("manage")) {
					menu = "manage";
				}else {
					menu = "search";
				}
				session.setAttribute("menu", menu);
			}else {
				System.out.println("null üũ");
			}
		}
		
		searchVO.setPage(page);
		searchVO.setSearchCondition(request.getParameter("searchCondition"));
		searchVO.setSearchKeyword(request.getParameter("searchKeyword"));
		String pageUnit=getServletContext().getInitParameter("pageSize");
		
		searchVO.setPageUnit(Integer.parseInt(pageUnit));
		
		ProductService service=new ProductServiceImpl();
		Map<String,Object> map=service.getProductList(searchVO);

		request.setAttribute("map", map);
		request.setAttribute("searchVO", searchVO);
		request.setAttribute("menu", menu);
		
		System.out.println("ListProductAction ��");
		System.out.println(menu+" menu�� ��");
		
		return "forward:/product/listProduct.jsp";
		
	}
}