<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset = "EUC-KR">
	<title>��ǰ �����ȸ</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	//=====����Code �ּ� ó�� ��  jQuery ���� ======//
// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;	
		$("input[name='currentPage']").val(currentPage)
		//document.detailForm.submit();
		$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${! empty menu && menu == 'manage' ? 'manage' : 'search'}").submit();
			
	}

	
	$(function(){
		// �˻�
		$( "td.ct_btn01:contains('�˻�')").on("click", function(){
			fncGetList(1);
		});
		
		
		//menager&search
	
		$('.manage').on('click',function(){
			
			self.location ="/product/updateProductView?prodNo="+$(this).attr('prodNo');
			
		});
	
		$('.search').on('click',function(){
			
			self.location ="/product/getProduct?prodNo="+$(this).attr('prodNo');
			
		});
		
		
		
		$(".ct_list_pop td:contains('����ϱ�')").on("click", function(){
			
			self.location=$('.tranCode', $(this)).text();
			
		});
		
		//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
	});
	
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${! empty menu && menu == 'manage' ? 'manage' : 'search'}"  method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					
					<td width="93%" class="ct_ttl-01">${!empty menu && menu == 'manage' ? "��ǰ����" : "��ǰ�����ȸ"}</td>
							
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
								<option value="0" ${ search.searchCondition eq '0' ? 'selected' : '' }>��ǰ��ȣ</option>
								<option value="1" ${ search.searchCondition eq '1' ? 'selected' : '' }>��ǰ��</option>
								<option value="2" ${ search.searchCondition eq '2' ? 'selected' : '' }>��ǰ����</option>
			</select>
			<input 	type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
						class="ct_input_g"  style="width:200px; height:20px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
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
			��ü ${ resultPage.totalCount } �Ǽ�, ����  ${ resultPage.currentPage } ������
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">
			��ǰ��<br>
			<h7>(name click:������)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
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
				
				<div class="manage" prodNo="${product.prodNo}">${product.prodName}</div>
		<!--<a href="/product/updateProductView?prodNo=${product.prodNo}&${! empty menu && menu == 'manage' ? 'menu=manage' : 'menu=search'}">${product.prodName} </a> -->	
		</c:if>
		<c:if test="${menu=='search'}">
				
				<div class="search" prodNo="${product.prodNo}">${product.prodName}</div>
		<!-- <a href="/product/getProduct?prodNo=${product.prodNo}&${! empty menu && menu == 'search' ? 'menu=search' : 'menu=manage'}">${product.prodName} </a>-->	
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
								<c:when test="${product.proTranCode == null}">
									�Ǹ���
								</c:when>
								<c:when test="${ product.proTranCode eq '1  ' }">
									�����Ϸ�
									<!-- <a href="/purchase/updateTranCodeByProd?prodNo=${ product.prodNo }&tranCode=2">����ϱ�</a> -->
									<div style="display : none" class="tranCode">/purchase/updateTranCodeByProd?prodNo=${ product.prodNo }&tranCode=2</div>
									����ϱ�
								</c:when>
								<c:when test="${ product.proTranCode eq '2  ' }">
									�����
								</c:when>
								<c:when test="${ product.proTranCode eq '3  ' }">
									��ۿϷ�
								</c:when>
			               </c:choose>
		               </c:if>
		               <c:if test="${!( user.role eq 'admin' && menu eq 'manage' )}"> 
		                   <c:choose>
								<c:when test="${empty product.proTranCode }">
									�Ǹ���
								</c:when>
								<c:otherwise>
									������
								</c:otherwise>
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
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
