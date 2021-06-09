<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>    
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
	
<script type="text/javascript">



	
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddProduct();
			});
		});	
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
		
		function fncAddProduct(){
			//Form 유효성 검증
		 	//var name = document.detailForm.prodName.value;
			//var detail = document.detailForm.prodDetail.value;
			//var manuDate = document.detailForm.manuDate.value;
			//var price = document.detailForm.price.value;
		
			var name = $("input[name='prodName']").val();
			var detail = $("input[name='prodDetail']").val();
			var manuDate = $("input[name='manuDate']").val();
			var price = $("input[name='price']").val();
			
			if(name == null || name.length<1){
				alert("상품명은 반드시 입력하여야 합니다.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("상품상세정보는 반드시 입력하여야 합니다.");
				return;
			}
			if(manuDate == null || manuDate.length<1){
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if(price == null || price.length<1){
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}
		
			$("form").attr("method", "POST").attr("action", "/product/addProduct").submit();
			
		}
//	$( function() {
//		    $( "#manuDate" ).datepicker();
//	});


</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp"><strong>Model2 MVC Shop</strong></a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
	<div class="container">
		
		<h1 class="bg-primary text-center">상 품 등 록</h1>
	
	

<form class="form-horizontal" method="post" name="addProduct" enctype="multipart/form-data">
  <!-- 상품명 -->
  <div class="form-group">
    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
    <div class="col-sm-4">
      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명을 입력하세요">
    </div>
  </div>
  <!-- 상품상세정보 -->
  <div class="form-group">
    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
    <div class="col-sm-4">
      <input type="text" class="form-control" name="prodDetail" placeholder="상품상세정보">
    </div>
  </div>
  <!-- 제조일자 -->
   <div class="form-group">
    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		      <img src="../images/ct_icon_date.gif" width="15" height="15" 
			onclick="show_calendar('document.addProduct.manuDate', document.addProduct.manuDate.value)"/>
    <div class="col-sm-4">
      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="제조일자">
    </div>
  </div>
  
  <!-- 가격 -->
   <div class="form-group">
    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
    <div class="col-sm-4">
      <input type="text" class="form-control" id="price" name="price" placeholder="가격">
    </div>
  </div>
  <!-- 상품이미지 -->
	<div class="form-group">
		<label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		<div class="col-sm-4">
			<input type="file" class="form-control" id="fileUpload" name="fileUpload">
		</div>
	</div>  
  
  <div class="form-group">
	<div class="col-sm-offset-4  col-sm-4 text-center">
		<button type="button" class="btn btn-primary"  >등&nbsp;록</button>
		  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
	</div>
  </div>
</form>

</div>
</body>
</html>