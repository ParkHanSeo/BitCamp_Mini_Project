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
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
 --%>

<html>
<head>
	<meta charset = "EUC-KR">
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>  
  
  <!--  ///////////////////////// JavaScript ////////////////////////// -->

<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
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
											 +"물품번호    : "+JSONData.tranNo+"<br/>"
											 +"구매자아이디 : "+JSONData.buyer.userId+"<br/>"
											 +"구매방법    : "+JSONData.paymentOption+"<br/>"
											 +"구매자이름   : "+JSONData.receiverName+"<br/>"
											 +"구매자연락처 : "+JSONData.receiverPhone+"<br/>"
											 +"구매자주소   : "+JSONData.divyAddr+"<br/>"
											 +"구매요청사항 : "+JSONData.divyRequest+"<br/>"
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
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<div class="page-header text-info">
	       <h3>구매목록조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<div class="row">
		
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>		
		
		</div>
		
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">			    				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>		
		
	  <table class="table table-hover table-striped" >
		
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >회원ID</th>
            <th align="left">회원명</th>
            <th align="left">전화번호</th>
            <th align="left">배송현황</th>
            <th align="left">간략정보</th>
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
			  <td align="left"  title="Click : 회원정보 확인">
			  	  <div class="buyerId" buyerId="${purchase.buyer.userId}">${purchase.buyer.userId}</div>
			  </td>
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
			  <td align="left">
						<c:choose>
							<c:when test="${ purchase.tranCode eq '1  ' }">
								구매완료한 상품이며 배송 준비중입니다.
							</c:when>
							<c:when test="${ purchase.tranCode eq '2  ' }">
								상품이 배송중입니다.
							</c:when>
							<c:when test="${ purchase.tranCode eq '3  ' }">
								상품 수령 완료되었습니다.
							</c:when>
						</c:choose>
			  
			  	<c:if test="${ purchase.tranCode eq '2  ' }">
					<a href="updateTranCode?tranNo=${purchase.tranNo}&tranCode=3"/>수령 확인</a>
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
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	  	
</body>
</html>