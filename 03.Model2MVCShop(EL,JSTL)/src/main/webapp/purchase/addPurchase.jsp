<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
<%@page import="com.model2.mvc.service.domain.*"%>


<%
	Purchase purchase = (Purchase)request.getAttribute("purchase");
%>
 --%>


<html>
<head>
<title>구매 정보 확인</title>
</head>

<body>

 <form name="addPurchase" action="/addPurchaseView.do?tranNo=${purchase.tranNo}" method="post">

다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td>${purchase.purchaseProd.prodNo}</td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td>${purchase.buyer.userId}</td>
	</tr>
	<tr>
		<td>구매방법</td>
		
			
			<c:if test="${purchase.tranCode == '1' }">
				<td>
					현금구매
				</td>
			</c:if>
			<c:if test="${purchase.tranCode == '2' }">
				<td>
					신용구매
				</td>
			</c:if>
					
		
	</tr>
	<tr>
		<td>구매자이름</td>
		<td>${purchase.receiverName}</td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td>${purchase.receiverPhone}</td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td>${purchase.divyAddr}</td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td>${purchase.divyRequest}</td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td>${purchase.divyDate}</td>
	</tr>
</table>
</form>

</body>
</html>
