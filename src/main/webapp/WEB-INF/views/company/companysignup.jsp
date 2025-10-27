<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"  href="/css/common2.css" />
    <title>기업 등록</title>
    <script src="https://code.jquery.com/jquery.min.js"></script>
<style>
input[type="submit"],
input[type="button"] {
  width: 100%; 
}
</style>
</head>

<body>
	<img src="/img/로고.png"  alt=회사로고 onclick="location.href='/'"/>
	<div class="container">
	<h2>기업 등록</h2>
	<form action="/Company/CompanySignupForm" method="POST" enctype="multipart/form-data">
		<table>
			<tr>
            	<td colspan="2">
            	<input type="text" name="compname" placeholder="*기업명" required />
            	<input type="button"  id="dupCheck2"   value="중복확인" />
            	<span id="dupResult2"></span>
            	</td>
            </tr>
            <tr>
            	<td colspan="2">
            	<input type="text" name="ceo" placeholder="*대표이사" required />
            	</td>
            </tr>
            <tr>
            	<td colspan="2">
            	<input type="text" name="phone_number" placeholder="*전화번호" required />
            	</td>
            </tr>
            <tr>
            	<td colspan="2">
            	<input type="text" name="address" placeholder="*주소" required />
            	</td>
            </tr>
            <tr>
            	<td colspan="2">
            	<input type="text" name="business_type" placeholder="업종"  />
            	</td>
            </tr>
            <tr>
    			<td colspan="2">
        		<input type="file" id="logo" name="logo" accept="image/*" required />
        		<small style="color: gray;">* 로고 이미지 등록(최대 2MB, JPG, PNG 형식만 가능)</small>
    			</td>
			</tr>
            <tr>
            	<td>
                <input type="submit" value="등록하기" />
                </td>
                <td>
                <input type="button" value="돌아가기" id="goLogin" />
            	</td>
            </tr>
		</table>
	</form>
 </div>
 <script>
 	let   dupCheck2Clicked = false;
 	
 	document.getElementById('goLogin').onclick = function() {
        location.href = '/Company/Signup';
    };
    
 	const  formEl          = document.querySelector('form');
 	const  compnameEl      = document.querySelector('[name=compname]');
 	const  dupCheck2El     = document.querySelector('#dupCheck2');
 	
 	dupCheck2El.onclick = function() {
 	   dupCheck2Clicked = true;  
    }
 	
 	formEl.onsubmit = function() {
 		
 		if (dupCheck2Clicked === false) {
            alert('중복확인을 해주세요');
            return false;
        }
 		alert('기업 등록이 완료되었습니다.');
        return true;           
    };
    </script>
    
    <script>
    	$( function() {
 	  	$('#dupCheck2').on('click', function() {  	   
 	   	const compname = $('[name=compname]').val().trim();
        if (compname === '') {
            alert('기업명을 입력하세요'); 
            $('[name=compname]').focus(); 
            return; 
        }

        	   $.ajax({
                   url  : '/Company/CompDupCheck', 
                   data : { compname : $('[name=compname]').val()  }  
               })
               .done( function( data ) {   
                   console.log(data)
                   if( data == '' ) {
                     let html = '등록 가능한 기업입니다.'; 
                     dupCheck2Clicked = true;
                     $('#dupResult2').html(html).addClass('green')
                   }  else  {  
                     let html = '이미 등록된 기업입니다.'
                     dupCheck2Clicked = false;
                   	 $('#dupResult2').html(html).addClass('red')
                   }
               })
               .fail( function(err) {
                   console.log(err)
                   alert('오류:다시 시도해주세요.');
               })
           })
       });  
    </script>
</body>
</html>