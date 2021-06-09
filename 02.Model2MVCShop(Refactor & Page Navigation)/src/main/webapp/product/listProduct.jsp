  
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ page import="java.util.List"  %>


<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="com.model2.mvc.service.domain.*" %>


<%
	List<Product> list= (List<Product>)request.getAttribute("list");
	List<Purchase> list2= (List<Purchase>)request.getAttribute("list2");
	Page resultPage=(Page)request.getAttribute("resultPage");
	String menu = (String)session.getAttribute("menu");

	System.out.println("list : "+list);
	System.out.println("list2 : "+list2);
	
	
	Search search = (Search)request.getAttribute("search");
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>



<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetProductList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();		
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listProduct.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					
					
							<% 
								if(menu.equals("manage")) {
							%>
								<td width="93%" class="ct_ttl01">상품 관리</td>
							<%
								} else if(menu.equals("search")) {
							%>
								<td width="93%" class="ct_ttl01">상품 목록조회</td>
							<%
								}
							%>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" <%= (searchCondition.equals("0") ? "selected" : "")%>>상품번호</option>
				<option value="1" <%= (searchCondition.equals("1") ? "selected" : "")%>>상품명</option>
			</select>
			<input 	type="text" name="searchKeyword" value="<%= searchKeyword %>"  class="ct_input_g" 
							style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetUserList('1');">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			전체  <%= resultPage.getTotalCount() %> 건수,	현재 <%= resultPage.getCurrentPage() %> 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%
		for(int i=0; i<list.size(); i++) {
			Product productVO = list.get(i);
			Purchase purchaseVO = list2.get(i);
	%>
		
	<tr class="ct_list_pop">
		<td align="center"><%= i+1 %></td>
		<td></td>
		<td align="left">
			
			<% if(menu.equals("manage")){ %>
			<a href="/updateProductView.do?prodNo=<%=productVO.getProdNo() %>"><%= productVO.getProdName() %></a>
			<% } else if(menu.equals("search")){ %>
			<a href="/getProduct.do?prodNo=<%=productVO.getProdNo() %>"><%= productVO.getProdName() %></a>
			<% } %>
			
		</td>
		<td></td>
		<td align="left"><%= productVO.getPrice() %></td>
		<td></td>
		<td align="left"><%= productVO.getRegDate() %></td>
		<td></td>
		
		<% if(((User)session.getAttribute("user")).getRole().equals("admin") && menu.equals("manage")) { %>
		
		   <%if(purchaseVO.getTranCode()==null){%>
				<td align="left">판매중</td>
		   <%}else if(purchaseVO.getTranCode().trim().equals("1")){%>  
				<td align="left">결제완료 
				  <a href="updateTranCodeByProd.do?prodNo=<%= productVO.getProdNo() %>&tranCode=2">배송하기</a>
				</td>
		   <%}else if(purchaseVO.getTranCode().trim().equals("2")){%>
				<td align="left">배송중</td>
		   <%}else if(purchaseVO.getTranCode().trim().equals("3")){%>			
				<td align="left">배송완료</td>
		   <%}%>
				
		<%}else{%>
			
		  <%if(purchaseVO.getTranCode()==null){ %>
				<td align="left">판매중</td>
		  <%}else if(	purchaseVO.getTranCode().trim().equals("1")){%>  
				<td align="left">결제완료 </td>
		  <%}else if(purchaseVO.getTranCode().trim().equals("2")){%>
				<td align="left">배송중</td>
		  <%}else if(purchaseVO.getTranCode().trim().equals("3")){%>			
				<td align="left">배송완료</td>
		  <%}%>
		  
	    <%}%>	
					</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
				<% } // End of product list for문 %>
			</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %>
		
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>

</div>
</body>
</html>
