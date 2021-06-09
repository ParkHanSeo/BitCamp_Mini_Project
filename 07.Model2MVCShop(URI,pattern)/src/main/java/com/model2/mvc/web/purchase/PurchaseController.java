package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	//Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	

		
	public PurchaseController() {
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
	
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, 
						@RequestParam("buyerId") String buyerId, @RequestParam("prodNo") int prodNo,
						Model model) throws Exception{
		
		System.out.println("/addPurchase.do 실행");
		
		purchase.setBuyer(userService.getUser(buyerId));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setTranCode("1");
		
		model.addAttribute("purchase", purchase);
		
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	//@RequestMapping("/addPurchaseView.do")
	@RequestMapping(value="addPurchaseView", method=RequestMethod.GET)
	public String addPurchaseView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/addPurchaseView.do 실행");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);

		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model)throws Exception{
		
		System.out.println("/getPurchase.do 실행");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping(value="listPurchase")
	public String listPurchase(@ModelAttribute Search search , Model model, HttpServletRequest request)throws Exception{
		
		System.out.println("/listPurchase.do 실행");
		
		HttpSession session = request.getSession();
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = ((User)session.getAttribute("user")).getUserId();
		// Business logic 수행
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		System.out.println("map 확인"+ map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("map", map);
		
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value="updatePurchaseView", method=RequestMethod.GET)
	public String updatePurchaseView(@RequestParam("tranNo")int tranNo, Model model)throws Exception{
		
		System.out.println("/updatePurchaseView.do");
		
		model.addAttribute("purchase", purchaseService.getPurchase(tranNo));
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase(@ModelAttribute("purchase")Purchase purchase,
								 @RequestParam("tranNo")int tranNo, Model model)throws Exception{
		
		System.out.println("/updatePurchase 실행");
		
		
		purchaseService.updatePurchase(purchase);
	
		model.addAttribute("purchase", purchase);
		
		
		
		return "redirect:/purchase/getPurchase?tranNo="+tranNo;
	}
	
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode(@ModelAttribute("purchase")Purchase purchase,
								 @RequestParam("tranCode")String tranCode,
								 @RequestParam("tranNo")int tranNo, Model model)throws Exception{
		
		System.out.println("updateTranCode 실행");
		
		purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		model.addAttribute("purchase", purchase);		
		
		return "redirect:/purchase/listPurchase?tranNo="+tranNo;
	}
	
	//@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd(@ModelAttribute("purchase")Purchase purchase,
									   @RequestParam("tranCode")String tranCode,
									   @RequestParam("prodNo")int prodNo, Model model)throws Exception{
		
		System.out.println("updateTranCodeByProd 실행");
		
		purchase = purchaseService.getPurchase2(prodNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		model.addAttribute("purchase", purchase);
		
		
		return "redirect:/product/listProduct?menu=manage";
	}
	
	
}















