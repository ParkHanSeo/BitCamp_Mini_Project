package com.model2.mvc.framework;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.util.HttpUtil;


public class ActionServlet extends HttpServlet {
	
	///Field
	private RequestMapping requestMapping;
	
	///Method
	@Override
	public void init() throws ServletException {
		super.init();
		String resources = getServletConfig().getInitParameter("resources");
		//getServletConfig = Servlet이 시작할 때 필요한 정보가 담긴 ServletConfig를 반환합니다.
		//getInitParameter = 매개변수로 web.xml에서 지정했던 param-name을 넘겨주면 그에 해당하는 값을 가져옵니다.
		System.out.println(resources+" = resources의 값");
		
		requestMapping = RequestMapping.getInstance(resources);
		
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) 
																						throws ServletException, IOException {
		
		String url = request.getRequestURI();
		String contextPath = request.getContextPath();
		String reqeustPath = url.substring(contextPath.length());
		System.out.println("\nActionServlet.service() RequestURI : "+reqeustPath);
		
		
		try{
			Action action = requestMapping.getAction(reqeustPath);
			action.setServletContext(getServletContext());
//ServletContext(표준 파일 구조): html, jsp, servlet 등 각종 resource에 대한 정보를 가지고 있다.
			
			String resultPage=action.execute(request, response);
			
			String path=resultPage.substring(resultPage.indexOf(":")+1);
			
			if(resultPage.startsWith("forward:")){
				HttpUtil.forward(request, response, path);
			}else{
				HttpUtil.redirect(response, path);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}