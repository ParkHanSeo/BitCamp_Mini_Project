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
<title>���� ���� Ȯ��</title>
</head>

<body>



������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td>${purchase.purchaseProd.prodNo}</td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td>${purchase.buyer.userId}</td>
	</tr>
	<tr>
		<td>���Ź��</td>
		
			
			<c:if test="${purchase.tranCode == '1' }">
				<td>
					���ݱ���
				</td>
			</c:if>
			<c:if test="${purchase.tranCode == '2' }">
				<td>
					�ſ뱸��
				</td>
			</c:if>
					
		
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${purchase.receiverName}</td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${purchase.receiverPhone}</td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${purchase.divyAddr}</td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${purchase.divyRequest}</td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${purchase.divyDate}</td>
	</tr>
</table>


</body>
</html>
