<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
<%@ page import="java.util.*"%>
<%@ page import="com.model2.mvc.common.*"%>
<%@ page import="com.model2.mvc.service.domain.*" %>


<%
	HashMap<String, Object> map = (HashMap<String, Object>) request.getAttribute("map");
	Search search = (Search) request.getAttribute("search");
   
   int total = 0;
   List<Product> list = null;
   if (map != null) {
      total = ((Integer) map.get("count")).intValue();
      list = (List<Product>) map.get("list");
   }
   
   int currentPage = search.getCurrentPage();
   
   int totalPage = 0;
   if (total > 0) {
      totalPage = total / search.getPageSize();
      if (total % search.getPageSize() > 0)
         totalPage += 1;
   }
   
   int pageGroup = currentPage % 5;
   int startPage = currentPage / 5 * 5 + 1;
   if(pageGroup == 0) startPage -= 5;
   int endPage = startPage + 4;
   if( endPage > totalPage ) endPage = totalPage;
   
   String menu = (String)session.getAttribute("menu");
--%>




<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
function fncGetList(currentPage) {
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
					
					<td width="93%" class="ct_ttl-01">${!empty menu && menu == 'manage' ? "상품관리" : "상품목록조회"}</td>
							
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
								<option value="0" ${ search.searchCondition eq '0' ? 'selected' : '' }>상품번호</option>
								<option value="1" ${ search.searchCondition eq '1' ? 'selected' : '' }>상품명</option>

			</select>
			<input 	type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : " "}"  
						class="ct_input_g"  style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList('1');">검색</a>
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
			전체 ${ resultPage.totalCount } 건수, 현재  ${ resultPage.currentPage } 페이지
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

	<c:set var="i" value="0" />
		<c:forEach var="product" items="${list}">
		
	<c:set var="i" value="${ i+1 }" />
		
	
	<tr class="ct_list_pop">
		<td align="center">${ i }</td>
		<td></td>
		<td align="left">
			
		<c:if test="${menu=='manage'}">
		<a href="/updateProductView.do?prodNo=${product.prodNo}&${! empty menu && menu == 'manage' ? 'menu=manage' : 'menu=search'}">${product.prodName} </a>	
		</c:if>
		<c:if test="${menu=='search'}">
		<a href="/getProduct.do?prodNo=${product.prodNo}&${! empty menu && menu == 'search' ? 'menu=search' : 'menu=manage'}">${product.prodName} </a>	
		</c:if>
			
		</td>
		<td></td>
		<td align="left">${product.price}</td>
		<td></td>
		<td align="left">${product.regDate}</td>
		<td></td>
						<td align="left">
						<c:if test="${ user.role eq 'admin' && menu eq 'manage' }"> 
							<c:choose>
								<c:when test="${ empty product.proTranCode}">
									판매중
								</c:when>
								<c:when test="${ product.proTranCode eq '1' }">
									결제완료
									<a href="updateTranCodeByProd.do?prodNo=${ product.prodNo }&tranCode=2">배송하기</a>
								</c:when>
								<c:when test="${ product.proTranCode eq '2' }">
									배송중
								</c:when>
								<c:when test="${ product.proTranCode eq '3' }">
									배송완료
								</c:when>
			               </c:choose>
		               </c:if>
		               <c:if test="${!( user.role eq 'admin' && menu eq 'manage' )}"> 
		                   <c:choose>
								<c:when test="${empty product.proTranCode}">
									판매중
								</c:when>
								<c:when test="${ product.proTranCode eq '1' }">
									결제완료
									<a href="updateTranCodeByProd.do?prodNo=${ product.prodNo }&tranCode=2">배송하기</a>
								</c:when>
								<c:when test="${ product.proTranCode eq '2' }">
									배송중
								</c:when>
								<c:when test="${ product.proTranCode eq '3' }">
									배송완료
								</c:when>
							</c:choose> 
		               </c:if>
					</td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
		<input type="hidden" id="currentPage" name="currentPage" value=""/>	

		<jsp:include page="../common/pageNavigator.jsp"/>
	
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
