package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	//Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//@RequestMapping("/addProduct.do")
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product) throws Exception{
		
		System.out.println("/addProduct.do 실행");
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		productService.addProduct(product);
					
		return "redirect:/product/addProductView.jsp";
	}
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value="listProduct")
	public String listProduct(@ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct 실행");
		HttpSession session = request.getSession();
		String menu = "";
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(request.getParameter("menu")!= null) {
			if(request.getParameter("menu").equals("manage")) {
				menu = "manage";
			}else {
				menu = "search";
			}
			session.setAttribute("menu", menu);
		}else {
			System.out.println("null 체크");
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object > map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		System.out.println("map 확인 : "+map);
		return "forward:/product/listProduct.jsp";
	}
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct", method=RequestMethod.GET)
	public String getProduct(@RequestParam("prodNo") int prodNo , Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		System.out.println("/getProduct.do 실행");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		String history = String.valueOf(product.getProdNo())+",";

		Cookie[] cookies = request.getCookies();
		for(Cookie c : cookies) {
			if (c.getName().equals("history")) {
				String check = c.getValue();
				if(check != history) {
					c.setValue(check.concat(history));
					response.addCookie(c);
				} 
			} else {
				response.addCookie(new Cookie("history", history));
			}
		}
		
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product")Product product, 
								@RequestParam("prodNo")int prodNo,
								Model model)throws Exception{
		
		System.out.println("/updateProduct 실행");
		
		productService.updateProduct(product);
		
		model.addAttribute("product", product);
		
		System.out.println(prodNo+" 여기는 prodNo");
		return "redirect:/product/getProduct?prodNo="+prodNo;
	}
	
	//@RequestMapping("/updateProductView.do")
	@RequestMapping(value="updateProductView", method=RequestMethod.GET)
	public String updateProductView(@RequestParam("prodNo")int prodNo, Model model )throws Exception{
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product",productService.getProduct(prodNo));
		
		model.addAttribute("product",product);
		
		return "forward:/product/updateProductView.jsp";
		
	}
	
}
