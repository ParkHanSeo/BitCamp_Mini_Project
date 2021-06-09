<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lane="ko">
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<meta charset="EUC-KR">
	
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->

	<script type="text/javascript" src="../javascript/calendar.js">
	</script>
	<script type="text/javascript">
	function fncUpdatePurchase(){	
		
		$("form[name='updatePurchase']").attr("method", "POST").attr("action","/purchase/updatePurchase").submit();
	}
	
	$(function(){
		
		$( "button[name='change']" ).on("click" , function() {
			fncUpdatePurchase()
		});
		
		$( "button[name='cancel']" ).on("click" , function() {
			history.go(-1)
		});		
		
	});
	
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">구매정보수정</h3>
	       <h5 class="text-muted">구매한 물품의정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
	    </div>		
		
		<!-- form Start /////////////////////////////////////-->	
		<form class="form-horizontal" name="updatePurchase">
		
		<input type="hidden" name="tranNo" value="${ purchase.tranNo }"/>
		
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
		      <input type="buyerId" class="form-control" id="buyerId" name="buyerId" value="${ purchase.buyer.userId }" >
		    </div>
		  </div>		
		
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-4">
			<select name="paymentOption" class="form-control" id="paymentOption" name="paymentOption" >
								  
				<option value="1" ${ purchase.paymentOption eq '1' ? 'paymentOption' : '' }>현금구매</option>
				<option value="2" ${ purchase.paymentOption eq '2' ? 'paymentOption' : '' }>신용구매</option>
				
			</select>
		    </div>
		  </div>		

		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		      <input type="receiverName" class="form-control" id="receiverName" name="receiverName" value="${ purchase.receiverName }" >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-4">
		      <input type="receiverPhone" class="form-control" id="receiverPhone" name="receiverPhone" value="${ purchase.receiverPhone }">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		      <input type="divyAddr" class="form-control" id="divyAddr" name="divyAddr" value="${ purchase.divyAddr }">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매자요청사항</label>
		    <div class="col-sm-4">
		      <input type="divyRequest" class="form-control" id="divyRequest" name="divyRequest" value="${ purchase.divyRequest }">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
			      <img src="../images/ct_icon_date.gif" width="15" height="15" 
					onclick="show_calendar('document.updatePurchase.divyDate', document.updatePurchase.divyDate.value)"/>		    
		    <div class="col-sm-4">
		      <input type="divyDate" class="form-control" id="divyDate" name="divyDate"  placeholder="배송희망일자">
		    </div>
		  </div>		  		  		  		  
		
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" name="change"  >수 &nbsp;정</button>
			  <button type="button" class="btn btn-primary" name="cancel" >취 &nbsp;소</button>			  
		    </div>
		  </div>		
		
		</form>
	</div>

</body>
</html>