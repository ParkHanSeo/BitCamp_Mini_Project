package com.model2.mvc.view.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;


public class ListProductAction extends Action {

	@Override
	public String execute(	HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("ListProductAction ����");
		Search search=new Search();
		HttpSession session = request.getSession();
		
		String menu = "";
		String list = "";
		int currentPage=1;
		
		if(request.getParameter("currentPage") != null){
			System.out.println(currentPage);
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		
		
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
		
		
		search.setCurrentPage(currentPage);
		search.setSearchCondition(request.getParameter("searchCondition"));
		search.setSearchKeyword(request.getParameter("searchKeyword"));
		
		// web.xml  meta-data �� ���� ��� ���� 
		int pageSize = Integer.parseInt( getServletContext().getInitParameter("pageSize"));
		int pageUnit  =  Integer.parseInt(getServletContext().getInitParameter("pageUnit"));
		search.setPageSize(pageSize);
		
		// Business logic ����
		
		ProductService productService = new ProductServiceImpl();
		Map<String , Object> map = productService.getProductList(search);	
		System.out.println(currentPage+"currentPage");
		
		Page resultPage	= 
				new Page(currentPage,((Integer)map.get("totalCount")).intValue(), 
							pageUnit,pageSize);
		System.out.println("ListProductAction :: "+resultPage);
		
		// Model �� View ����
		
		request.setAttribute("list", map.get("list"));
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		request.setAttribute("menu", menu);
		request.setAttribute("map", map);
		
		System.out.println("list�� ���� =" +list);
		System.out.println("menu�� ���� = "+menu);
		System.out.println("ListProductAction ��");
		
		return "forward:/product/listProduct.jsp";
	}

}