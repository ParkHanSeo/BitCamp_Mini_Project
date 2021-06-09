<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
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
		// /purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2
		$('.tranCode').on("click", function(){
			alert("1");
			self.location="/purchase/updateTranCodeByProd?prodNo="+$(this).attr('prodNo')+"&"+$(this).attr('tranNo')+"=2";
		});
		
		$( "td:contains('����ϱ�')" ).on("click" , function() {
			
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
												+"��ǰ��ȣ	 : "+JSONData.prodNo+"<br/>"
												+"��ǰ�̸� : "+JSONData.prodName+"<br/>"
												+"������ : "+JSONData.prodDetail+"<br/>"
												+"����    : "+JSONData.price+"<br/>"
												+"�����   : "+JSONData.manuDate+"<br/>"
												+"�̹���  : "+JSONData.fileName+"<br/>"
												+"</h6>";
												
							//Debug...	
							//alert(displayValue);
							$("h6").remove();
							$( "#"+prodNo+"" ).html(displayValue);
							
						}	
				
			  });
			
			
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

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<div class="page-header text-info">
	       <h3>��ǰ�����ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
								<option value="0" ${ search.searchCondition eq '0' ? 'selected' : '' }>��ǰ��ȣ</option>
								<option value="1" ${ search.searchCondition eq '1' ? 'selected' : '' }>��ǰ��</option>
								<option value="2" ${ search.searchCondition eq '2' ? 'selected' : '' }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">�������</th>
            <th align="left">��������</th>
          </tr>
        </thead>      
      
      
      
		<tbody class="ct_list_pop">
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : ��ǰ������">
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
