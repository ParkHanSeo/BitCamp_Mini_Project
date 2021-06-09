<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
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
	//=====기존Code 주석 처리 후  jQuery 변경 ======//
// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;	
		$("input[name='currentPage']").val(currentPage)
		//document.detailForm.submit();
		$("form[name='detailForm']").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${! empty menu && menu == 'manage' ? 'manage' : 'search'}").submit();
			
	}

	
	$(function(){
		// 검색
		$( "td.ct_btn01:contains('검색')").on("click", function(){
			fncGetList(1);
		});
		
		
		//menager&search
		$('.manage').on('click',function(){
			
			self.location ="/product/updateProductView?prodNo="+$(this).attr('prodNo');
			
		});
	
		$('.search').on('click',function(){
			
			self.location ="/product/getProduct?prodNo="+$(this).attr('prodNo');
			
		});
		// /purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2
		$('.tranCode').on("click", function(){
			alert("1");
			self.location="/purchase/updateTranCodeByProd?prodNo="+$(this).attr('prodNo')+"&"+$(this).attr('tranNo')+"=2";
		});
		
		$( "td:contains('배송하기')" ).on("click" , function() {
			
			//Debug..
			//alert(  $("input:hidden[name='prodNo']",$(this)).val() );
			//self.location ="/product/getProduct?prodNo="+prodNo; //$(this).text().trim()
			//alert($('.hidden_link', $(this)).text());
			self.location=$('.hidden_link', $(this)).text();
		
		});	
		
		$(  "td:nth-child(6) > i" ).on("click" , function() {
			
			//self.location=$('.product', $(this)).text();
			var prodNo =  $(this).next().val();
			
			$.ajax(
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							//Debug...
							//alert(prodNo);
							//Debug...
							//alert("JSONData.fileName : \n"+JSONData);
							
							var displayValue = "<h6>"
												+"상품번호	 : "+JSONData.prodNo+"<br/>"
												+"상품이름 : "+JSONData.prodName+"<br/>"
												+"상세정보 : "+JSONData.prodDetail+"<br/>"
												+"가격    : "+JSONData.price+"<br/>"
												+"등록일   : "+JSONData.manuDate+"<br/>"
												+"이미지  : "+JSONData.fileName+"<br/>"
												+"</h6>";
												
							//Debug...	
							//alert(displayValue);
							$("h6").remove();
							$( "#"+prodNo+"" ).html(displayValue);
							
						}	
				
			  });
			
			
		});
		
		$(".ct_list_pop td:contains('배송하기')").on("click", function(){
			
			self.location=$('.tranCode', $(this)).text();
			
		});
		

		
		//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
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
	       <h3>상품목록조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
								<option value="0" ${ search.searchCondition eq '0' ? 'selected' : '' }>상품번호</option>
								<option value="1" ${ search.searchCondition eq '1' ? 'selected' : '' }>상품명</option>
								<option value="2" ${ search.searchCondition eq '2' ? 'selected' : '' }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>      
      
      
      
		<tbody class="ct_list_pop">
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 상품상세정보">
		<c:if test="${menu=='manage'}">
				
				<div class="manage" prodNo="${product.prodNo}">${product.prodName}</div>
		<!--<a href="/product/updateProductView?prodNo=${product.prodNo}&${! empty menu && menu == 'manage' ? 'menu=manage' : 'menu=search'}">${product.prodName} </a> -->	
		</c:if>
		<c:if test="${menu=='search'}">
				
				<div class="search" prodNo="${product.prodNo}">${product.prodName}</div>
		<!-- <a href="/product/getProduct?prodNo=${product.prodNo}&${! empty menu && menu == 'search' ? 'menu=search' : 'menu=manage'}">${product.prodName} </a>-->	
		</c:if>
			 </td>
			  <td align="left">${product.price}</td>
			  <td align="left">${product.regDate}</td>
			  <td align="left">
						<c:if test="${ user.role eq 'admin' && menu eq 'manage' }"> 
							<c:choose>
								<c:when test="${product.proTranCode == null}">
									판매중
								</c:when>
								<c:when test="${ product.proTranCode eq '1  ' }">
									결제완료
									<!-- <a href="/purchase/updateTranCodeByProd?prodNo=${ product.prodNo }&tranCode=2">배송하기</a> -->
									<div style="display : none" class="tranCode">/purchase/updateTranCodeByProd?prodNo=${ product.prodNo }&tranCode=2</div>
									배송하기
								</c:when>
								<c:when test="${ product.proTranCode eq '2  ' }">
									배송중
								</c:when>
								<c:when test="${ product.proTranCode eq '3  ' }">
									배송완료
								</c:when>
			               </c:choose>
		               </c:if>
		               <c:if test="${!( user.role eq 'admin' && menu eq 'manage' )}"> 
		                   <c:choose>
								<c:when test="${empty product.proTranCode }">
									판매중
								</c:when>
								<c:otherwise>
									재고없음
								</c:otherwise>
							</c:choose> 
		               </c:if>
			 </td>			  
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  	<input type="hidden" value="${product.prodNo}">
			  </td>			  
			  
			</tr>
          </c:forEach>
        
        </tbody>
		
		</table>
		
	</div>

	 <!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>
