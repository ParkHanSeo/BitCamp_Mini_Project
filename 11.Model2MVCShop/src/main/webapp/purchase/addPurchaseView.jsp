<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
<%@ page import="com.model2.mvc.service.domain.*"%>
<%
	Product product = (Product) request.getAttribute("product");
%>
<%
	User user = (User) session.getAttribute("user");
%>
 --%>
<html>
<head>
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>

	<script type="text/javascript" src="../javascript/calendar.js">
	
	</script>

	<script type="text/javascript">
	
	
		function fncAddPurchase(){
		
			$("form[name='addPurchase']").attr("method", "POST").attr("action" , "/purchase/addPurchase").submit();
		}

	
	
	$(function(){
		
		$("td.ct_btn01:contains('구매')").on("click",function(){
			
			fncAddPurchase();
			
		});
		
		$("td.ct_btn01:contains('취소')").on("click",function(){
			
			javascript:history.go(-1);
			
		});
		
		$( "button[name='buy']" ).on("click" , function() {
			fncAddPurchase()
		});
		
		$( "button[name='cancel']" ).on("click" , function() {
			history.go(-1)
		});
		
	});
	
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<h1 class="bg-primary text-center">구 매 등 록</h1>

<form class="form-horizontal" name="addPurchase">
<input type="hidden" name="prodNo" value="${product.prodNo}"/>	

  <div class="form-group">
    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
    <div class="col-sm-4">
      <input type="prodNo" class="form-control" id="prodNo" name="prodNo" value="${product.prodNo }">
    </div>
  </div>
  <!-- 상품명 -->
  <div class="form-group">
    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
    <div class="col-sm-4">
      <input type="prodName" class="form-control" id="prodName" name="prodName" value="${product.prodName }">
    </div>
  </div>
  <!-- 상품상세정보 -->
  <div class="form-group">
    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
    <div class="col-sm-4">
      <input type="prodDetail" class="form-control" name="prodDetail" value="${product.prodDetail}">
    </div>
  </div> 
  <!-- 제조일자 -->
   <div class="form-group">
    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
    <div class="col-sm-4">
      <input type="manuDate" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}">
    </div>
  </div>  
  <!-- 가격 -->
   <div class="form-group">
    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
    <div class="col-sm-4">
      <input type="price" class="form-control" id="price" name="price" value="${product.price}">
    </div>
  </div>  
  <!-- 등록일자 -->
   <div class="form-group">
    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
    <div class="col-sm-4">
      <input type="regDate" class="form-control" id="regDate" name="regDate" value="${product.regDate}">
    </div>
  </div>
  <!-- 구매자아이디 -->
   <div class="form-group">
    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
    <div class="col-sm-4">
      <input type="buyerId" class="form-control" id="buyerId" name="buyerId" value="${user.userId}">
    </div>
  </div>  
  <!-- 구매방법 -->
   <div class="form-group">
    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
    <div class="col-sm-4">
				<select type="paymentOption" class="form-control" id="paymentOption" name="paymentOption">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
				</select>
    </div>
  </div>       
  <!-- 구매자이름 -->
  <div class="form-group">
    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
    <div class="col-sm-4">
      <input type="receiverName" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
    </div>
  </div>
  <!-- 구매자연락처 -->
  <div class="form-group">
    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
    <div class="col-sm-4">
      <input type="receiverPhone" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
    </div>
  </div> 
  <!-- 구매자주소 -->
  <div class="form-group">
    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
    <div class="col-sm-4">
      <input type="divyAddr" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
    </div>
  </div>
  <!-- 구매요청사항 -->
  <div class="form-group">
    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
    <div class="col-sm-4">
      <input type="divyRequest" class="form-control" id="divyRequest" name="divyRequest" placeholder="요청사항을 입력하세요">
    </div>
  </div>
  <!-- 배송희망일자 -->
  <div class="form-group">
    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
    <img src="../images/ct_icon_date.gif" width="15" height="15" 
			onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/>
    <div class="col-sm-4">
      <input type="divyDate" class="form-control" id="divyDate" name="divyDate" placeholder="배송희망일자 선택">
    </div>
  </div>         

  <div class="form-group">
	 <div class="col-sm-offset-4  col-sm-4 text-center">
		 <button type="button" class="btn btn-primary" name="buy" >구 &nbsp;매</button>
		 <button type="button" class="btn btn-primary" name="cancel"  >취 &nbsp;소</button>
	 </div>
  </div>
</form>
		
	</div>
	
</body>
</html>