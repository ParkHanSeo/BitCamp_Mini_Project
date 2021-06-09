<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>











<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
<!--
function fncGetProductList(){
	document.detailForm.submit();
}
-->
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listProduct.do?menu=manage" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
							상품 관리
					
					</td>
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
				<option value="0">상품번호</option>
				<option value="1">상품명</option>
				<option value="2">상품가격</option>
			</select>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList();">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 180 건수, 현재 1 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
		
	<tr class="ct_list_pop">
		<td align="center">3</td>
		<td></td>
				
				<td align="left"><a href="/getProduct.do?prodNo=10000&menu=manage">가나초콜릿</a></td>
		
		<td></td>
		<td align="left">99</td>
		<td></td>
		<td align="left">2012-12-14</td>
		<td></td>
		<td align="left">
		
			구매완료
		
					<a href="/updateTranCodeByProd.do?prodNo=10000&tranCode=2">배송하기</a>
		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	
	<tr class="ct_list_pop">
		<td align="center">2</td>
		<td></td>
				
				<td align="left"><a href="/getProduct.do?prodNo=10000&menu=manage">가나초콜릿</a></td>
		
		<td></td>
		<td align="left">99</td>
		<td></td>
		<td align="left">2012-12-14</td>
		<td></td>
		<td align="left">
		
			배송중
		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	
	<tr class="ct_list_pop">
		<td align="center">1</td>
		<td></td>
				
				<td align="left"><a href="/getProduct.do?prodNo=10000&menu=manage">가나초콜릿</a></td>
		
		<td></td>
		<td align="left">99</td>
		<td></td>
		<td align="left">2012-12-14</td>
		<td></td>
		<td align="left">
		
			구매완료
		
					<a href="/updateTranCodeByProd.do?prodNo=10000&tranCode=2">배송하기</a>
		
		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		
			<a href="/listProduct.do?page=1&menu=manage">1</a>
		
			<a href="/listProduct.do?page=2&menu=manage">2</a>
		
			<a href="/listProduct.do?page=3&menu=manage">3</a>
		
			<a href="/listProduct.do?page=4&menu=manage">4</a>
		
			<a href="/listProduct.do?page=5&menu=manage">5</a>
		
			<a href="/listProduct.do?page=6&menu=manage">6</a>
		
			<a href="/listProduct.do?page=7&menu=manage">7</a>
		
			<a href="/listProduct.do?page=8&menu=manage">8</a>
		
			<a href="/listProduct.do?page=9&menu=manage">9</a>
		
			<a href="/listProduct.do?page=10&menu=manage">10</a>
		
			<a href="/listProduct.do?page=11&menu=manage">11</a>
		
			<a href="/listProduct.do?page=12&menu=manage">12</a>
		
			<a href="/listProduct.do?page=13&menu=manage">13</a>
		
			<a href="/listProduct.do?page=14&menu=manage">14</a>
		
			<a href="/listProduct.do?page=15&menu=manage">15</a>
		
			<a href="/listProduct.do?page=16&menu=manage">16</a>
		
			<a href="/listProduct.do?page=17&menu=manage">17</a>
		
			<a href="/listProduct.do?page=18&menu=manage">18</a>
		
			<a href="/listProduct.do?page=19&menu=manage">19</a>
		
			<a href="/listProduct.do?page=20&menu=manage">20</a>
		
			<a href="/listProduct.do?page=21&menu=manage">21</a>
		
			<a href="/listProduct.do?page=22&menu=manage">22</a>
		
			<a href="/listProduct.do?page=23&menu=manage">23</a>
		
			<a href="/listProduct.do?page=24&menu=manage">24</a>
		
			<a href="/listProduct.do?page=25&menu=manage">25</a>
		
			<a href="/listProduct.do?page=26&menu=manage">26</a>
		
			<a href="/listProduct.do?page=27&menu=manage">27</a>
		
			<a href="/listProduct.do?page=28&menu=manage">28</a>
		
			<a href="/listProduct.do?page=29&menu=manage">29</a>
		
			<a href="/listProduct.do?page=30&menu=manage">30</a>
		
			<a href="/listProduct.do?page=31&menu=manage">31</a>
		
			<a href="/listProduct.do?page=32&menu=manage">32</a>
		
			<a href="/listProduct.do?page=33&menu=manage">33</a>
		
			<a href="/listProduct.do?page=34&menu=manage">34</a>
		
			<a href="/listProduct.do?page=35&menu=manage">35</a>
		
			<a href="/listProduct.do?page=36&menu=manage">36</a>
		
			<a href="/listProduct.do?page=37&menu=manage">37</a>
		
			<a href="/listProduct.do?page=38&menu=manage">38</a>
		
			<a href="/listProduct.do?page=39&menu=manage">39</a>
		
			<a href="/listProduct.do?page=40&menu=manage">40</a>
		
			<a href="/listProduct.do?page=41&menu=manage">41</a>
		
			<a href="/listProduct.do?page=42&menu=manage">42</a>
		
			<a href="/listProduct.do?page=43&menu=manage">43</a>
		
			<a href="/listProduct.do?page=44&menu=manage">44</a>
		
			<a href="/listProduct.do?page=45&menu=manage">45</a>
		
			<a href="/listProduct.do?page=46&menu=manage">46</a>
		
			<a href="/listProduct.do?page=47&menu=manage">47</a>
		
			<a href="/listProduct.do?page=48&menu=manage">48</a>
		
			<a href="/listProduct.do?page=49&menu=manage">49</a>
		
			<a href="/listProduct.do?page=50&menu=manage">50</a>
		
			<a href="/listProduct.do?page=51&menu=manage">51</a>
		
			<a href="/listProduct.do?page=52&menu=manage">52</a>
		
			<a href="/listProduct.do?page=53&menu=manage">53</a>
		
			<a href="/listProduct.do?page=54&menu=manage">54</a>
		
			<a href="/listProduct.do?page=55&menu=manage">55</a>
		
			<a href="/listProduct.do?page=56&menu=manage">56</a>
		
			<a href="/listProduct.do?page=57&menu=manage">57</a>
		
			<a href="/listProduct.do?page=58&menu=manage">58</a>
		
			<a href="/listProduct.do?page=59&menu=manage">59</a>
		
			<a href="/listProduct.do?page=60&menu=manage">60</a>
		
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
