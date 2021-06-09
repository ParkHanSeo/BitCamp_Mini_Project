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
	<meta charset = "EUC-KR">
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>  
  
  <!--  ///////////////////////// JavaScript ////////////////////////// -->

<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("input[name='currentPage']").val(currentPage)
		//document.detailForm.submit();
		$("form[name='detailForm']").attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	$(function(){
		
		$(  "td:nth-child(6) > i" ).on("click" , function() {
			//self.location="/purchase/getPurchase?tranNo="+$(this).attr('tranNo');
			
			var tranNo = $(this).next().val();
			
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
							//alert(status);
							
							var displayValue = "<h6>"
											 +"��ǰ��ȣ    : "+JSONData.tranNo+"<br/>"
											 +"�����ھ��̵� : "+JSONData.buyer.userId+"<br/>"
											 +"���Ź��    : "+JSONData.paymentOption+"<br/>"
											 +"�������̸�   : "+JSONData.receiverName+"<br/>"
											 +"�����ڿ���ó : "+JSONData.receiverPhone+"<br/>"
											 +"�������ּ�   : "+JSONData.divyAddr+"<br/>"
											 +"���ſ�û���� : "+JSONData.divyRequest+"<br/>"
											 +"</h6>";
						//alert(displayValue);
						$("h6").remove();
						$( "#"+tranNo+"" ).html(displayValue);
							
					}
			});
					
			
		});
		
		
		$('.tranNo').on('click', function(){
			self.location="/purchase/getPurchase?tranNo="+$(this).attr('tranNo');
		});			
		
		
		$('.buyerId').on('click', function(){
			self.location="/user/getUser?userId="+$(this).attr('buyerId');
		});
		

		
		
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

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<div class="page-header text-info">
	       <h3>���Ÿ����ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
		<div class="row">
		
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>		
		
		</div>
		
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">			    				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>		
		
	  <table class="table table-hover table-striped" >
		
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >ȸ��ID</th>
            <th align="left">ȸ����</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">�����Ȳ</th>
            <th align="left">��������</th>
          </tr>
        </thead>
        
        <tbody>
        
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">
				  <div class="tranNo" tranNo="${purchase.tranNo}">${ i }</div>
				  <!-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${ i }</a> -->
			  </td>
			  <td align="left"  title="Click : ȸ������ Ȯ��">
			  	  <div class="buyerId" buyerId="${purchase.buyer.userId}">${purchase.buyer.userId}</div>
			  </td>
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
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
			  
			  	<c:if test="${ purchase.tranCode eq '2  ' }">
					<a href="updateTranCode?tranNo=${purchase.tranNo}&tranCode=3"/>���� Ȯ��</a>
			  	</c:if>
			   </td>
			  			  
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}"></i>
			  	<input type="hidden" value="${purchase.tranNo}">
			  </td>
			</tr>
          </c:forEach>       
        
        </tbody>  		
		
	  </table>
	  
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	  	
</body>
</html>