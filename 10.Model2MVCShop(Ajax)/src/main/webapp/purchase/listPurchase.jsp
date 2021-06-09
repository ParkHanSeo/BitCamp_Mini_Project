<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
<%@ page import="java.util.*"%>
<%@ page import="com.model2.mvc.common.*"%>
<%@ page import="com.model2.mvc.service.domain.*"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>

<%
	List<Purchase> list= (List<Purchase>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	
	Search search = (Search)request.getAttribute("search");
	//==> null �� ""(nullString)���� ����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
 --%>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("input[name='currentPage']").val(currentPage)
		//document.detailForm.submit();
		$("form[name='detailForm']").attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	$(function(){
		
		$('.tranNo').on("click" ,function(){
			//self.location="/purchase/getPurchase?tranNo="+$(this).attr('tranNo');
			
			var tranNo = $(this).attr('tranNo');
			
			$.ajax(
					{
						url : "/purchase/json/getPurchase/"+tranNo ,
						method : "GET" ,
						dataType : "json" , 
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							alert(status);
							
							var displayValue = "<h3>"
											 +"��ǰ��ȣ : "+JSONData.tranNo+"<br/>"
											 +"�����ھ��̵� : "+JSONData.buyer.userId+"<br/>"
											 +"���Ź�� : "+JSONData.paymentOption+"<br/>"
											 +"�������̸� : "+JSONData.receiverName+"<br/>"
											 +"�����ڿ���ó : "+JSONData.receiverPhone+"<br/>"
											 +"�������ּ� : "+JSONData.divyAddr+"<br/>"
											 +"���ſ�û���� : "+JSONData.divyRequest+"<br/>"
											 +"</h3>";
						//alert(displayValue);
						$("h3").remove();
						$( "#"+tranNo+"" ).html(displayValue);
							
					}
			});
					
			
		});
		
		
		
		
		
		$('.buyerId').on('click', function(){
			self.location="/user/getUser?userId="+$(this).attr('buyerId');
		})
		
		
		/*
		$(".ct_list_pop td:nth-child(1)").on("click", function(){
			
			self.location=$('.tranNo',$(this)).text();
			
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			
			self.location=$('.buyerId',$(this)).text();
			
		});*/
		
	});
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >
			��ü ${ resultPage.totalCount } �Ǽ�, ����  ${ resultPage.currentPage } ������
		</td>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
		<c:forEach var="purchase" items="${list}">
	<c:set var="i" value="${ i+1 }" />
	
	<tr class="ct_list_pop">
		<td align="center">
			<div class="tranNo" tranNo="${purchase.tranNo}">${ i }</div>
			<!-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${ i }</a> -->
		</td>
		<td></td>
		<td align="left">
			
			<div class="buyerId" buyerId="${purchase.buyer.userId}">${purchase.buyer.userId}</div>
			<!-- <a href="/user/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a> -->
		</td>
		<td></td>
		<td align="left">${purchase.receiverName}</td>
		<td></td>
		<td align="left">${purchase.receiverPhone}</td>
		<td></td>
		<td align="left">
						<c:choose>
							<c:when test="${ purchase.tranCode eq '1  ' }">
								���ſϷ��� ��ǰ�̸� ��� �غ����Դϴ�.
							</c:when>
							<c:when test="${ purchase.tranCode eq '2  ' }">
								��ǰ�� ������Դϴ�.
							</c:when>
							<c:when test="${ purchase.tranCode eq '3  ' }">
								��ǰ ���� �Ϸ�Ǿ����ϴ�.
							</c:when>
						</c:choose>
		</td>
		<td></td>		
			
			<td align="left">
			  <c:if test="${ purchase.tranCode eq '2  ' }">
				<a href="updateTranCode?tranNo=${purchase.tranNo}&tranCode=3"/>���� Ȯ��</a>
			  </c:if>
			</td>
			
	</tr>
	<tr>
		<td id="${purchase.tranNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
	
	</c:forEach>
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
			
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>