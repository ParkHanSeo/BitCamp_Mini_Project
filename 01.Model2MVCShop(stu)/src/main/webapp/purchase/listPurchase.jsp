<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.util.*" %>
<%@ page import="com.model2.mvc.service.purchase.vo.*" %>
<%@ page import="com.model2.mvc.service.product.vo.*" %>
<%@ page import="com.model2.mvc.service.user.vo.*" %>
<%@ page import="com.model2.mvc.common.*" %>

<%
	HashMap<String,Object> map=(HashMap<String,Object>)request.getAttribute("map");
	SearchVO searchVO=(SearchVO)request.getAttribute("searchVO");
	
	int total=0;
	ArrayList<PurchaseVO> list=null;
	if(map != null){
		total=((Integer)map.get("count")).intValue();
		list=(ArrayList<PurchaseVO>)map.get("list");
	}
	
	int currentPage=searchVO.getPage();
	
	int totalPage=0;
	if(total > 0) {
		totalPage= total / searchVO.getPageUnit() ;
		if(total%searchVO.getPageUnit() >0)
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
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetPurchaseList() {
		document.detailForm.submit();
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listUser.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >전체  <%= total%> 건수, 현재 <%=currentPage %> 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<% 	
		int no=list.size();
		for(int i=0; i<list.size(); i++) {
			PurchaseVO vo = (PurchaseVO)list.get(i);
	%>
	
	<tr class="ct_list_pop">
		<td align="center">
			<a href="/getPurchase.do?tranNo=<%=vo.getTranNo()%>"><%=no-- %></a>
		</td>
		<td></td>
		<td align="left">
			<a href="/getUser.do?userId=<%=vo.getBuyer().getUserId()%>"><%=vo.getBuyer().getUserId()%></a>
		</td>
		<td></td>
		<td align="left"><%=vo.getBuyer().getUserName()%></td>
		<td></td>
		<td align="left"><%=vo.getBuyer().getPhone()%></td>
		<td></td>
		
						 <% if(vo.getTranCode().equals("1")) { %>
						 		<td align="left">구매완료한 상품이며 배송 준비중입니다.</td>
						<% } else if(vo.getTranCode().equals("2")) { %>
								<td align="left">상품이 배송중입니다.</td>
						<% } else if(vo.getTranCode().equals("3")) { %>
								<td align="left">상품 수령 완료되었습니다.</td>
						<% } %> 
		
		<td></td>
		<td align="left">
						<% if(vo.getTranCode().equals("2")) { %>
							<a href="/updateTranCode.do?tranNo=<%= vo.getTranNo() %>&tranCode=3"/>수령 확인</a>
						<% } %> 			
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		 
		<% for(int i=1;i<=totalPage;i++){ %>
				<a href="/listPurchase.do?page=<%=i%>"><%=i %></a>
		<% } %>
		
		
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>