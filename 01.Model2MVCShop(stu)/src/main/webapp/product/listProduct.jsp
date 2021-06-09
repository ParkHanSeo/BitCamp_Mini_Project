  
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ page import="java.util.*"%>
<%@ page import="com.model2.mvc.common.*"%>
<%@ page import="com.model2.mvc.service.product.vo.*"%>
<%@ page import="com.model2.mvc.service.user.vo.*" %>
<%@ page import="com.model2.mvc.service.purchase.vo.*" %>

<%
	HashMap<String, Object> map = (HashMap<String, Object>) request.getAttribute("map");
	SearchVO searchVO = (SearchVO) request.getAttribute("searchVO");
	
	UserVO userVO = (UserVO)session.getAttribute("userVO");
	String menu = (String)session.getAttribute("menu");
	
   int total = 0;
   List<ProductVO> list = null;
   List<PurchaseVO> list2 = null;
   if (map != null) {
      total = ((Integer) map.get("count")).intValue();
      list = (List<ProductVO>) map.get("list");
   	  list2 = (List<PurchaseVO>)map.get("list2");
   }
   
   int currentPage = searchVO.getPage();
   
   int totalPage = 0;
   if (total > 0) {
      totalPage = total / searchVO.getPageUnit();
      if (total % searchVO.getPageUnit() > 0)
         totalPage += 1;
   }
   
   int pageGroup = currentPage % 5;
   int startPage = currentPage / 5 * 5 + 1;
   if(pageGroup == 0) startPage -= 5;
   int endPage = startPage + 4;
   if( endPage > totalPage ) endPage = totalPage;
   
   
%>



<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">

function fncGetProductList(){
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
	<%
		if(searchVO.getSearchCondition() != null) {
	%>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
		<%
				if(searchVO.getSearchCondition().equals("0")){
		%>
				<option value="0" selected>상품번호</option>
				<option value="1">상품명</option>
				
		<%
				}else {
		%>
				<option value="0">상품번호</option>
				<option value="1" selected>상품명</option>
		<%
				}
		%>
				
			</select>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" />
		</td>
	<%
		}else{
	%>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0">상품번호</option>
				<option value="1">상품명</option>
			</select>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" >
		</td>
	<%
		}
	%>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList();">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체  <%= total%> 건수, 현재 <%=currentPage %> 페이지</td>
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
		int no=list.size();
		for(int i=0; i<list.size(); i++) {
			ProductVO productVO = (ProductVO)list.get(i);
			PurchaseVO purchaseVO = (PurchaseVO)list2.get(i);
	%>
		
	<tr class="ct_list_pop">
		<td align="center">
			<%=no--%>
		</td>
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
		
		<% if(((UserVO)session.getAttribute("user")).getRole().equals("admin") && menu.equals("manage")) { %>
		
		   <%if(purchaseVO.getTranCode()==null){%>
				<td align="left">판매중</td>
		   <%}else if(purchaseVO.getTranCode().trim().equals("1")){%>  
				<td align="left">결제완료 
				  <a href="/updateTranCodeByProd.do?prodNo=<%= productVO.getProdNo() %>&tranCode=2">배송하기</a>
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
		
		
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
		<% for(int i=1;i<=totalPage;i++){ %>
			<% if(searchVO.getSearchCondition()==null && searchVO.getSearchKeyword()==null) { %>
				<a href="/listProduct.do?page=<%=i%>"><%=i %></a>
			<% } else {%>
				<a href="/listProduct.do?searchKeyword=<%=request.getParameter("searchKeyword")%>&page=<%=i%>&searchCondition=<%=request.getParameter("searchCondition")%>"><%=i %></a>
			<% } %>
		<% } %>
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
