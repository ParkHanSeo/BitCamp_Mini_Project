<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src = "//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
       
 	<script>
 	$("#kakao-login-btn").on("click", function(){
 	    //1. 로그인 시도
 	    Kakao.Auth.login({
 	        success: function(authObj) {
 	          //console.log(JSON.stringify(authObj));
 	          //console.log(Kakao.Auth.getAccessToken());
 	        
 	          //2. 로그인 성공시, API를 호출합니다.
 	          Kakao.API.request({
 	            url: '/v1/user/me',
 	            success: function(res) {
 	              //console.log(JSON.stringify(res));
 	              res.id += "@k";
 	              
 	              $.ajax({
 	                  url : "/user/json/checkDuplication/"+res.id,
 	                  headers : {
 	                      "Accept" : "application/json",
 	                      "Content-Type" : "application/json"
 	                    },
 	                    success : function(idChk){ 	                       
 
 	                    }
 	              })
 	            },
 	            fail: function(error) {
 	              alert(JSON.stringify(error));
 	            }
 	          });
 	                  
 	        },
 	        fail: function(err) {
 	          alert(JSON.stringify(err));
 	        }
 	      });
 	        
 	})//e.o.kakao

 	</script>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});	
		
		
		//============= 회원원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				self.location = "/user/addUser"
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
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					    </div>
					  </div>
					 
					 

					  <!-- 카카오 로그인 추가 -->
					  <div id="kakaoLogin" align="center">
   							 <a id="kakao-login-btn"></a>
   							 <a href="http://developers.kakao.com/logout">Logout</a>
   						 <script type='text/javascript'>
        
        					// 사용할 앱의 JavaScript 키를 설정해 주세요.
       						 Kakao.init('defe9721bc05213a26b386a3b930f90b');
       						 // 카카오 로그인 버튼을 생성합니다.
        					Kakao.Auth.createLoginButton({
        				    container: '#kakao-login-btn',
          				  	success: function (authObj) {
                				alert(JSON.stringify(authObj));
            				},
           	 				fail: function (err) {
                			alert(JSON.stringify(err));
            				}
        				});
      					//]]>
    					</script>
					  </div>
					  
					  	
					</form>
			   	 </div>
			
			</div>
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>